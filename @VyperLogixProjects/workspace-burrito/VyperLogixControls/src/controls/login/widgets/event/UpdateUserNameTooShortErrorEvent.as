package controls.login.widgets.event {
	import flash.events.Event;

	public class UpdateUserNameTooShortErrorEvent extends Event {
		public function UpdateUserNameTooShortErrorEvent(type:String, value:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			this.value = value;
		}
		
        public static const TYPE_UPDATE_USERNAME_TOOSHORT_ERROR:String = "updateUserNameTooShortError";
        
        public var value:String;

        override public function clone():Event {
            return new UpdateUserNameTooShortErrorEvent(type, this.value);
        }
	}
}