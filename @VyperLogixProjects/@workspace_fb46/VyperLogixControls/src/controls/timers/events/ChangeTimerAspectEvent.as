package controls.timers.events {
	import flash.events.Event;
	
	public class ChangeTimerAspectEvent extends Event {
		public function ChangeTimerAspectEvent(type:String, value:*, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.value = value;
		}
		
		public static const TYPE_CHANGE_TIMER_DAYS:String = "changeTimerDays";
		public static const TYPE_CHANGE_TIMER_HOURS:String = "changeTimerHours";
		public static const TYPE_CHANGE_TIMER_MINUTES:String = "changeTimerMinutes";
		public static const TYPE_CHANGE_TIMER_SECONDS:String = "changeTimerSeconds";
		
		public var value:*;
		
		override public function clone():Event {
			return new ChangeTimerAspectEvent(type,value);
		}
	}
}