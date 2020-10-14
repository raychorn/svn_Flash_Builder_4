package com.adobe.dashboard.view.graphics
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.GraphicsStroke;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import mx.graphics.LinearGradientStroke;

	public class CustomLinearGradientStroke extends LinearGradientStroke
	{
		public function CustomLinearGradientStroke(weight:Number=1, pixelHinting:Boolean=false, scaleMode:String="normal", caps:String="round", joints:String="round", miterLimit:Number=3)
		{
			super(weight, pixelHinting, scaleMode, caps, joints, miterLimit);
		}

		override public function apply(graphics:Graphics, targetBounds:Rectangle, targetOrigin:Point):void
		{

			graphics.lineStyle(weight, 0, 1, pixelHinting, scaleMode, caps, joints, miterLimit);


			var fillType:String=GradientType.LINEAR;
			var colors:Array=[0x262626, 0];
			var alphas:Array=[1, 0];
			var ratios:Array=[127.5, 127.5];
			var matr:Matrix=new Matrix();
			matr.createGradientBox(10, 10, rotation, 0, 0);
			var spreadMethod:String=SpreadMethod.REPEAT;

			graphics.lineGradientStyle(fillType, colors, alphas, ratios, matr, spreadMethod);
		}

	}
}
