package vyperlogix.events {
	import flash.events.Event;

	public class RequestedUserLoginEvent extends Event {
		public function RequestedUserLoginEvent(type:String, kiosk:*, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.kiosk = kiosk;
		}
		
		public var kiosk:*;
		
        public static const TYPE_REQUESTED_USER_LOGIN:String = "requestedUserLogin";

        override public function clone():Event {
            return new RequestedUserLoginEvent(type,this.kiosk);
        }
	}
}