package com {
	import mx.collections.ArrayCollection;

	public class MathUtils {
		public static function randRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public static function has_fractional_digits(value:Number):Boolean {
			var toks:Array = value.toString().split('.');
			if (toks.length < 2) {
				return false;
			}
			var non_zero_digits:String = String(toks[toks.length-1]).replace('0','');
			return non_zero_digits.length > 0;
		}
		
		public static function num_fractional_digits(value:Number):int {
			var toks:Array = value.toString().split('.');
			if (toks.length < 2) {
				return 0;
			}
			return Number(toks[toks.length-1]).toString().length;
		}
		
		public static function round_to_nearest_magnitude(value:Number):int {
			var c:Number = int(Math.log(value) * Math.LOG10E);
			var n:Number = Math.pow(10,c);
			var response:Number = int(value / n) * n;
			return response;
		}
		
		public static function determine_max_factor(source:*,value:Number):Number {
			var _source:*;
			function factor(num:*,val:*):Number {
				return Number(val) / Number(num);
			}
			if (source is ArrayCollection) {
				_source = source.source;
			} else if (source is Array) {
				_source = source;
			} else if (source is Number) {
				return factor(source,value);
			} else if (ObjectUtils.keys(source).length > 0) {
				_source = source;
			} else if (ObjectUtils.keys(source).length == 0) {
				return -1;
			}
			var result:Number = -1;
			var guess:Number;
			for (var i:String in _source) {
				guess = factor(_source[i],value);
				if (int(guess) > 0) {
					result = Number(i) * guess;
					break;
				}
			}
			return result;
		}
	}
}