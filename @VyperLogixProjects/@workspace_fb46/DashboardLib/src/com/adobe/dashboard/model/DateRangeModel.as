package com.adobe.dashboard.model
{

	public class DateRangeModel
	{

		public var label:String;

		public var value:Number;

		public var dateRange:String;

		public var startDate:Date;

		public var endDate:Date;



		public function DateRangeModel(label:String = "", dateRange:String = "", startDate:Date = null, endDate:Date = null)
		{
			this.label = label;
			this.dateRange = dateRange;
			this.startDate = startDate;
			this.endDate = endDate;
		}
	}
}