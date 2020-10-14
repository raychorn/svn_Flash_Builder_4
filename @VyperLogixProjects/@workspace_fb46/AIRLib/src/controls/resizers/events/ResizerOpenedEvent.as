package controls.resizers.events {
	import flash.events.Event;

	public class ResizerOpenedEvent extends Event {
		public function ResizerOpenedEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_RESIZER_OPENED:String = "resizerOpened";

        override public function clone():Event {
            return new ResizerOpenedEvent(type);
        }
	}
}