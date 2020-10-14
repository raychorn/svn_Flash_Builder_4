package views.events {
	import flash.events.Event;

	public class DrawStarEvent extends Event {
		public function DrawStarEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_DRAW_STAR:String = "drawStar";

        override public function clone():Event {
            return new DrawStarEvent(type);
        }
	}
}