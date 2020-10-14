package application.events {
	import flash.events.Event;

	public class CannotPerformUpdateEvent extends Event {
		public function CannotPerformUpdateEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_CANNOT_PERFORM_UPDATE:String = "cannotPerformUpdate";

        override public function clone():Event {
            return new CannotPerformUpdateEvent(type);
        }
	}
}