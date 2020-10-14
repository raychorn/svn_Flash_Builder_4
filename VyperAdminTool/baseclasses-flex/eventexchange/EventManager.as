package eventexchange {


	import EventExchangeMediator;

	class EventManager  {
		

		private static var _oInstance:EventManager;
		public var eventExchange:EventExchangeMediator;
		
		/** Constructor **/
		public function EventManager() {
			//init();
		}
		
		/**
		* Make a singleton
		* @return EventManager
		*/
		
		public static function getInstance():EventManager {
			if (_oInstance == undefined) {
				_oInstance = new EventManager ();
				init();
			}
			
			return _oInstance;
		}
		
		public static function init () {
			_oInstance.eventExchange = new EventExchangeMediator();
		}
		
		public function sendEvent(commandName:String, arg:Object):Void {
			_oInstance.eventExchange.sendEvent(commandName,arg);
		}
		
	}
	
}

