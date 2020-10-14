package controls.events {
	import flash.events.Event;

	public class ShowDocsListItemsEvent extends Event {
		public function ShowDocsListItemsEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_SHOW_DOCSLIST_ITEMS:String = "showDocsListItems";

        override public function clone():Event {
            return new ShowDocsListItemsEvent(type);
        }
	}
}