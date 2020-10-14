package controls.timers {
	import com.ArrayUtils;
	
	import flash.events.TimerEvent;

	public class TimerProcessor {
		public function TimerProcessor() {
		}

		public static function reduce_time_spec_by_one_second(date_spec:String):String {
			var toks:Array;
			if (date_spec is String) {
				toks = date_spec.split(':');
				var i:int = toks.length-1;
				var value:int = int(toks[i]) - 1;
				if (value < 0) {
					toks[i] = '59';
					if (i > 0) {
						i--;
					}
					value = int(toks[i]) - 1;
					if (value < 0) {
						toks[i] = '59';
						if (i > 0) {
							i--;
						}
						value = int(toks[i]) - 1;
						if (value < 0) {
							toks[i] = '23';
							if (i > 0) {
								i--;
							}
							value = int(toks[i]) - 1;
							if (value < 0) {
								toks[i] = '0';
							} else {
								toks[i] = value.toString();
							}
						} else {
							toks[i] = value.toString();
						}
					} else {
						toks[i] = value.toString();
					}
				} else {
					toks[i] = value.toString();
				}
			}
			ArrayUtils.iterate(toks, 
				function (item:*, i:int, source:*):void {
					var value:String;
					if (source) {
						value = int(source[i]).toString();
						source[i] = ((value.length < 2) ? '0' : '') + value;
					}
				}
			);
			return toks.join(':');
		}
		
		public static function parse_date_to_milliseconds(date_spec:String):Number {
			var toks:Array;
			var values:Array = [24*60*60*1000,60*60*1000,60*1000,1000];
			var milliseconds:Number = 0;
			if (date_spec is String) {
				toks = date_spec.split(':');
				ArrayUtils.iterate(toks, 
					function (item:*, i:int, source:*):void {
						if (source) {
							source[i] = int(source[i]);
							var bias:int = values.length - source.length;
							if ( (source is Array) && (bias >= 0) ) {
								var num:Number = (source[i] * values[i+bias]);
								trace('(+++) --> source['+i+']='+source[i]+', values['+(i+bias)+']='+values[i+bias]+', bias='+bias);
								milliseconds += num;
							}
						}
					}
				);
			}
			return milliseconds;
		}
		
		public static function deltaTime(targetDate:Date):String {
			var counter:String;
			var today:Date = new Date();
			var currentYear:Number = today.getFullYear();
			var currentTime:Number = today.getTime();
			if (targetDate is Date) {
				var targetTime:Number = targetDate.getTime();
				var timeLeft:Number = targetTime - currentTime;
				trace('deltaTime.1 --> targetTime='+targetTime+', timeLeft='+timeLeft);
				var sec:Number = Math.floor(timeLeft/1000);
				var min:Number = Math.floor(sec/60);
				var hour:Number = Math.floor(min/60);
				var day:Number = Math.floor(hour/24);
				var secs:String = String(sec % 60);
				if (secs.length < 2) {
					secs = "0" + secs;
				}
				var mins:String = String(min % 60);
				if (mins.length < 2) {
					mins = "0" + mins;
				}
				var hours:String = String(hour % 24);
				if (hours.length < 2) {
					hours = "0" + hours;
				}
				var days:String = String(day);
				if ( (!(days is String)) || (days == null) || (days.toLowerCase() == 'null') ) {
					days = '00';
				} else if (days.length < 2) {
					days = "0" + days;
				}
				
				if (timeLeft > 0 ) {
					counter = days + ":" + hours + ":" + mins + ":" + secs;
				} else {
					trace("TIME'S UP");
					counter = "00:00:00:00";
				}
			}
			return counter;
		}
		
	}
}