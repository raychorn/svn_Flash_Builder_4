package vyperlogix.events {
	import flash.events.Event;

	public class CompletedUserLoginEvent extends Event {
		public function CompletedUserLoginEvent(type:String, roles:*, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.roles = roles;
		}
		
		public var roles:*;
		
        public static const TYPE_COMPLETED_USER_LOGIN:String = "completedUserLogin";

        override public function clone():Event {
            return new CompletedUserLoginEvent(type,this.roles);
        }
	}
}