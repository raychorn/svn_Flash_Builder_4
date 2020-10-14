package vzw.menu.builder.events {
	import flash.events.Event;

	public class SmartAccordionIndexChangedEvent extends Event {
		public var index:int = -1;
        public static const TYPE_SMART_ACCORDION_INDEX_CHANGED_EVENT:String = "smartAccordionIndexChangedEvent";
		
		public function SmartAccordionIndexChangedEvent(type:String, index:int, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.index = index;
		}
		
        override public function clone():Event {
            return new SmartAccordionIndexChangedEvent(type,this.index);
        }
	}
}