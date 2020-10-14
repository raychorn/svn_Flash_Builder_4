/*
 * @author Ryan C. Knaggs
 * @date 04/30/2007
 * @description - The Event factory, is designed
 * to setup a new slot object.  The requestor is the slots Object.
 * @see EventExchange.as, EventSingleton.as.
 */ 


package eventexchange {
	
	public class EventFactory implements IEventDispatch {
		
		
		
		// List all slot listeners	 
		private var aObs:Array;
		
		
		// Instantiate a new list of slot listeners	 
		public function EventFactory () {
			aObs = new Array ();
		}
		
		
		
		/**
		* Add a new slot listener
		* @param	obj:IEventListener
		* @see IEventListener.as
		*/
		
		public function addObserver (obj:IEventListener):void {
			aObs.push(obj);
		}
		
		
		

		
		private var name:String = null;
		
		public function set _name(name:String):void {
			this.name = name;
		}
		
		
		
		
		public function get _name():String {
			return this.name;
		}
		
		
		
		
		
		/**
		* Set a new slot name
		* @param	chN:String - Slot name.
		* @param	ch:Number - Slot number.
		*/
		
		public function setCN(chN:String,ch:Number):void {
			aObs[ch]._name = chN;
		}
		
		
		
		
		
		/**
		* Send data to specific slot that this EventManager was assigned to
		* @see EventExchange.as - Predefined by EventExchange.as
		* @param	e:Object - Object data to send thru this current slot
		*/
		public function notifyObserver (e:Object):void {
			
			for (var i:Number = 0; i < aObs.length; i++) {
				var tmpObserver:IEventListener = aObs[i];
				tmpObserver.update(e);
			}
		}
	}
}
