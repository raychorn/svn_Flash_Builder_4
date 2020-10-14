package controls.timers.events {
	import flash.events.Event;
	
	public class TimerCompletedEvent extends Event {
		public function TimerCompletedEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public static const TYPE_TIMER_COMPLETED:String = "TimerCompletedEvent";
		
		override public function clone():Event {
			return new TimerCompletedEvent(type);
		}
	}
}