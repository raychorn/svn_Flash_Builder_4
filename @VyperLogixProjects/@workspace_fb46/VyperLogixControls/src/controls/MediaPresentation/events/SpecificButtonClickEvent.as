package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class SpecificButtonClickEvent extends Event {
		public function SpecificButtonClickEvent(type:String, label:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.label = label;
		}
		
		public var label:String;
		
		public static const TYPE_SPECIFIC_BUTTON_CLICK:String = "specificButtonClick";
		
		override public function clone():Event {
			return new SpecificButtonClickEvent(type,this.label);
		}
	}
}