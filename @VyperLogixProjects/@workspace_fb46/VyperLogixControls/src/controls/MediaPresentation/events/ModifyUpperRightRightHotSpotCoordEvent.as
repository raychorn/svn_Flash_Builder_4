package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ModifyUpperRightRightHotSpotCoordEvent extends Event {
		public function ModifyUpperRightRightHotSpotCoordEvent(type:String, pt:Point, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.pt = pt;
		}
		
		public var pt:Point;
		
		public static const TYPE_MOFIDY_UPPER_RIGHT_RIGHT_HOTSPOT:String = "modifyUpperRightRightHotSpot";
		
		override public function clone():Event {
			return new ModifyUpperRightRightHotSpotCoordEvent(type,this.pt);
		}
	}
}