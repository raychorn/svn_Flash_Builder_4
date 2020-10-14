package controls.timers.events {
	import flash.events.Event;
	
	public class CloseEditorEvent extends Event {
		public function CloseEditorEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public static const TYPE_CLOSE_EDITOR:String = "CloseEditorEvent";
		
		override public function clone():Event {
			return new CloseEditorEvent(type);
		}
	}
}