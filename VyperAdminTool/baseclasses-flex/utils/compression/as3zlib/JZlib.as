package utils.compression.as3zlib
{




	final public class JZlib
	{
	
	  public var version:String="1.0.2";
	  public static function get version():String {return version;}
	
	  // compression levels
	  static public var Z_NO_COMPRESSION:int=0;
	  static public var Z_BEST_SPEED:int=1;
	  static public var Z_BEST_COMPRESSION:int=9;
	  static public var Z_DEFAULT_COMPRESSION:int=(-1);
	
	  // compression strategy
	  static public var Z_FILTERED:int=1;
	  static public var Z_HUFFMAN_ONLY:int=2;
	  static public var Z_DEFAULT_STRATEGY:int=0;
	
	  static public var Z_NO_FLUSH:int=0;
	  static public var Z_PARTIAL_FLUSH:int=1;
	  static public var Z_SYNC_FLUSH:int=2;
	  static public var Z_FULL_FLUSH:int=3;
	  static public var Z_FINISH:int=4;
	
	  static public var Z_OK:int=0;
	  static public var Z_STREAM_END:int=1;
	  static public var Z_NEED_DICT:int=2;
	  static public var Z_ERRNO:int=-1;
	  static public var Z_STREAM_ERROR:int=-2;
	  static public var Z_DATA_ERROR:int=-3;
	  static public var Z_MEM_ERROR:int=-4;
	  static public var Z_BUF_ERROR:int=-5;
	  static public var Z_VERSION_ERROR:int=-6;
	}
}