package com.geolocation.events {
	import flash.events.Event;

	public class GeolocationDataChangedEvent extends Event {
		public function GeolocationDataChangedEvent(type:String, data:*, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		public var data:*;
		
        public static const TYPE_GEOLOCATION_DATA_CHANGED:String = "geolocationDataChanged";

        override public function clone():Event {
            return new GeolocationDataChangedEvent(type, data);
        }
	}
}