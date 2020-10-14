package com.adobe.dashboard.presenter
{
	import com.adobe.dashboard.enum.ReportTypeEnum;
	import com.adobe.dashboard.event.ChartOverviewEvent;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class YearToDatePresenter extends EventDispatcher
	{
		private var dispatcher:IEventDispatcher;

		[Bindable]
		public var chartOverviewPresenter:ChartOverviewPresenter;

		[Bindable]
		public var chartDetailsPresenter:ChartPresenter;


		public function YearToDatePresenter(dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;

			buildPresenters();
		}

		private function buildPresenters():void
		{
			chartOverviewPresenter = new ChartOverviewPresenter(dispatcher);
			chartDetailsPresenter = new ChartPresenter(dispatcher);
		}

		//
		// Public methods
		//

		/**
		 * MY_GROSS_YEAR_BY_MONTH_REPORT
		 */
		public function getMyGrossYearByMonthChartData(getOverview:Boolean = false):void
		{
			if (getOverview)
			{
				// Send along a IChartOverviewDataModel object to be filled with data
				var chartOverviewEvent:ChartOverviewEvent = new ChartOverviewEvent(chartOverviewPresenter, ReportTypeEnum.COMPARISON_MY_VS_GOAL_GROSS_YEAR_REPORT);
				dispatcher.dispatchEvent(chartOverviewEvent);
			}
		}

	}
}