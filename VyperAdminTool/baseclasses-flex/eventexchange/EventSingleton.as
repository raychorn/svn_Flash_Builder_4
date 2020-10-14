
/*
 * Class EventSingleton.as
 * @author Ryan C. Knaggs
 * 04/30/2007
 * @description Class type: Singleton
 * Designed to hold multiple slots
 * and store them into an array.  The singleton
 * will only keep one instance in memory to all slots
 * can be accessed.
 */

package eventexchange {

	public class EventSingleton {

		
		
		
		private static var _oInstance:EventSingleton;
		public var ch:Array;
		public var ref:Array;
		
		
		/**
		* Constructor
		*/
		
		public function EventSingleton () {
		}
		
		
		/**
		* Declare a new slot array if one does not exist
		* @return	new EventSingleton:EventSingleton
		*/
		
		public static function getInstance ():EventSingleton
		{
			if (_oInstance == null) {
				_oInstance = new EventSingleton ();
				_oInstance.ch = new Array();
				_oInstance.ref = new Array();
				
			}
			
			return _oInstance;
		}
		
		
		
		
		/**
		* Remove Singleton from memory
		*/
		
		public static function release ():void
		{
			if (_oInstance) {
				_oInstance = null;
			}
		}
	}
}
