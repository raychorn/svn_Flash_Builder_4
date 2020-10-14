package controls.events.tips {
	import flash.events.Event;

	public class CustomErrorTipsChangedEvent extends Event {
		public function CustomErrorTipsChangedEvent(type:String, target:*, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.current_target = target;
		}

		public var current_target:*;
		
		public static const TYPE_CUSTOM_ERROR_TIPS_CHANGED_EVENT:String = "customErrorTipsChangedEvent";
		
        override public function clone():Event {
            return new CustomErrorTipsChangedEvent(type,this.current_target);
        }
	}
}