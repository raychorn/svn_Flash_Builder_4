package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class SizingHotSpotEvent extends Event {
		public function SizingHotSpotEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public static const TYPE_SIZING_HOTSPOT:String = "sizingHotSpot";
		
		override public function clone():Event {
			return new SizingHotSpotEvent(type);
		}
	}
}