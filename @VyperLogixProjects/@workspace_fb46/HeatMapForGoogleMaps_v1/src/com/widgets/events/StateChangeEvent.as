package com.widgets.events {
	import flash.events.Event;

	public class StateChangeEvent extends Event {

		public static const CHANGE:String = "onStateChange";
		
		public var old_state:*;
		public var new_state:*;
		
		public function StateChangeEvent(type:String, old_state:*, new_state:*, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.old_state = old_state;
			this.new_state = new_state;
		}
		
		public override function clone():Event {
			return (new StateChangeEvent(type, this.old_state, this.new_state, bubbles, cancelable));
		}
	}
}