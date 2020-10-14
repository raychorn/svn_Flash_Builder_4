package com.adobe.dashboard.model.chart
{

	public class CompanySalesModel
	{

		private var _clientName:String;

		[Bindable]
		public function get clientName():String
		{
			return _clientName;
		}

		public function set clientName(value:String):void
		{
			_clientName=value;
		}


		private var _gross:Number;

		[Bindable]
		public function get gross():Number
		{
			return _gross;
		}

		public function set gross(value:Number):void
		{
			_gross=value;
		}


		private var _myGross:Number;

		[Bindable]
		public function get myGross():Number
		{
			return _myGross;
		}

		public function set myGross(value:Number):void
		{
			_myGross=value;
		}

		private var _year:int;

		[Bindable]
		public function get year():int
		{
			return _year;
		}

		public function set year(value:int):void
		{
			_year=value;
		}


		public function CompanySalesModel()
		{
		}
	}
}
