package application.events {
	import flash.events.Event;

	public class OnSysTrayMenuInitEvent extends Event {
		public function OnSysTrayMenuInitEvent(type:String, menu:*, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.menu = menu;
		}
		
		public var menu:*;
		
        public static const TYPE_ON_SYSTRAY_MENU_INIT:String = "onSysTrayMenuInitEvent";

        override public function clone():Event {
            return new OnSysTrayMenuInitEvent(type,menu);
        }
	}
}