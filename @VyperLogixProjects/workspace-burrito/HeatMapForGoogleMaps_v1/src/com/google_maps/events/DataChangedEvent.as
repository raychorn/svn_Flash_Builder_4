package com.google_maps.events {
	import flash.events.Event;

	public class DataChangedEvent extends Event {

		public static const DATA_CHANGED:String = "onDataChanged";
		
		public var data:*;
		public var name:String;
		
		public function DataChangedEvent(type:String, name:String, data:*, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.name = name;
			this.data = data;
		}
		
		public override function clone():Event {
			return (new DataChangedEvent(type, this.name, this.data, bubbles, cancelable));
		}
	}
}