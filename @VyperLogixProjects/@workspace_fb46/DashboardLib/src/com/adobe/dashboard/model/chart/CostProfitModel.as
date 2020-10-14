package com.adobe.dashboard.model.chart
{

	public class CostProfitModel implements IChartOverviewDataModel
	{
		private var _cost:Number;

		public function get cost():Number
		{
			return _cost;
		}

		public function set cost(value:Number):void
		{
			_cost=value;
		}


		private var _profit:Number;

		public function get profit():Number
		{
			return _profit;
		}

		public function set profit(value:Number):void
		{
			_profit=value;
		}


		private var _costLabel:String;

		public function get costLabel():String
		{
			return _costLabel;
		}

		public function set costLabel(value:String):void
		{
			_costLabel=value;
		}


		private var _profitLabel:String;

		public function get profitLabel():String
		{
			return _profitLabel;
		}

		public function set profitLabel(value:String):void
		{
			_profitLabel=value;
		}



		public function CostProfitModel(cost:Number, profit:Number, costLabel:String="Cost", profitLabel:String="Profit")
		{
			_cost=cost;
			_profit=profit;
			_costLabel=costLabel;
			_profitLabel=profitLabel;
		}
	}
}
