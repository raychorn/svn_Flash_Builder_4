package controls.login.widgets.event {
	import flash.events.Event;

	public class UpdateUserNameTextValueEvent extends Event {
		public function UpdateUserNameTextValueEvent(type:String, value:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			this.value = value;
		}
		
        public static const TYPE_UPDATE_USERNAME_TEXT_VALUE:String = "updateUserNameTextValue";
        
        public var value:String;

        override public function clone():Event {
            return new UpdateUserNameTextValueEvent(type, this.value);
        }
	}
}