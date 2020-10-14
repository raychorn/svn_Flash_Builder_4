package com {
	import mx.formatters.NumberFormatter;

	public class DateUtils {
		public static function epoch_now():Number {
			var now:Date = new Date();
			var epoch:Number = Date.UTC(now.fullYear, now.month, now.date, now.hours, now.minutes, now.seconds, now.milliseconds);
			return epoch;
		}
		
		public static function parseUTCDate( str:String ):Date {
			var matches : Array = str.match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)Z/);
			
			var d : Date = new Date();
			
			d.setUTCFullYear(int(matches[1]), int(matches[2]) - 1, int(matches[3]));
			d.setUTCHours(int(matches[4]), int(matches[5]), int(matches[6]), 0);
			
			return d;
		}
		
		public static function parseDate( str:String):Date {
			var matches : Array = str.match(/(\d\d\d\d)-(\d\d)-(\d\d)/);
			
			var d : Date = new Date();
			
			d.setUTCFullYear(int(matches[1]), int(matches[2]) - 1, int(matches[3]));
			
			return d;
		}
		
		public static function toShortDateString(date:Date):String {
			// "2011-06-30 02:16:36"
			return date.fullYear.toString()+"-"+((date.month < 10) ? "0" : "")+date.month.toString()+"-"+((date.day < 10) ? "0" : "")+date.day.toString()+" "+((date.hours < 10) ? "0" : "")+date.hours.toString()+":"+((date.minutes < 10) ? "0" : "")+date.minutes.toString()+":"+((date.seconds < 10) ? "0" : "")+date.seconds.toString();
		}
	}
}