/*
 * @author Ryan C. Knaggs
 * @date 04/30/2007
 * @description - EventExchange (Main) class.
 * This Class object is defined to allow a developer
 * extend this class to their application class file, so
 * the user can broadcast or listen to many different
 * combination of slots.
 * Example: Slot 1
 * You can send a dispatch (Broadcast) out from your class object
 * and listen to any specific channel to receive broadcasts.
 */



package eventexchange {

	import eventexchange.EventExchange;
	
	public class EventExchange extends EventDispatch {
		
		
		public var chn:Object;	// Store the channel singleton
		public var chl:EventListener;	// Store the channel listener
		private var classObjectArr:Array;
		
		
		
		
		/**
		* Constructor
		* Get singleton reference
		*/
		public function EventExchange() {
			chn = EventSingleton.getInstance();
			super(chn);
		}
		
		
		
		
		public function addReference(rc:Object):Boolean {
			
			// Check for Duplicates			
			for(var i:Number = 0; i<chn.ref.length;++i) {
				
				if(parseClassName(String(rc)) == parseClassName(String(chn.ref[i]))) {
					return false;
				}
			}
			
			chn.ref.push(rc);
			return true;
		}
		
		
		
		
		
		
		
		
		private function parseClassName(str:String):String {
			return str.split(" ")[1].split("]")[0];
		}
		
		
		
		
		public function removeReference(className:String):Boolean {
		// Remove class reference
			for(var i:Number = 0; i<chn.ref.length;++i) {
				
				if(className == parseClassName(String(chn.ref[i]))) {
					chn.ref.splice(i,1);
					return true;
				}
			}
			
			return false;
		}
		
		
		
		
		public function listReference():void {
			
			if(chn.ref.length == 0) {
				return;
			}
			
			for(var i:Number = 0; i<chn.ref.length;++i) {
				//trace("List Reference : ["+i+"] Classname: "+parseClassName(String(chn.ref[i])));
			}
		}
		
		
		
		
		public function getReference(className:String):Object {
			// Find class name and pass back it's reference	
			for(var i:Number = 0; i<chn.ref.length;++i) {
				
				if(className == parseClassName(String(chn.ref[i]))) {
					return chn.ref[i];
				}
			}
			
			return null;
		}
		
		
		/**
		* Add a new channel
		* When you add a new channel, the EventSingleton
		* will store a copy of the ChannelManager Object into
		* an Array of ChannelManagers.  This is designed to
		* allow for multiple slots [0 ~ n]
		* @param	c:Number - Channel Number
		* @param	n:String - Description of the channel (Comments)
		* @return	If channel is already in use, then return -1,
		* otherwise return the channel number (Positive Interger)
		*/
		
		public function addSlot(c:Number,n:String=""):Number {
			if(chn.ch[c] == undefined) {
				chn.ch[c] = new EventFactory();
				chn.ch[c]._name = n;
				return c;
			} else {
				return -1;
			}
		}
		
		
		
		/**
		 * Each slot is automatically added upon
		 * the first usage of getListner and or dispatch
		 * you can name the slot for future reference
		 * If the slot does not exist then create one
		 */
		 
		public function nameSlot(c:Number, n:String=""):String {
			if(chn.ch[c] == undefined) {
				chn.ch[c] = new EventFactory();
				chn.ch[c]._name = n;
				return "Creating new Slot:"+c+" and is named: "+n;
			} else {
				chn.ch[c]._name = n;
				return "Renaming Slot:"+c+" to: "+n;
			}
		}
		
		
		
		/**
		* Give the channel a name.  
		* @see This is used with the getChannelList() method
		* @param	chN:String - String name of the channel.
		* @param	ch:Number - Which channel number to name
		*/
		
		public function setSlotName(chN:String,ch:Number):void {
			chn.ch[ch]._name = chN;
		}
		
		
		
		
		/**
		* Get the name from a channel Number
		* @param	ch:Number - Which channel number to query
		* @return	Return the string name of the channel.
		*/
		
		public function getNameBySlot(ch:Number):String {
			return chn.ch[ch]._name;
		}
		
		
		
		/**
		* Access the channel number by the channel string name
		* @param	chN:String - Name of the channel
		* @return	Return the channel number.
		*/
		
		public function getSlotByName(chN:String):Number {
			for(var i:uint=0;i<chn.ch.length;++i) {
				if(chn.ch[i]._name.toLowerCase() == chN.toLowerCase()) {
					return i;
				} else {
					return -1;
				}
			}
			
			return -1;
		}
		
		
		/**
		* List all slots in use.
		* @return Array of slots in use - info:[Query Type], channelNumber:[Channel Number],chN:[Channel Number]
		*/
		
		public function getSlotList():Array {
			
			var arr:Array = new Array();
			
			for(var i:uint=0;i<chn.ch.length;++i) {
				if(chn.ch[i] != undefined) {
					var chN:String = "";
					if(chn.ch[i]._name != undefined) {
						chN = chn.ch[i]._name;
					} else {
						chN = null;
					}
					
					var obj:Object = new Object();
					//var obj:Object = new Object({info:"Channel List",slotNumber:i,slotName:chN});
					obj.info = "Channel List";
					obj.slotNumber = i;
					obj.slotName = chN;
					
					arr.push(obj);
					arr.reverse();
				}
				
			}
			
			return arr;
			
		}
		
		
		
		/**
		* Request for a channel listener
		* When you need to listen to a channel number, use this method
		* @param	rc:Object - Calling class that wants to use the listener
		* @param	fn:String - Calling class function to call with listener object data
		* @param	ch:Number - Which channel to listen to
		* @return	Return a new channel listener to the calling class.
		*/
		
		public function getListener(rc:Object,fn:String,ch:Number):EventListener {
			var l:EventListener = new EventListener();
			
			try {
				l.init(rc,fn,ch);
			} catch(e:Error) {
				this.addSlot(ch,"Slot"+ch);
				l.init(rc,fn,ch);
			}
			return l;
		}
			
	}
	
}
