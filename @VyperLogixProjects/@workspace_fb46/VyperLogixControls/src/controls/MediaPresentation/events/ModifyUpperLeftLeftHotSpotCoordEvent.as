package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ModifyUpperLeftLeftHotSpotCoordEvent extends Event {
		public function ModifyUpperLeftLeftHotSpotCoordEvent(type:String, pt:Point, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.pt = pt;
		}
		
		public var pt:Point;
		
		public static const TYPE_MOFIDY_UPPER_LEFT_LEFT_HOTSPOT:String = "modifyUpperLeftLeftHotSpot";
		
		override public function clone():Event {
			return new ModifyUpperLeftLeftHotSpotCoordEvent(type,this.pt);
		}
	}
}