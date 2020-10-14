package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ModifyUpperLeftHotSpotCoordEvent extends Event {
		public function ModifyUpperLeftHotSpotCoordEvent(type:String, pt:Point, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.pt = pt;
		}
		
		public var pt:Point;
		
		public static const TYPE_MOFIDY_UPPER_LEFT_HOTSPOT:String = "modifyUpperLeftHotSpot";
		
		override public function clone():Event {
			return new ModifyUpperLeftHotSpotCoordEvent(type,this.pt);
		}
	}
}