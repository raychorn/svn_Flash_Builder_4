package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ModifyUpperRightHotSpotCoordEvent extends Event {
		public function ModifyUpperRightHotSpotCoordEvent(type:String, pt:Point, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.pt = pt;
		}
		
		public var pt:Point;
		
		public static const TYPE_MOFIDY_UPPER_RIGHT_HOTSPOT:String = "modifyUpperRightHotSpot";
		
		override public function clone():Event {
			return new ModifyUpperRightHotSpotCoordEvent(type,this.pt);
		}
	}
}