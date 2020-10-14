package views.events {
	import flash.events.Event;

	public class DrawImageEvent extends Event {
		public function DrawImageEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_COMPLETED_USER_LOGIN:String = "completedUserLogin";

        override public function clone():Event {
            return new DrawImageEvent(type);
        }
	}
}