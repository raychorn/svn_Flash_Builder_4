package controls.timers.events {
	import flash.events.Event;
	
	public class TimerTickEvent extends Event {
		public function TimerTickEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public static const TYPE_TIMER_TICK:String = "TimerTickEvent";
		
		override public function clone():Event {
			return new TimerTickEvent(type);
		}
	}
}