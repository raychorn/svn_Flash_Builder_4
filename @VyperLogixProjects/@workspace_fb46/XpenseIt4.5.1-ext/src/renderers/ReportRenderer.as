package renderers
{
	import assets.HeaderBarDiv;
	
	import dao.Report;
	
	import events.ReportEvent;
	
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
	import mx.graphics.SolidColorStroke;
	
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.LabelItemRenderer;
	import spark.formatters.CurrencyFormatter;
	import spark.formatters.DateTimeFormatter;
	import spark.primitives.Line;
	
	public class ReportRenderer extends LabelItemRenderer
	{
		public var labelField:String;
		public var dateField:String;
		public var amountField:String;
		
		protected var dateLabel:Label;
		protected var totalLabel:Label;
		protected var rightBox:Group;
		protected var divider:Line;
		
		protected var dtf:DateTimeFormatter;
		protected var cf:CurrencyFormatter;
		
		public function ReportRenderer()
		{
			super();
			dtf = new DateTimeFormatter();
			dtf.dateTimePattern = "EEEE, MMM dd yyyy";
			cf = new CurrencyFormatter();
			cf.useCurrencySymbol = true;
			
			addEventListener(MouseEvent.CLICK, dispatchReportEvent);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			labelDisplay.text = value[labelField];
			dateLabel.text = dtf.format(value[dateField]);
			totalLabel.text = cf.format(value[amountField]);
		} 
		
		override protected function createChildren():void
		{
			super.createChildren();

			labelDisplay.mouseEnabled = false;
			
			dateLabel = new Label();
			dateLabel.styleName = "expenseDate";
			dateLabel.mouseEnabled = false;
			addChild(dateLabel);

			totalLabel = new Label();
			totalLabel.styleName = "expenseAmount";
			totalLabel.mouseEnabled = false;
			addChild(totalLabel);
			
			rightBox = new Group();
			divider = new Line();
			divider.stroke = new SolidColorStroke(0xCCCCCC, 1);
			divider.top = 0;
			divider.bottom = 0;
			rightBox.addElement(divider);
			rightBox.mouseEnabled = false;
			addChild(rightBox);

		}
		
		protected function dispatchReportEvent(event:MouseEvent):void
		{
			if (event.localX < (width-100)) 
				dispatchEvent(new ReportEvent(ReportEvent.EDIT_REPORT, data));
			else
				dispatchEvent(new ReportEvent(ReportEvent.VIEW_EXPENSES, data));
		}

		override protected function measure():void
		{
			var horizontalPadding:Number = getStyle("paddingLeft") + getStyle("paddingRight");
			var verticalPadding:Number = getStyle("paddingTop") + getStyle("paddingBottom");
			measuredWidth = getElementPreferredWidth(labelDisplay) + horizontalPadding;
			measuredHeight = getElementPreferredHeight(labelDisplay) + getElementPreferredHeight(dateLabel) + verticalPadding + 8; 
			measuredMinWidth = 0;
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var paddingLeft:Number   = getStyle("paddingLeft"); 
			var paddingRight:Number  = getStyle("paddingRight");
			var paddingTop:Number    = getStyle("paddingTop");
			var paddingBottom:Number = getStyle("paddingBottom");
			var verticalAlign:String = getStyle("verticalAlign");
			
			var labelWidth:Number = unscaledWidth - paddingLeft - paddingRight;
			var labelHeight:Number = getElementPreferredHeight(labelDisplay);
			setElementSize(labelDisplay, labelWidth, labelHeight);    
			setElementPosition(labelDisplay, paddingLeft, paddingTop);
			
			var dateLabelWidth:Number = getElementPreferredWidth(dateLabel);
			var dateLabelHeight:Number = getElementPreferredHeight(dateLabel);
			setElementSize(dateLabel, dateLabelWidth, dateLabelHeight);
			setElementPosition(dateLabel, paddingLeft, paddingTop + labelHeight + 8);
			
			var totalLabelWidth:Number = getElementPreferredWidth(totalLabel);
			var totalLabelHeight:Number = getElementPreferredHeight(totalLabel);
			setElementSize(totalLabel, totalLabelWidth, totalLabelHeight);
			setElementPosition(totalLabel, unscaledWidth - paddingRight - totalLabelWidth, paddingTop + labelHeight + 8);
			
			setElementSize(rightBox, 1, unscaledHeight - 2);
			setElementPosition(rightBox, unscaledWidth - 100, 1);
		}
		
	}
}