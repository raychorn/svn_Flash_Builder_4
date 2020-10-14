package com.adobe.dashboard.model
{
	import flash.events.Event;

	public class ChartModel implements IChartModel
	{
		private var _id:int;

		[Bindable]
		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		private var _reportType:String;

		[Bindable]
		public function get reportType():String
		{
			return _reportType;
		}

		public function set reportType(value:String):void
		{
			_reportType = value;
		}


		private var _chartType:String;

		[Bindable]
		public function get chartType():String
		{
			return _chartType;
		}

		public function set chartType(value:String):void
		{
			_chartType = value;
		}


		private var _title:String;

		[Bindable]
		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

		private var _fromDate:Date;

		[Bindable]
		public function get fromDate():Date
		{
			return _fromDate;
		}

		public function set fromDate(value:Date):void
		{
			_fromDate = value;
		}

		private var _toDate:Date;

		[Bindable]
		public function get toDate():Date
		{
			return _toDate;
		}

		public function set toDate(value:Date):void
		{
			_toDate = value;
		}


		private var _showLegend:Boolean;

		public function get showLegend():Boolean
		{
			return _showLegend;
		}

		public function set showLegend(value:Boolean):void
		{
			_showLegend = value;
		}

		private var _inDashboard:Boolean;

		public function get inDashboard():Boolean
		{
			return _inDashboard;
		}

		public function set inDashboard(value:Boolean):void
		{
			_inDashboard = value;
		}



		public function ChartModel(id:int,
								   reportType:String = null, chartType:String = null,
								   title:String = null,
								   fromDate:Date = null, toDate:Date = null,
								   showLegend:Boolean = false, inDashboard:Boolean = false)
		{
			_id = id;
			_reportType = reportType;
			_chartType = chartType;
			_title = title;
			_fromDate = fromDate;
			_toDate = toDate;
			_showLegend = showLegend;
			_inDashboard = inDashboard;
		}


		/**
		 * parse an XML object into a ChartModel
		 */
		public static function fromXML(x:XML):ChartModel
		{
			var id:int = parseInt(x.id);

			var fromDate:Date = new Date();
			fromDate.time = Date.parse(x.fromDate);

			var toDate:Date = new Date();
			toDate.time = Date.parse(x.toDate);

			var showLegend:Boolean = x.showLegend == "true";

			var inDashboard:Boolean = x.inDashboard == "true";

			return new ChartModel(id, x.reportType, x.chartType, x.title, fromDate, toDate, showLegend, inDashboard);
		}

		public function clone():IChartModel
		{
			var chart:IChartModel = new ChartModel(_id, _reportType, _chartType, _title, _fromDate, _toDate, _showLegend, _inDashboard);
			return chart;
		}
	}
}