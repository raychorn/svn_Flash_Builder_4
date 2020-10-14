package controls.MediaPresentation.CustomEditor.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ItemUpdateEvent extends Event {
		public function ItemUpdateEvent(type:String, item:*, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.item = item;
		}
		
		public var item:*;
		
		public static const TYPE_ITEM_UPDATE:String = "itemUpdate";
		
		override public function clone():Event {
			return new ItemUpdateEvent(type,this.item);
		}
	}
}