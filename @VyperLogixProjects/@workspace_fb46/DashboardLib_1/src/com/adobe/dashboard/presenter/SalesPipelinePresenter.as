package com.adobe.dashboard.presenter
{
	import com.adobe.dashboard.enum.*;
	import com.adobe.dashboard.event.*;
	import com.adobe.dashboard.model.SeriesModel;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;

	public class SalesPipelinePresenter extends EventDispatcher
	{
		private var dispatcher:IEventDispatcher;

		[Bindable]
		public var chartOverviewPresenter:ChartPresenter;

		[Bindable]
		public var chartMainPresenter:ChartPresenter;

		[Bindable]
		public var chartDetailsPresenter:ChartPresenter;

		[Bindable]
		public var isHorizontal:Boolean = true;

		[Bindable]

		public var detailsStatusType:String; // StatusEnum.as type

		[Bindable]
		public var chartConfig:String = "horizontalStandalone";
		
		[Bindable]
		public var chartDetailsConfig:String = "horizontalStandalone";

		[Bindable]
		public var showTourTip:Boolean = true;
		
		[Bindable]
		public var skipAnimation:Boolean = false;

		public function SalesPipelinePresenter(dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;

			buildPresenters();
		}

		private function buildPresenters():void
		{
			chartOverviewPresenter = new ChartPresenter(dispatcher);
			chartMainPresenter = new ChartPresenter(dispatcher);
			chartDetailsPresenter = new ChartPresenter(dispatcher);
			addChangeListeners();
		}

		protected function addChangeListeners():void
		{
			chartOverviewPresenter.addEventListener(Event.CHANGE, onOverviewPresenterChanged);
			chartDetailsPresenter.addEventListener(Event.CHANGE, onChartDetailsPresenterChanged);
		}

		protected function onOverviewPresenterChanged(event:Event):void
		{
			var itemReplaced:Object;
			// Add to delegate
			var sortedItemsDict:Dictionary = new Dictionary();
			for (var i:int = 0; i < chartOverviewPresenter.dataProvider.length; i++)
			{
				var o:Object = chartOverviewPresenter.dataProvider.getItemAt(i);
				switch (o.name)
				{
					case "Prospect":
						sortedItemsDict[2] = chartOverviewPresenter.dataProvider.removeItemAt(i);
						i--;
						break;
					case "Qualify":
						sortedItemsDict[1] = chartOverviewPresenter.dataProvider.removeItemAt(i);
						i--;
						break;
					case "Closing":
						sortedItemsDict[0] = chartOverviewPresenter.dataProvider.removeItemAt(i);
						i--;
						break;
					case "Closed":
						chartOverviewPresenter.dataProvider.removeItemAt(i);
						i--;
						break;
				}

			}
			chartOverviewPresenter.dataProvider.source = [ sortedItemsDict[0], sortedItemsDict[1], sortedItemsDict[2]];
			chartOverviewPresenter.dataProvider.refresh();
		}

		protected function onChartDetailsPresenterChanged(event:Event):void
		{

		}

		//
		// Public methods
		//


		public function goDetails(status:String):void
		{
			detailsStatusType = status;

			var evt:NavigationEvent = new NavigationEvent(NavigationEvent.GO_STATE_EVENT, StateEnum.SALES_PIPELINE_DETAILS_STATE);
			dispatcher.dispatchEvent(evt);
		}

		public function getDetailsData():void
		{
			if (detailsStatusType == null)
			{
				throw new Error("Must set detailsStatusType");
			}

			switch (detailsStatusType)
			{
				case StatusEnum.CLOSING:
					getMySalesPipelineClose();
					break;
				case StatusEnum.PROSPECT:
					getMySalesPipelineProspect();
					break;
				case StatusEnum.QUALIFY:
					getMySalesPipelineQualify();
					break;
			}
		}

		/**
		 * MY_SALES_PIPELINE_REPORT
		 */
		public function getMySalesPipelineChartData(getOverview:Boolean = false):void
		{
			var p:ChartPresenter;
			if (getOverview)
			{
				p = chartOverviewPresenter;
			}
			else
			{
				p = chartMainPresenter;
			}

			// Avoid rendering the wrong data
			p.dataProvider = null;

			// Set series info
			var series1:SeriesModel = new SeriesModel("", "name", "");
			p.seriesList = new ArrayCollection([ series1 ]);

			var chartDataEvent:ChartDataEvent = new ChartDataEvent(p, ReportTypeEnum.MY_SALES_PIPELINE_REPORT);
			dispatcher.dispatchEvent(chartDataEvent);
		}



		/**
		 * MY_SALES_PIPELINE_PROSPECT_REPORT
		 */
		public function getMySalesPipelineProspect():void
		{
			// Avoid rendering the wrong data
			chartDetailsPresenter.dataProvider = null;

			// Set series info
			var series1:SeriesModel = new SeriesModel("", "clientName", "");
			chartDetailsPresenter.seriesList = new ArrayCollection([ series1 ]);

			var chartDataEvent:ChartDataEvent = new ChartDataEvent(chartDetailsPresenter, ReportTypeEnum.MY_SALES_PIPELINE_PROSPECT_REPORT);
			dispatcher.dispatchEvent(chartDataEvent);
		}

		/**
		 * MY_SALES_PIPELINE_QUALIFY_REPORT
		 */
		public function getMySalesPipelineQualify():void
		{
			// Avoid rendering the wrong data
			chartDetailsPresenter.dataProvider = null;

			// Set series info
			var series1:SeriesModel = new SeriesModel("", "clientName", "");
			chartDetailsPresenter.seriesList = new ArrayCollection([ series1 ]);

			var chartDataEvent:ChartDataEvent = new ChartDataEvent(chartDetailsPresenter, ReportTypeEnum.MY_SALES_PIPELINE_QUALIFY_REPORT);
			dispatcher.dispatchEvent(chartDataEvent);
		}

		/**
		 * MY_SALES_PIPELINE_CLOSE_REPORT
		 */
		public function getMySalesPipelineClose():void
		{
			// Avoid rendering the wrong data
			chartDetailsPresenter.dataProvider = null;

			// Set series info
			var series1:SeriesModel = new SeriesModel("", "clientName", "");
			chartDetailsPresenter.seriesList = new ArrayCollection([ series1 ]);

			var chartDataEvent:ChartDataEvent = new ChartDataEvent(chartDetailsPresenter, ReportTypeEnum.MY_SALES_PIPELINE_CLOSE_REPORT);
			dispatcher.dispatchEvent(chartDataEvent);
		}

		public function hideAllTourTips():void
		{
			dispatcher.dispatchEvent(new TourTipEvent(TourTipEvent.HIDE_ALL_TOUR_TIPS));
		}

		public function hideTourTip():void
		{
			var event:TourTipEvent = new TourTipEvent(TourTipEvent.HIDE_TOUR_TIP, TourTipTypeEnum.SALES_PIPELINE);
			dispatcher.dispatchEvent(event);
		}


	}
}