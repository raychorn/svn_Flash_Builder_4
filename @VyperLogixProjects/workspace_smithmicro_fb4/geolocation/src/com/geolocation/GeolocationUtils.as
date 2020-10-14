package com.geolocation {
	import flash.events.TimerEvent;
	import flash.system.Capabilities;
	import flash.utils.Timer;

	public class GeolocationUtils {
		public static var geo:* = {};
		
		public static var result:Object;
		public static var callback:Function;

		private static function handle_events(event:*):void {
			result.latitude = event.latitude;
			result.longitude = event.longitude;
			result.altitude = event.altitude;
			result.heading = event.heading;
			result.horizontalAccuracy = event.horizontalAccuracy;
			result.speed = event.speed;
			result.timestamp = event.timestamp;
			result.type = event.type;
			result.verticalAccuracy = event.verticalAccuracy;
			if (callback is Function) {
				try {callback(result);} catch (err:Error) {callback(err);}
			}
		}

		public static function GeolocationTest(_callback:Function=null):Object {
			if (Capabilities.isDebugger) {
				result = {};
				callback = _callback;
				if (Capabilities.isDebugger) {
					var timer:Timer = new Timer(250);
					timer.repeatCount = 1;
					timer.addEventListener(TimerEvent.TIMER, 
						function (event:TimerEvent):void {
							timer.stop();
						}
					);
					timer.start();
				}
			}
			return result;
		}
	}
}