package com.time {
	
	public class TimeStringUtil {
		//Format:  hh:mm am/pm or h:mm am/pm
		//This time format is assumed throughout this component, but can be modified by updating the following
		//lines of code that pull the indexOf.
		
		public static function getHour( tStr:String ):String {
			var hour:String;
			if( tStr == "" || tStr == null ) {
				//Check for an empty string
				hour = "";
			} else {
				var idx:int = tStr.indexOf(":");
				hour = tStr.substr(0, idx);
			}
			return hour;
		}
		
		public static function getMinute( tStr:String ):String {
			var min:String;
			if( tStr == "" || tStr == null ) {
				min = "";
			} else {
				min = tStr.substr(tStr.indexOf(":"), 2);
			}
			return min;
		}
		
		// get AM/PM portion
		public static function getMeridien( tStr:String ):String {
			var ampm:String;
			if( tStr == "" || tStr == null ) {
				ampm = "";
			} else {
				ampm = tStr.substr( -2, 2 );
			}
			return ampm;
		}
		
		public static function setFullTime( hour:String, min:String, ampm:String ):String {
			if( min.length == 1 ) {
				min = "0" + min;
			}
			var tStr:String = hour + ":" + min + " " + ampm;
			return tStr;
		}
	}
}