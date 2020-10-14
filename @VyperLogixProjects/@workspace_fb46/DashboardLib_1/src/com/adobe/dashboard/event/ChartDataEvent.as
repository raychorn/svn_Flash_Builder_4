package com.adobe.dashboard.event
{
	import com.adobe.dashboard.presenter.ChartPresenter;

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import mx.charts.chartClasses.ChartElement;

	public class ChartDataEvent extends Event
	{
		public static const GET_CHART_DATA_EVENT:String="getChartDataEvent";

		/**
		 * the instance of the ChartPresetner the data is for
		 */
		private var _presenter:ChartPresenter;

		public function get presenter():ChartPresenter
		{
			return _presenter;
		}

		/**
		 * the report type. Use enum type from ReportTypeEnum
		 */
		private var _reportType:String;

		public function get reportType():String
		{
			return _reportType;
		}

		/**
		 * the start date to pull range from
		 */
		private var _startDate:Date;

		public function get startDate():Date
		{
			return _startDate;
		}

		/**
		 * the end date to pull range from
		 */
		private var _endDate:Date;

		public function get endDate():Date
		{
			return _endDate;
		}


		/**
		 * constuctor
		 */
		public function ChartDataEvent(presenter:ChartPresenter, reportType:String, startDate:Date=null, endDate:Date=null)
		{
			super(GET_CHART_DATA_EVENT);

			_presenter=presenter;
			_reportType=reportType;
			_startDate=startDate;
			_endDate=endDate;
		}

		/**
		 * always override the clone method
		 */
		override public function clone():Event
		{
			return new ChartDataEvent(_presenter, _reportType, _startDate, _endDate);
		}
	}
}
