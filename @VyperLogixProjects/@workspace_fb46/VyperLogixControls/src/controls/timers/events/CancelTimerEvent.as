package controls.timers.events {
	import flash.events.Event;
	
	public class CancelTimerEvent extends Event {
		public function CancelTimerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public static const TYPE_CANCEL_TIMER:String = "CancelTimerEvent";
		
		override public function clone():Event {
			return new CancelTimerEvent(type);
		}
	}
}