package com.adobe.dashboard.event
{

	import flash.events.Event;
	import com.adobe.dashboard.presenter.ChartOverviewPresenter;

	public class ChartOverviewEvent extends Event
	{
		public static const GET_CHART_OVERVIEW_DATA_EVENT:String="getChartOverviewDataEvent";

		/**
		 * the instance of the ChartOverviewPresenter the data is for
		 */
		private var _presenter:ChartOverviewPresenter;

		public function get presenter():ChartOverviewPresenter
		{
			return _presenter;
		}

		/**
		 * ReportTypeEnum
		 */
		private var _reportType:String;

		public function get reportType():String
		{
			return _reportType;
		}


		/**
		 * constuctor
		 */
		public function ChartOverviewEvent(presenter:ChartOverviewPresenter, reportType:String)
		{
			super(GET_CHART_OVERVIEW_DATA_EVENT);

			_presenter=presenter;
			_reportType=reportType;
		}

		/**
		 * always override the clone method
		 */
		override public function clone():Event
		{
			return new ChartOverviewEvent(_presenter, _reportType);
		}
	}
}
