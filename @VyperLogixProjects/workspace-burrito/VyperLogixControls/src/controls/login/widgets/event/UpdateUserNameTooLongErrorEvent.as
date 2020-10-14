package controls.login.widgets.event {
	import flash.events.Event;

	public class UpdateUserNameTooLongErrorEvent extends Event {
		public function UpdateUserNameTooLongErrorEvent(type:String, value:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			this.value = value;
		}
		
        public static const TYPE_UPDATE_USERNAME_TOOLONG_ERROR:String = "updateUserNameTooLongError";
        
        public var value:String;

        override public function clone():Event {
            return new UpdateUserNameTooLongErrorEvent(type, this.value);
        }
	}
}