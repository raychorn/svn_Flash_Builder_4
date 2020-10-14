package skins.components
{
	import flash.display.GradientType;
	import flash.geom.Matrix;

	import spark.skins.mobile.TextInputSkin;

	public class CustomTextInputSkin extends TextInputSkin
	{
		public function CustomTextInputSkin()
		{
			super();
		}

		override protected function drawBackground(unscaledWidth:Number,
												   unscaledHeight:Number):void
		{
			// draw the contentBackgroundColor
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(unscaledWidth, unscaledHeight, Math.PI / 2, 0, 0);

			// custom backgroun color
			graphics.clear();
			graphics.beginGradientFill(GradientType.LINEAR, [ 0x4C4C4C, 0x282828 ], [ 1, 1 ], [ 1, 255 ], matrix);
			graphics.drawRoundRect(0, 0, unscaledWidth, unscaledHeight, 0, 0);
			graphics.endFill();
			
			this.textDisplay.y = this.height/2 - this.textDisplay.height/2;
		}

	}
}