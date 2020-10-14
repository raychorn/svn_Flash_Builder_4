package com.adobe.dashboard.model.chart
{

	public class SaleOportunityModel
	{

		private var _companyName:String;

		public function get companyName():String
		{
			return _companyName;
		}

		public function set companyName(value:String):void
		{
			_companyName=value;
		}


		private var _expectedCloseDate:Date;

		public function get expectedCloseDate():Date
		{
			return _expectedCloseDate;
		}

		public function set expectedCloseDate(value:Date):void
		{
			_expectedCloseDate=value;
		}


		private var _expectedGross:Number

		public function get expectedGross():Number
		{
			return _expectedGross;
		}

		public function set expectedGross(value:Number):void
		{
			_expectedGross=value;
		}

		public function SaleOportunityModel()
		{
		}
	}
}
