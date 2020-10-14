package utils.compression.as3zlib
{
	
	
	public final class InfCodes {
	
		static private const inflate_mask:Array = new Array (
			0x00000000, 0x00000001, 0x00000003, 0x00000007, 0x0000000f,
			0x0000001f, 0x0000003f, 0x0000007f, 0x000000ff, 0x000001ff,
			0x000003ff, 0x000007ff, 0x00000fff, 0x00001fff, 0x00003fff,
			0x00007fff, 0x0000ffff
		);
	
		static private const Z_OK:int=0;
		static private const Z_STREAM_END:int=1;
		static private const Z_NEED_DICT:int=2;
		static private const Z_ERRNO:int=-1;
		static private const Z_STREAM_ERROR:int=-2;
		static private const Z_DATA_ERROR:int=-3;
		static private const Z_MEM_ERROR:int=-4;
		static private const Z_BUF_ERROR:int=-5;
		static private const Z_VERSION_ERROR:int=-6;
	
		// waiting for "i:"=input,
		//             "o:"=output,
		//             "x:"=nothing
		static private const START:int=0;  // x: set up for LEN
		static private const LEN:int=1;    // i: get length/literal/eob next
		static private const LENEXT:int=2; // i: getting length extra (have base)
		static private const DIST:int=3;   // i: get distance next
		static private const DISTEXT:int=4;// i: getting distance extra
		static private const COPY:int=5;   // o: copying bytes in window, waiting for space
		static private const LIT:int=6;    // o: got literal, waiting for output space
		static private const WASH:int=7;   // o: got eob, possibly still output waiting
		static private const END:int=8;    // x: got eob and all data flushed
		static private const BADCODE:int=9;// x: got error
	
		public var mode:int;      // current inflate_codes mode
	
		// mode dependent information
		public var len:int;
	
		public var tree:Array; // pointer into tree
		public var tree_index:int=0;
		public var need:int;   // bits needed
	
		public var lit:int;
	
		// if EXT or COPY, where and how much
		public var getBits:int;              // bits to get for extra
		public var dist:int;             // distance back to copy from
	
		public var lbits:uint;           // ltree bits decoded per branch
		public var dbits:uint;           // dtree bits decoder per branch
		public var ltree:Array;          // literal/length/eob tree
		public var ltree_index:int;      // literal/length/eob tree
		public var dtree:Array;          // distance tree
		public var dtree_index:int;      // distance tree
	
	
	
	
	
	
		public function InfCodes() {
		}
		
		
		
		
		public function init(bl:int, bd:int,
			tl:Array, tl_index:int,
			td:Array, td_index:int, z:ZStream):void {
			mode = START;
			lbits = bl;
			dbits = bd;
			ltree = tl;
			ltree_index = tl_index;
			dtree = td;
			dtree_index = td_index;
			tree = null;
		}
	
	
	
	
		public function proc(s:InfBlocks, z:ZStream, r:int):int { 
			var j:int;              // temporary storage
			var t:Array;            // temporary pointer
			var tindex:int;         // temporary pointer
			var e:int;              // extra bits or operation
			var b:int=0;            // bit buffer
			var k:int=0;            // bits in bit buffer
			var p:int=0;            // input data pointer
			var n:int;              // bytes available there
			var q:int;              // output window write pointer
			var m:int;              // bytes to end of window or read pointer
			var f:int;              // pointer to copy strings from
	
			// copy input/output information to locals (UPDATE macro restores)
			p=z.next_in_index;n=z.avail_in;b=s.bitb;k=s.bitk;
			q=s.write;m=q<s.read?s.read-q-1:s.end-q;
	
			// process input and output based on current state
			while (true) {
				switch (mode) {
					// waiting for "i:"=input, "o:"=output, "x:"=nothing
					case START:         // x: set up for LEN
						if (m >= 258&& n >= 10) {
							s.bitb=b;s.bitk=k;
							z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
							s.write=q;
							r = inflate_fast(lbits, dbits, 
								ltree, ltree_index, 
								dtree, dtree_index,
								s, z);
	
							p=z.next_in_index;n=z.avail_in;b=s.bitb;k=s.bitk;
							q=s.write;m=q<s.read?s.read-q-1:s.end-q;
	
							if (r != Z_OK) {
								mode = r == Z_STREAM_END ? WASH : BADCODE;
								break;
							}
						}
						need = lbits;
						tree = ltree;
						tree_index=ltree_index;
	
						mode = LEN;
					case LEN:           // i: get length/literal/eob next
						j = need;
	
						while (k<j) {
							if (n!=0) {
								r=Z_OK;
							} else {
								s.bitb=b;s.bitk=k;
								z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
								s.write=q;
								return s.inflate_flush(z,r);
							}
							n--;
							b|=(z.next_in[p++]&0xff)<<k;
							k+=8;
						}
	
						tindex=(tree_index+(b&inflate_mask[j]))*3;
	
						b>>>=(tree[tindex+1]);
						k-=(tree[tindex+1]);
	
						e=tree[tindex];
	
						if (e == 0) {               // literal
							lit = tree[tindex+2];
							mode = LIT;
							break;
						}
						if ((e & 16)!=0) {          // length
							getBits = e & 15;
							len = tree[tindex+2];
							mode = LENEXT;
							break;
						}
						if ((e & 64) == 0) {        // next table
							need = e;
							tree_index = tindex/3+tree[tindex+2];
							break;
						}
						if ((e & 32)!=0){               // end of block
							mode = WASH;
							break;
						}
						mode = BADCODE;        // invalid code
						z.msg = "invalid literal/length code";
						r = Z_DATA_ERROR;
	
						s.bitb=b;s.bitk=k;
						z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
						s.write=q;
						return s.inflate_flush(z,r);
	
					case LENEXT:        // i: getting length extra (have base)
						j = getBits;
	
						while (k<j) {
							if (n!=0) {
								r=Z_OK;
							} else {
								s.bitb=b;s.bitk=k;
								z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
								s.write=q;
								return s.inflate_flush(z,r);
							}
							n--; 
							b |= (z.next_in[p++] & 0xff) << k;
							k+=8;
						}
	
						len += (b & inflate_mask[j]);
	
						b>>=j;
						k-=j;
	
						need = dbits;
						tree = dtree;
						tree_index=dtree_index;
						mode = DIST;
	
					case DIST:          // i: get distance next
						j = need;
	
						while (k<j) {
							if (n!=0) {
								r=Z_OK;
							} else {
								s.bitb=b;s.bitk=k;
								z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
								s.write=q;
								return s.inflate_flush(z,r);
							}
							n--;
							b |= (z.next_in[p++] & 0xff) << k;
							k+=8;
						}
	
						tindex=(tree_index+(b & inflate_mask[j]))*3;
	
						b>>=tree[tindex+1];
						k-=tree[tindex+1];
	
						e = (tree[tindex]);
						if ((e & 16)!=0) {               // distance
							getBits = e & 15;
							dist = tree[tindex+2];
							mode = DISTEXT;
							break;
						}
						if ((e & 64) == 0) {        // next table
							need = e;
							tree_index = tindex/3+ tree[tindex+2];
							break;
						}
						mode = BADCODE;        // invalid code
						z.msg = "invalid distance code";
						r = Z_DATA_ERROR;
	
						s.bitb=b;s.bitk=k;
						z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
						s.write=q;
						return s.inflate_flush(z,r);
	
					case DISTEXT:       // i: getting distance extra
						j = getBits;
	
						while (k<j) {
							if (n!=0) {
								r=Z_OK;
							} else {
								s.bitb=b;s.bitk=k;
								z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
								s.write=q;
								return s.inflate_flush(z,r);
							}
							n--;
							b |= (z.next_in[p++] & 0xff) << k;
							k+=8;
						}
	
						dist += (b & inflate_mask[j]);
	
						b>>=j;
						k-=j;
	
						mode = COPY;
	
					case COPY:          // o: copying bytes in window, waiting for space
						f = q - dist;
						while (f < 0) {     // modulo window size-"while" instead
							f += s.end;     // of "if" handles invalid distances
						}
	
						while (len!=0) {
							if (m==0) {
								if (q == s.end && s.read != 0) {
									q = 0;
									m = q<s.read ? s.read-q-1 : s.end-q;
								}
								if (m==0) {
									s.write = q;
									r = s.inflate_flush(z,r);
									q = s.write;
									m = q<s.read ? s.read - q-1 : s.end - q;
	
									if (q==s.end && s.read!=0) {
										q = 0;
										m = q<s.read ? s.read - q-1 : s.end - q;
									}
	
									if (m==0) {
										s.bitb = b;
										s.bitk = k;
										z.avail_in = n;
										z.total_in += p-z.next_in_index;
										z.next_in_index = p;
										s.write = q;
										return s.inflate_flush(z, r);
									}
								}
							}
	
							s.window[q++]=s.window[f++]; m--;
	
							if (f == s.end) {
								f = 0;
							}
							len--;
						}
						mode = START;
						break;
						
					case LIT:           // o: got literal, waiting for output space
		  if(m==0){
		    if(q==s.end&&s.read!=0){q=0;m=q<s.read?s.read-q-1:s.end-q;}
		    if(m==0){
		      s.write=q; r=s.inflate_flush(z,r);
		      q=s.write;m=q<s.read?s.read-q-1:s.end-q;
	
		      if(q==s.end&&s.read!=0){q=0;m=q<s.read?s.read-q-1:s.end-q;}
		      if(m==0){
		        s.bitb=b;s.bitk=k;
		        z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
		        s.write=q;
		        return s.inflate_flush(z,r);
		      }
		    }
		  }
		  r=Z_OK;
	
		  s.window[q++] = lit;
		  m--;
	
		  mode = START;
		  break;
		    case WASH:           // o: got eob, possibly more output
		  if (k > 7){        // return unused byte, if any
		    k -= 8;
		    n++;
		    p--;             // can always return one
		  }
	
		  s.write=q; r=s.inflate_flush(z,r);
		  q=s.write;m=q<s.read?s.read-q-1:s.end-q;
	
		  if (s.read != s.write){
		    s.bitb=b;s.bitk=k;
		    z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
		    s.write=q;
		    return s.inflate_flush(z,r);
		  }
		  mode = END;
		    case END:
		  r = Z_STREAM_END;
		  s.bitb=b;s.bitk=k;
		  z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
		  s.write=q;
		  return s.inflate_flush(z,r);
	
		    case BADCODE:       // x: got error
	
		  r = Z_DATA_ERROR;
	
		  s.bitb=b;s.bitk=k;
		  z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
		  s.write=q;
		  return s.inflate_flush(z,r);
	
		    default:
		  r = Z_STREAM_ERROR;
	
		  s.bitb=b;s.bitk=k;
		  z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
		  s.write=q;
		  return s.inflate_flush(z,r);
		    }
		  }
		  
		  // should never get here
		  	  r = Z_STREAM_ERROR;
	
		  s.bitb=b;s.bitk=k;
		  z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
		  s.write=q;
		  return s.inflate_flush(z,r);
	
		}
	
		public function free(z:ZStream):void {
		  //  ZFREE(z, c);
		}
	
		// Called with number of bytes left to write in window at least 258
		// (the maximum string length) and number of input bytes available
		// at least ten.  The ten bytes are six bytes for the longest length/
		// distance pair plus four bytes for overloading the bit buffer.
	
		public function inflate_fast(bl:int, bd:int, 
			tl:Array, tl_index:int,
			td:Array, td_index:int,
			s:InfBlocks, z:ZStream):int {
	
			var t:int;                // temporary pointer
			var tp:Array;             // temporary pointer
			var tp_index:int;         // temporary pointer
			var e:int;                // extra bits or operation
			var b:int;                // bit buffer
			var k:int;                // bits in bit buffer
			var p:int;                // input data pointer
			var n:int;                // bytes available there
			var q:int;                // output window write pointer
			var m:int;                // bytes to end of window or read pointer
			var ml:int;               // mask for literal/length tree
			var md:int;               // mask for distance tree
			var c:int;                // bytes to copy
			var d:int;                // distance back to copy from
			var r:int;                // copy source pointer
	
			var tp_index_t_3:int;     // (tp_index+t)*3
	
			// load input, output, bit values
			p=z.next_in_index;n=z.avail_in;b=s.bitb;k=s.bitk;
			q=s.write;m=q<s.read?s.read-q-1:s.end-q;
	
			// initialize masks
			ml = inflate_mask[bl];
			md = inflate_mask[bd];
	
			// do until not enough input or output space for fast loop
			do {                          // assume called with m >= 258 && n >= 10
			// get literal/length code
			while(k<(20)){              // max bits for literal/length code
			n--;
			b |= (z.next_in[p++] & 0xff) << k;
			k+=8;
			}
	
			t= b&ml;
			tp=tl; 
			tp_index=tl_index;
			tp_index_t_3=(tp_index+t)*3;
			if ((e = tp[tp_index_t_3]) == 0){
			b>>=(tp[tp_index_t_3+1]); k-=(tp[tp_index_t_3+1]);
	
		s.window[q++] = tp[tp_index_t_3+2];
		m--;
		continue;
	      }
	      do {
	
		b>>=(tp[tp_index_t_3+1]); k-=(tp[tp_index_t_3+1]);
	
		if((e&16)!=0){
		  e &= 15;
		  c = tp[tp_index_t_3+2] + (int(b )& inflate_mask[e]);
	
		  b>>=e; k-=e;
	
		  // decode distance base of block to copy
		  while(k<(15)){           // max bits for distance code
		    n--;
			b |= (z.next_in[p++] & 0xff) << k;
			k += 8;
		  }
	
		  t= b&md;
		  tp=td;
		  tp_index=td_index;
	          tp_index_t_3=(tp_index+t)*3;
		  e = tp[tp_index_t_3];
	
		  do {
	
		    b>>=(tp[tp_index_t_3+1]); k-=(tp[tp_index_t_3+1]);
	
		    if((e&16)!=0){
		      // get extra bits to add to distance base
		      e &= 15;
		      while(k<e){         // get extra bits (up to 13)
			n--;
				b |= (z.next_in[p++] & 0xff) << k;
				k += 8;
		      }
	
		      d = tp[tp_index_t_3+2] + (b&inflate_mask[e]);
	
		      b>>=e; k-=e;
	
		      // do the copy
		      m -= c;
		      if (q >= d){                // offset before dest
			//  just copy
			r=q-d;
			if(q-r>0&& 2>(q-r)){           
			  s.window[q++]=s.window[r++]; // minimum count is three,
			  s.window[q++]=s.window[r++]; // so unroll loop a little
			  c-=2;
			}
			else{
			  System.byteArrayCopy(s.window, r, s.window, q, 2);
			  q+=2; r+=2; c-=2;
			}
		      }
		      else{                  // else offset after destination
	                r=q-d;
	                do{
	                  r+=s.end;          // force pointer in window
	                }while(r<0);         // covers invalid distances
			e=s.end-r;
			if(c>e){             // if source crosses,
			  c-=e;              // wrapped copy
			  if(q-r>0&& e>(q-r)){           
			    do{s.window[q++] = s.window[r++];}
			    while(--e!=0);
			  }
			  else{
			    System.byteArrayCopy(s.window, r, s.window, q, e);
			    q+=e; r+=e; e=0;
			  }
			  r = 0;                  // copy rest from start of window
			}
	
		      }
	
		      // copy all or what's left
		      if(q-r>0&& c>(q-r)){           
			do{s.window[q++] = s.window[r++];}
			while(--c!=0);
		      }
		      else{
			System.byteArrayCopy(s.window, r, s.window, q, c);
			q+=c; r+=c; c=0;
		      }
		      break;
		    }
		    else if((e&64)==0){
		      t+=tp[tp_index_t_3+2];
		      t+=(b&inflate_mask[e]);
		      tp_index_t_3=(tp_index+t)*3;
		      e=tp[tp_index_t_3];
		    }
		    else{
		      z.msg = "invalid distance code";
	
		      c=z.avail_in-n;c=(k>>3)<c?k>>3:c;n+=c;p-=c;k-=c<<3;
	
		      s.bitb=b;s.bitk=k;
		      z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
		      s.write=q;
	
		      return Z_DATA_ERROR;
		    }
		  }
		  while(true);
		  break;
		}
	
		if((e&64)==0){
			t+=tp[tp_index_t_3+2];
			t+=(b&inflate_mask[e]);
			tp_index_t_3=(tp_index+t)*3;
			if ((e=tp[tp_index_t_3])==0) {
	
				b>>=(tp[tp_index_t_3+1]); k-=(tp[tp_index_t_3+1]);
	
				s.window[q++]=tp[tp_index_t_3+2];
				m--;
				break;
			}
		} else if((e&32)!=0) {
			c=z.avail_in-n;c=(k>>3)<c?k>>3:c;n+=c;p-=c;k-=c<<3;
	
			s.bitb=b;s.bitk=k;
			z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
			s.write=q;
	
			return Z_STREAM_END;
		} else{
			z.msg="invalid literal/length code";
	
			c=z.avail_in-n;c=(k>>3)<c?k>>3:c;n+=c;p-=c;k-=c<<3;
	
			s.bitb=b;s.bitk=k;
			z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
			s.write=q;
	
			return Z_DATA_ERROR;
		}
	} 
	while(true);
	} 
	while(m>=258&& n>= 10);
	
	// not enough input or output--restore pointers and return
	c=z.avail_in-n;c=(k>>3)<c?k>>3:c;n+=c;p-=c;k-=c<<3;
	
	s.bitb=b;s.bitk=k;
	z.avail_in=n;z.total_in+=p-z.next_in_index;z.next_in_index=p;
	s.write=q;
	
	return Z_OK;
	}
	}
}