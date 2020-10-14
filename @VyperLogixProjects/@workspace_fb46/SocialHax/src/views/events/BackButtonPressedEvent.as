package views.events {
	import flash.events.Event;

	public class BackButtonPressedEvent extends Event {
		public function BackButtonPressedEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_BACK_BUTTON_PRESSED:String = "backButtonPressed";

        override public function clone():Event {
            return new BackButtonPressedEvent(type);
        }
	}
}