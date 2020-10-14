package controls.tabs.events {
	import flash.events.Event;

	public class TabClickedEvent extends Event {
		public function TabClickedEvent(type:String, state:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			this.state = state;
			super(type, bubbles, cancelable);
		}
		
		private var state:String;
		
        public static const TYPE_TAB_CLICKED:String = "tabClicked";

        override public function clone():Event {
            return new TabClickedEvent(type,this.state);
        }
	}
}