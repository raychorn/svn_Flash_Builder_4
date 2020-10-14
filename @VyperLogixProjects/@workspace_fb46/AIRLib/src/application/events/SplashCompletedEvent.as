package application.events {
	import flash.events.Event;

	public class SplashCompletedEvent extends Event {
		public function SplashCompletedEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_SPLASH_COMPLETED:String = "splashCompleted";

        override public function clone():Event {
            return new SplashCompletedEvent(type);
        }
	}
}