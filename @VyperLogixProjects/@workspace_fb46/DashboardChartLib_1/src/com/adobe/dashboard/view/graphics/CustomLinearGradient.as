package com.adobe.dashboard.view.graphics
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import mx.core.mx_internal;
	import mx.graphics.LinearGradient;

	use namespace mx_internal;

	public class CustomLinearGradient extends LinearGradient
	{
		protected var bounds:Rectangle;

		public function CustomLinearGradient()
		{
			super();
		}

		override public function begin(target:Graphics, targetBounds:Rectangle, targetOrigin:Point):void
		{
			super.begin(target, targetBounds, targetOrigin);
			bounds=targetBounds;
		}

		public var drawDelay:int=0;

		override public function end(target:Graphics):void
		{
			super.end(target);
			if (drawDelay > 0)
			{
				setTimeout(drawPattern, 1, target);
			}
			else
			{
				drawPattern(target);
			}


		}

		protected function drawPattern(target:Graphics):void
		{
			target.lineStyle(2, 0, .25, false, "normal", "miter");
			for (var i:int=0; i < bounds.width + bounds.height; i+=4)
			{
				var startPoint:Point=new Point();
				var endPoint:Point=new Point();
				if (i <= bounds.width)
				{
					startPoint=new Point(i, 0);
				}
				else
				{
					startPoint=new Point(bounds.width, i - bounds.width);
				}
				if (i < bounds.height)
				{
					endPoint=new Point(0, i);
				}
				else
				{
					endPoint=new Point(i - bounds.height, bounds.height);
				}

				target.moveTo(startPoint.x, startPoint.y);
				target.lineTo(endPoint.x, endPoint.y);
			}
			target.lineStyle(3, colors[colors.length - 1], 1, false, "normal", "miter");

			if (rotation == 0)
			{
				target.moveTo(bounds.width, 1);
				target.lineTo(bounds.width, bounds.height - 1);
			}
			else if (rotation == -90)
			{
				target.moveTo(1, 0);
				target.lineTo(bounds.width - 1, 0);
			}
		}
	}
}
