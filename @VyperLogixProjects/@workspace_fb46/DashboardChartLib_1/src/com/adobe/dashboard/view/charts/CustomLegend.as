package com.adobe.dashboard.view.charts
{
	import com.adobe.dashboard.model.LegendModel;

	import flash.display.Shape;
	import flash.text.TextField;
	import flash.text.TextFormat;

	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;

	public class CustomLegend extends UIComponent
	{
		public var swatchHeight:int = 18;

		public var swatchWidth:int = 18;

		public var textWidth:int = 200;

		public var legendFontSize:Number = 12;


		private var _colorList:Array = [];

		public function get colorList():Array
		{
			return _colorList;
		}

		public function set colorList(value:Array):void
		{
			_colorList = value;
			invalidateDisplayList();
		}


		public var labelList:Array = [];

		private var _dataProvider:ArrayCollection;

		public function get dataProvider():ArrayCollection
		{
			return _dataProvider;
		}


		protected var tfList:Array = [];

		public function set dataProvider(value:ArrayCollection):void
		{
			_dataProvider = value;
			invalidateDisplayList();
		}

		public var itemList:Array = [];

		public var vGap:int = 18;

		public var hGap:int = 18;


		protected var textHolder:Shape;


		/**
		 * Constuctor
		 */
		public function CustomLegend()
		{
			super();

			minHeight = 100;
			minWidth = 100;
		}


		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);


			removeAll();

			itemList = [];

			graphics.clear();

			drawBackground();


			var i:int = 0;
			for each (var o:Object in dataProvider)
			{
				var item:LegendModel = new LegendModel(colorList[i], o.clientName);
				itemList.push(item);
				i++;

				if (i > colorList.length - 1)
				{
					i = 0;
				}
			}

			layoutContents();
		}


		protected function drawBackground():void
		{
			graphics.beginFill(0xFFFFFF, 0);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();

		}

		protected function layoutContents():void
		{
			var xPos:int = 0;
			var yPos:int = 0;


			var i:int = 0;
			for each (var item:com.adobe.dashboard.model.LegendModel in itemList)
			{
				drawSwatch(xPos, yPos, swatchWidth, swatchHeight, item.color);
				drawTextField(xPos + swatchWidth + 5, yPos -5, textWidth, swatchHeight, item.label);

				yPos = yPos + swatchHeight + vGap;

				if (yPos + swatchHeight > unscaledHeight)
				{
					yPos = 0;
					xPos = xPos + hGap + textWidth;
				}

				i++;
			}

		}

		protected function drawSwatch(x:int, y:int, width:int, height:int, color:uint):void
		{
			graphics.beginFill(color);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();
		}

		protected function drawTextField(x:int, y:int, width:int, height:int, text:String):void
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("_sans", legendFontSize, 0x999999);
			tf.mouseEnabled = false;
			tf.selectable = false;
			tf.text = text;
			tf.width = width;
			tf.x = x;
			tf.y = y;
			addChild(tf);
		}



		private function removeAll():void
		{
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
		}
	}
}