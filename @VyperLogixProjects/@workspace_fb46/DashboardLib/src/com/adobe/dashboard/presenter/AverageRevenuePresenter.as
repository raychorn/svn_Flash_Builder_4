package com.adobe.dashboard.presenter
{
	import com.adobe.dashboard.enum.*;
	import com.adobe.dashboard.event.*;
	import com.adobe.dashboard.model.*;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import mx.collections.ArrayCollection;

	public class AverageRevenuePresenter extends EventDispatcher
	{
		private var dispatcher:IEventDispatcher;

		[Bindable]
		public var currentState:String;

		[Bindable]
		public var chartOverviewPresenter:ChartOverviewPresenter;

		[Bindable]
		public var chartMainPresenter:ChartPresenter;


		private var _chartDetailsPresenter:ChartPresenter;

		[Bindable]
		public var detailsLabel:String;

		[Bindable]
		public var detailsType:String;

		[Bindable]
		public var isColumnChart:Boolean=false;


		[Bindable]
		public var showTourTip:Boolean=true;

		[Bindable]
		public var skipAnimation:Boolean=false;

		/**
		 * Constuctor
		 */
		public function AverageRevenuePresenter(dispatcher:IEventDispatcher)
		{
			this.dispatcher=dispatcher;

			buildPresenters();
		}

		//
		// Build presenters
		//

		[Bindable]
		public function get chartDetailsPresenter():ChartPresenter
		{
			return _chartDetailsPresenter;
		}

		public function set chartDetailsPresenter(value:ChartPresenter):void
		{
			_chartDetailsPresenter=value;
		}

		private function buildPresenters():void
		{
			chartOverviewPresenter=new ChartOverviewPresenter(dispatcher);
			chartMainPresenter=new ChartPresenter(dispatcher);
			chartDetailsPresenter=new ChartPresenter(dispatcher);
		}


		//
		// Public methods
		//

		public function goDetails(type:String):void
		{
			detailsType=type;

			var evt:NavigationEvent=new NavigationEvent(NavigationEvent.GO_STATE_EVENT, StateEnum.AVERAGE_REVENUE_PER_SALE_DETAILS_STATE);
			dispatcher.dispatchEvent(evt);

		}

		public function getDetailsData():void
		{
			if (detailsType == null)
			{
				throw new Error("Must set detailsStatusType");
			}

			switch (detailsType)
			{
				case "cost":
				{
					getMyCostsDetails();
					break;
				}
				case "profit":
				{
					getMyProfitDetails();
					break;
				}
				default:
				{
					// do nothing
					break;
				}
			}
		}

		public function getChartData(chartPresenter:ChartPresenter, reportType:String, startDate:Date=null, endDate:Date=null):void
		{
			var evt:ChartDataEvent=new ChartDataEvent(chartPresenter, reportType, startDate, endDate);
			dispatcher.dispatchEvent(evt);
		}


		/**
		 * COMPARISON_MY_COST_VS_PROFIT_REPORT
		 */
		public function getMyCostVsProfitChartData(getOverview:Boolean=false):void
		{
			if (getOverview)
			{
				// Send along a IChartOverviewDataModel object to be filled with data
				var chartOverviewEvent:ChartOverviewEvent=new ChartOverviewEvent(chartOverviewPresenter, ReportTypeEnum.COMPARISON_MY_COST_VS_PROFIT_REPORT);
				dispatcher.dispatchEvent(chartOverviewEvent);
			}
			else
			{
				// Clear the dataProvider
				chartMainPresenter.dataProvider=null;

				// Populate chartModel
				chartMainPresenter.chartModel=new ChartModel(-1, null, ChartTypeEnum.COLUMN_CHART);

				// Make the SeriesModel's
				var s1:SeriesModel=new SeriesModel("", "value", "label");
				chartMainPresenter.seriesList=new ArrayCollection([s1]);


				var chartDataEvent:ChartDataEvent=new ChartDataEvent(chartMainPresenter, ReportTypeEnum.COMPARISON_MY_COST_VS_PROFIT_REPORT);
				dispatcher.dispatchEvent(chartDataEvent);
			}
		}

		/**
		 * COMPARISON_COMPANY_NET_VS_GROSS_REPORT
		 */
		public function getCompanyProfitVsCostData():void
		{
			// Clear the dataProvider
			chartMainPresenter.dataProvider=null;

			// Populate chartModel
			chartMainPresenter.chartModel=new ChartModel(-1, null, ChartTypeEnum.COLUMN_CHART);

			// Populate seriesList
			var s1:SeriesModel=new SeriesModel("", "value", "label");
			chartMainPresenter.seriesList=new ArrayCollection([s1]);

			// Send along the ChartPresenter we want to be filled with data

			var chartDataEvent:ChartDataEvent=new ChartDataEvent(chartMainPresenter, ReportTypeEnum.COMPARISON_COMPANY_COST_VS_PROFIT_REPORT);
			dispatcher.dispatchEvent(chartDataEvent);
		}

		/**
		 * MY_COST_REPORT
		 */
		public function getMyCostsDetails():void
		{
			// Set the page title
			detailsLabel="Costs";

			// Clear the dataProvider
			chartDetailsPresenter.dataProvider=null;

			// Populate chartModel
			chartDetailsPresenter.chartModel=new ChartModel(-1, null, isColumnChart ? ChartTypeEnum.COLUMN_CHART : ChartTypeEnum.PIE_CHART);

			// Set series info
			var series1:SeriesModel=new SeriesModel("value", "clientName", "cost");
			chartDetailsPresenter.seriesList=new ArrayCollection([series1]);

			// Send along a ChartPresenter to be filled with data
			var date:Date=new Date();
			var firstDayOfYear:Date=new Date(date.fullYear, 0, 1);
			var lastDayOfYear:Date=new Date(date.fullYear, 0, 365);
			var chartDataEvent:ChartDataEvent=new ChartDataEvent(chartDetailsPresenter, ReportTypeEnum.MY_COST_BY_CLIENT_REPORT, firstDayOfYear, lastDayOfYear);
			dispatcher.dispatchEvent(chartDataEvent);


		}

		/**
		 * MY_NET_REPORT (profit)
		 */
		public function getMyProfitDetails():void
		{
			// Set the page title
			detailsLabel="Profit";

			// Clear the dataProvider
			chartDetailsPresenter.dataProvider=null;

			// Populate chartModel
			chartDetailsPresenter.chartModel=new ChartModel(-1, null, isColumnChart ? ChartTypeEnum.COLUMN_CHART : ChartTypeEnum.PIE_CHART);

			// Set series info
			var series1:SeriesModel=new SeriesModel("value", "clientName", "profit");
			chartDetailsPresenter.seriesList=new ArrayCollection([series1]);

			// Send along a ChartPresenter to be filled with data
			var date:Date=new Date();
			var firstDayOfYear:Date=new Date(date.fullYear, 0, 1);
			var lastDayOfYear:Date=new Date(date.fullYear, 0, 365);
			var chartDataEvent:ChartDataEvent=new ChartDataEvent(chartDetailsPresenter, ReportTypeEnum.MY_NET_BY_CLIENT_REPORT, firstDayOfYear, lastDayOfYear);
			dispatcher.dispatchEvent(chartDataEvent);
		}


		/**
		 * COMPANY_COST_REPORT
		 */
		public function getCompanyCostsDetails():void
		{
			// Set the page title
			detailsLabel="Cost";

			// Clear the dataProvider
			chartDetailsPresenter.dataProvider=null;

			// Populate chartModel
			chartDetailsPresenter.chartModel=new ChartModel(-1, null, isColumnChart ? ChartTypeEnum.COLUMN_CHART : ChartTypeEnum.PIE_CHART);

			// Set series info
			var series1:SeriesModel=new SeriesModel("value", "clientName", "cost");
			chartDetailsPresenter.seriesList=new ArrayCollection([series1]);

			// Send along a ChartPresenter to be filled with data
			var date:Date=new Date();
			var firstDayOfYear:Date=new Date(date.fullYear, 0, 1);
			var lastDayOfYear:Date=new Date(date.fullYear, 0, 365);
			var chartDataEvent:ChartDataEvent=new ChartDataEvent(chartDetailsPresenter, ReportTypeEnum.COMPANY_COST_BY_CLIENT_REPORT, firstDayOfYear, lastDayOfYear);
			dispatcher.dispatchEvent(chartDataEvent);
		}

		/**
		 * COMPANY_NET_REPORT
		 */
		public function getCompanySalesDetails():void
		{
			// Set the page title
			detailsLabel="Profit";

			// Clear the dataProvider
			chartDetailsPresenter.dataProvider=null;

			// Populate chartModel
			chartDetailsPresenter.chartModel=new ChartModel(-1, null, isColumnChart ? ChartTypeEnum.COLUMN_CHART : ChartTypeEnum.PIE_CHART);

			// Set series info
			var series1:SeriesModel=new SeriesModel("value", "clientName", "profit");
			chartDetailsPresenter.seriesList=new ArrayCollection([series1]);

			// Send along a ChartPresenter to be filled with data
			var date:Date=new Date();
			var firstDayOfYear:Date=new Date(date.fullYear, 0, 1);
			var lastDayOfYear:Date=new Date(date.fullYear, 0, 365);
			var chartDataEvent:ChartDataEvent=new ChartDataEvent(chartDetailsPresenter, ReportTypeEnum.COMPANY_NET_BY_CLIENT_REPORT, firstDayOfYear, lastDayOfYear);
			dispatcher.dispatchEvent(chartDataEvent);
		}

		public function hideAllTourTips():void
		{
			dispatcher.dispatchEvent(new TourTipEvent(TourTipEvent.HIDE_ALL_TOUR_TIPS));
		}

		public function hideTourTip():void
		{
			var event:TourTipEvent=new TourTipEvent(TourTipEvent.HIDE_TOUR_TIP, TourTipTypeEnum.AVG_REVENUE_PER_SALE);
			dispatcher.dispatchEvent(event);
		}

	}
}
