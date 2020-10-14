package free4u.events {
	import flash.events.Event;

	public class ApplicationProxyReadyEvent extends Event {
		public function ApplicationProxyReadyEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const APPLICATION_PROXY_READY:String = "applicationProxyReady";

        override public function clone():Event {
            return new ApplicationProxyReadyEvent(type);
        }
	}
}