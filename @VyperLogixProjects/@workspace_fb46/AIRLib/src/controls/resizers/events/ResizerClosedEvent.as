package controls.resizers.events {
	import flash.events.Event;

	public class ResizerClosedEvent extends Event {
		public function ResizerClosedEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_RESIZER_CLOSED:String = "resizerClosed";

        override public function clone():Event {
            return new ResizerClosedEvent(type);
        }
	}
}