package com.brightPoint.controls.gauge.events {
	import flash.events.Event;

	public class GaugeEvent extends Event {
		public function GaugeEvent(type:String, value:Number, newValue:Number, x:Number, y:Number, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.value = value;
			this.newValue = newValue;
			this.x = x;
			this.y = y;
		}
		
		public var value:Number;
		public var newValue:Number;
		public var x:Number;
		public var y:Number;
		
        public static const TYPE_GAUGE_EVENT:String = "gaugeEvent";

        override public function clone():Event {
            return new GaugeEvent(type,this.value, this.newValue, this.x, this.y);
        }
	}
}