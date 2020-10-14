package com {
	import mx.collections.ArrayCollection;
	
	import flashx.textLayout.debug.assert;

	public class TimeUtils {
		public static function all_zeros(value:String):Boolean {
			try {
				var toks:Array = value.split(':');
				var numZeros:int = 0;
				var val:Number;
				for (var i:int = 0; i < toks.length; i++) {
					val = Number(toks[i]);
					if (val == 0) {
						numZeros++;
					}
				}
				trace('all_zeros --> toks.length='+toks.length+', numZeros='+numZeros);
				return numZeros == toks.length;
			} catch (err:Error) {}
			return false;
		}
		
		public static function convertTime(number:Number,formal:Boolean=false):String {
			number = Math.abs(number);
			var values:Array = new Array(5);
			values[0] = Math.floor(number / 86400 / 7);// weeks
			values[1] = Math.floor(number / 86400 % 7);// days
			values[2] = Math.floor(number / 3600 % 24);// hours
			values[3] = Math.floor(number / 60 % 60);// mins
			values[4] = Math.floor(number % 60);// secs
			
			var formals:Array = ['w','d','h','m','s'];
			
			var stopage:Boolean = false;
			var cutIndex:Number = -1;
			
			for (var i:Number = 0; i < values.length; i++) {
				if (values[i] < 10) {
					values[i] = "0" + values[i];
				}
				if (values[i] == "00" && i < (values.length - 2) && !stopage) {
					cutIndex = i;
				} else {
					stopage = true;
				}
			}

			if (formal) {
				for (var n:int = 0; n <= values.length-1; n++) {
					values[n] = values[n] + formals[n];
				}
			}
			
			values.splice(0, cutIndex + 1);
			
			return values.join((formal == false) ? ":" : " ");
		}
		
		public static function unConvertTime(time:String):Number {
			var secs:Number = 0;
			var toks:Array = time.split(':');

			var values:Array = new Array(5);
			values[0] = 86400 * 7; // weeks
			values[1] = 86400;     // days
			values[2] = 3600;      // hours
			values[3] = 60;        // mins
			values[4] = 1;         // secs
			
			var i:int;
			var n:int = values.length - toks.length;
			n = (n < 0) ? 0 : n;
			for (i = 0; i < n; i++) {
				toks.splice(0,0,0);
			}
			DebuggerUtils.assert(values.length == toks.length, 'OOPS !!!');
			
			for (i = 0; i < toks.length; i++) {
				secs += (Number(toks[i]) * values[i]);
			}

			return secs;
		}
	}
}