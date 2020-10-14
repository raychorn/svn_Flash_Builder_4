package com {
	import flash.geom.Point;
	
	import mx.formatters.NumberBaseRoundType;
	import mx.formatters.NumberFormatter;

	public class MathHelper {
		public static function setPrecision(val:Number, decimalPlaces:uint):Number {
			var multiplier:uint = Math.pow(10, decimalPlaces);
			var truncatedVal:Number = Math.round(val*multiplier);
			
			return truncatedVal/multiplier;
		} 
		
		public static function precision_to(value:Number,precision:int):Number {
			return MathHelper.setPrecision(value,precision);
		}
		
		public static function radius_of_rectangle(width:Number,height:Number):Number {
			return Math.sqrt(Math.pow(width,2) + Math.pow(height,2)) / 2;
		}
		
		public static function FindAngle(point1:Point, point2:Point):Number {
			var dx:Number = point2.x - point1.x;
			var dy:Number = point2.y - point1.y;
			return -Math.atan2(dx,dy);
		}
		
		public static function asDegrees(atan:Number):Number {
			return atan*180/Math.PI;
		}

		public static function FindAngleAsDegrees(point1:Point, point2:Point):Number {
			return asDegrees(FindAngle(point1,point2));
		}
		
	}
}