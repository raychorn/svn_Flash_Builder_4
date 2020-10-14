package controls.login.widgets.event {
	import flash.events.Event;

	public class LoginViewChangedEvent extends Event {
		public function LoginViewChangedEvent(type:String, oldState:String, newState:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			this.oldState = oldState;
			this.newState = newState;
		}
		
        public static const TYPE_LOGIN_VIEW_CHANGED:String = "loginViewChanged";
        
        public var oldState:String;
		public var newState:String;

        override public function clone():Event {
            return new LoginViewChangedEvent(type, this.oldState, this.newState);
        }
	}
}