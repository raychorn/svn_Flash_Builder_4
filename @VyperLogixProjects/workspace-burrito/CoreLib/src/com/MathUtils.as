package com {
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;

	public class MathUtils {
		public static function randRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
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