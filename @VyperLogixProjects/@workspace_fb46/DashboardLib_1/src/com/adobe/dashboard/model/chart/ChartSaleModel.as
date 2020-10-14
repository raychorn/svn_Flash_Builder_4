package com.adobe.dashboard.model.chart
{

	public class ChartSaleModel
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


		private var _myNet:Number;

		public function get myNet():Number
		{
			return _myNet;
		}

		public function set myNet(value:Number):void
		{
			_myNet=value;
		}


		private var _myCost:Number;

		public function get myCost():Number
		{
			return _myCost;
		}

		public function set myCost(value:Number):void
		{
			_myCost=value;
		}


		private var _companyGross:Number;

		public function get companyGross():Number
		{
			return _companyGross;
		}

		public function set companyGross(value:Number):void
		{
			_companyGross=value;
		}


		private var _companyNet:Number;

		public function get companyNet():Number
		{
			return _companyNet;
		}

		public function set companyNet(value:Number):void
		{
			_companyNet=value;
		}


		private var _companyCost:Number;

		public function get companyCost():Number
		{
			return _companyCost;
		}

		public function set companyCost(value:Number):void
		{
			_companyCost=value;
		}


		private var _goalGross:Number;

		public function get goalGross():Number
		{
			return _goalGross;
		}

		public function set goalGross(value:Number):void
		{
			_goalGross=value;
		}


		private var _accumulatedGross:Number;

		public function get accumulatedGross():Number
		{
			return _accumulatedGross;
		}

		public function set accumulatedGross(value:Number):void
		{
			_accumulatedGross=value;
		}


		private var _accumulatedNet:Number;

		public function get accumulatedNet():Number
		{
			return _accumulatedNet;
		}

		public function set accumulatedNet(value:Number):void
		{
			_accumulatedNet=value;
		}


		private var _date:Date;

		[Bindable]
		public function get date():Date
		{
			return _date;
		}

		public function set date(value:Date):void
		{
			_date=value;
		}


		public function ChartSaleModel(companyName:String=null, myGross:Number=NaN, myNet:Number=NaN, myCost:Number=NaN, companyGross:Number=NaN, companyNet:Number=NaN, companyCost:Number=NaN, goalGross:Number=NaN, accumulatedGross:Number=NaN, accumulatedNet:Number=NaN, date:Date=null)
		{
			_clientName=companyName;
			_myGross=myGross;
			_myNet=myNet;
			_myCost=myCost;
			_companyGross=companyGross;
			_companyNet=companyNet;
			_companyCost=companyCost;
			_goalGross=goalGross;
			_accumulatedGross=accumulatedGross;
			_accumulatedNet=accumulatedNet;
			_date=date;
		}
	}
}
