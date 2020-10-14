package controls.login.widgets.event {
	import flash.events.Event;

	public class HideUserNameErrorTipEvent extends Event {
		public function HideUserNameErrorTipEvent(type:String, value:Boolean, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			this.value = value;
		}
		
        public static const TYPE_HIDE_USERNAME_ERRORTIP:String = "hideUserNameErrorTip";
        
        public var value:Boolean;

        override public function clone():Event {
            return new HideUserNameErrorTipEvent(type, this.value);
        }
	}
}