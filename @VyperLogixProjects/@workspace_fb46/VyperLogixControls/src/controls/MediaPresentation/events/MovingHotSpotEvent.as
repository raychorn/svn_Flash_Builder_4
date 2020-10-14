package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class MovingHotSpotEvent extends Event {
		public function MovingHotSpotEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public static const TYPE_MOVING_HOTSPOT:String = "movingHotSpot";
		
		override public function clone():Event {
			return new MovingHotSpotEvent(type);
		}
	}
}