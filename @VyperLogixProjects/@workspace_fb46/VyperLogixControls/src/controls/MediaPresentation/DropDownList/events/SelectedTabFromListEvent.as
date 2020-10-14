package controls.MediaPresentation.DropDownList.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class SelectedTabFromListEvent extends Event {
		public function SelectedTabFromListEvent(type:String, item:*, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.item = item;
		}
		
		public var item:*;
		
		public static const TYPE_SELECTED_TAB_FROM_LIST:String = "selectedTabFromList";
		
		override public function clone():Event {
			return new SelectedTabFromListEvent(type,item);
		}
	}
}