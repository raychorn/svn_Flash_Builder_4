package controls.login.events {
	import flash.events.Event;

	public class ChangePasswordEvent extends Event {
		public function ChangePasswordEvent(type:String, datum:Object, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			this.datum = datum;
		}
		
        public static const TYPE_CHANGE_PASSWORD:String = "changePassword";
        
        public var datum:Object;

        override public function clone():Event {
            return new ChangePasswordEvent(type, datum);
        }
	}
}