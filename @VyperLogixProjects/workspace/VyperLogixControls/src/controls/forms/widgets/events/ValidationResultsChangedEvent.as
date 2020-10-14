package controls.forms.widgets.events {
	import flash.events.Event;

	public class ValidationResultsChangedEvent extends Event {
		public function ValidationResultsChangedEvent(type:String, was_valid:Boolean, is_valid:Boolean, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			this.was_valid = was_valid;
			this.is_valid = is_valid;
		}
		
        public static const TYPE_VALIDATION_RESULTS_CHANGED:String = "validationResultsChanged";
        
		public var was_valid:Boolean;
        public var is_valid:Boolean;

        override public function clone():Event {
            return new ValidationResultsChangedEvent(type, this.was_valid, this.is_valid);
        }
	}
}