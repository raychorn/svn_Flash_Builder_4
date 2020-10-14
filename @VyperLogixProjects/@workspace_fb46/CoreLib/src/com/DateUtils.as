package com {
	import mx.formatters.NumberFormatter;

	public class DateUtils {
		public static function epoch_now():Number {
			var now:Date = new Date();
			var epoch:Number = Date.UTC(now.fullYear, now.month, now.date, now.hours, now.minutes, now.seconds, now.milliseconds);
			return epoch;
		}
		
		public static function getMilliSecondsBetweenDates(date1:Date,date2:Date):Number {
			var date1_ms:Number = date1.getTime();
			var date2_ms:Number = date2.getTime();		    
			var difference_ms:Number = Math.abs(date1_ms - date2_ms)		    
			return difference_ms;
		}
		
		public static function getDaysBetweenDates(date1:Date,date2:Date):int {
			var one_day:Number = 1000 * 60 * 60 * 24
			var difference_ms:Number = getMilliSecondsBetweenDates(date1,date2);		    
			return Math.round(difference_ms/one_day);
		}
		
		public static function parseUTCDate( str:String ):Date {
			var utc:String = ' UTC';
			if (str.indexOf(utc) == -1) {
				throw(new Error(DebuggerUtils.getFunctionName(new Error())+"::ERROR: Invalid Date - Missing"+utc+" !!!"));
			}
			var matches : Array = str.replace(utc,'').match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)/);
			
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
			var mm:int = date.month+1;
			var dd:int = date.date;
			var hours:int = date.hours;
			var mins:int = date.minutes;
			var secs:int = date.seconds;
			return date.fullYear.toString()+"-"+((mm < 10) ? "0" : "")+mm.toString()+"-"+((dd < 10) ? "0" : "")+dd.toString()+" "+((hours < 10) ? "0" : "")+hours.toString()+":"+((mins < 10) ? "0" : "")+mins.toString()+":"+((secs < 10) ? "0" : "")+secs.toString();
		}
		
		public static function toShortDateUTCString(date:Date):String {
			// "2011-06-30 02:16:36"
			var mm:int = date.monthUTC+1;
			var dd:int = date.dateUTC;
			var hours:int = date.hoursUTC;
			var mins:int = date.minutesUTC;
			var secs:int = date.secondsUTC;
			return ((mm < 10) ? "0" : "")+mm.toString()+"-"+((dd < 10) ? "0" : "")+dd.toString()+"-"+date.fullYear.toString()+" "+((hours < 10) ? "0" : "")+hours.toString()+":"+((mins < 10) ? "0" : "")+mins.toString()+":"+((secs < 10) ? "0" : "")+secs.toString();
		}
		
		public static function toShortUTCDateString(date:Date):String {
			// "2011-06-30 02:16:36 UTC"
			var mm:int = date.monthUTC+1;
			var dd:int = date.dateUTC;
			var hours:int = date.hoursUTC;
			var mins:int = date.minutesUTC;
			var secs:int = date.secondsUTC;
			return date.fullYearUTC.toString()+"-"+((mm < 10) ? "0" : "")+mm.toString()+"-"+((dd < 10) ? "0" : "")+dd.toString()+" "+((hours < 10) ? "0" : "")+hours.toString()+":"+((mins < 10) ? "0" : "")+mins.toString()+":"+((secs < 10) ? "0" : "")+secs.toString()+' UTC';
		}
		
	}
}