package views.events {
	import flash.events.Event;

	public class MenuClosedEvent extends Event {
		public function MenuClosedEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_MENU_CLOSED:String = "menuClosed";

        override public function clone():Event {
            return new MenuClosedEvent(type);
        }
	}
}