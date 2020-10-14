package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ClickedHotSpotEvent extends Event {
		public function ClickedHotSpotEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public static const TYPE_CLICKED_HOTSPOT:String = "clickedHotSpot";
		
		override public function clone():Event {
			return new ClickedHotSpotEvent(type);
		}
	}
}