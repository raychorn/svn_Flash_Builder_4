package com
{
	import flash.display.Graphics;
	import flash.geom.Point;

	public class VectorUtils {
		public function VectorUtils() {
		}
		
		public static function solve_for_y(pt:Point, slope:Number, b:Number):Point {
			// y = mx + b
			return new Point(pt.x,(pt.x * slope)+b);
		}

		public static function solve_for_y_intercept(pt:Point, slope:Number):Number {
			// b = y - mx
			return pt.y - (slope * pt.x);
		}
		
		public static function solve_for_x(slope:Number, pt:Point, b:Number):Point {
			// x = (b - y)/-m
			return new Point((b-pt.y)/(-slope),pt.y);
		}
		
		public static function distance(p1:Point,p2:Point):Number {
			var dx:Number,dy:Number;
			dx = p2.x-p1.x;
			dy = p2.y-p1.y;
			return Math.sqrt(dx*dx + dy*dy);
		}
		
		public static function calculateSlope(pt1:Point, pt2:Point):Number {
		    return (pt1.y - pt2.y) / (pt1.x - pt2.x);
		}
		
		public static function draw(graphics:Graphics, pt1:Point, pt2:Point):void {
		    graphics.moveTo(pt1.x, pt1.y);
		    graphics.lineTo(pt2.x, pt2.y)
		}		

		public static function precision_to(pt:Point,precision:int):Point {
			    return new Point(MathHelper.precision_to(pt.x,precision),MathHelper.precision_to(pt.y,precision));
		}
		
	}
}