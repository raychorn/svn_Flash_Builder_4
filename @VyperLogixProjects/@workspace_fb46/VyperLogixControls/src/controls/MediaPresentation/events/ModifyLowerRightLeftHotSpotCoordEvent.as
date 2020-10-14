package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ModifyLowerRightLeftHotSpotCoordEvent extends Event {
		public function ModifyLowerRightLeftHotSpotCoordEvent(type:String, pt:Point, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.pt = pt;
		}
		
		public var pt:Point;
		
		public static const TYPE_MOFIDY_LOWER_RIGHT_LEFT_HOTSPOT:String = "modifyLowerRightLeftHotSpot";
		
		override public function clone():Event {
			return new ModifyLowerRightLeftHotSpotCoordEvent(type,this.pt);
		}
	}
}