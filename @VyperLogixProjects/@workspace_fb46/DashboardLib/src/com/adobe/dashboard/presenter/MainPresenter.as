package com.adobe.dashboard.presenter
{
	import com.adobe.dashboard.enum.*;
	import com.adobe.dashboard.event.*;
	import com.adobe.dashboard.model.ISaleModel;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class MainPresenter extends EventDispatcher
	{
		public var dispatcher:EventDispatcher;



		//
		// Properties
		//

		private var _currentState:String = StateEnum.SALES_GOALS_STATE;

		[Bindable]
		public function get currentState():String
		{
			return _currentState;
		}

		public function set currentState(value:String):void
		{
			_currentState = value;
		}


		private var _saleList:ArrayCollection;

		[Bindable]
		public function get saleList():ArrayCollection
		{
			return _saleList;
		}

		public function set saleList(value:ArrayCollection):void
		{
			_saleList = value;
		}



		private var _selectedSale:ISaleModel;

		[Bindable]
		public function get selectedSale():ISaleModel
		{
			return _selectedSale;
		}

		public function set selectedSale(value:ISaleModel):void
		{
			_selectedSale = value;
		}




		[Bindable]
		public var issueList:ArrayCollection;

		[Bindable]
		public var issueDetailList:ArrayCollection;

		[Bindable]
		public var severityList:ArrayCollection;

		[Bindable]
		public var showTourTip:Boolean = true;
		

		/**
		 * Constructor
		 */
		public function MainPresenter(dispatcher:EventDispatcher)
		{
			// Set (Inject) the object to dispatch events on
			this.dispatcher = dispatcher;

			addEventListener(NavigationEvent.GO_STATE_EVENT, goStateHandler, false, 0, true);
		}

		//
		// Public Methods
		//

		public function setUp():void
		{
			var evt:SetUpEvent = new SetUpEvent(SetUpEvent.SET_UP_EVENT);
			dispatcher.dispatchEvent(evt);
		}

		public function getAllSales():void
		{
			var evt:SaleEvent = new SaleEvent(SaleEvent.GET_ALL_SALES_EVENT);
			dispatcher.dispatchEvent(evt);
		}


		public function goHome():void
		{
			var evt:NavigationEvent = new NavigationEvent(NavigationEvent.GO_STATE_EVENT, StateEnum.HOME_STATE);
			dispatcher.dispatchEvent(evt);
		}

		public function goSalesGoals():void
		{
			var evt:NavigationEvent = new NavigationEvent(NavigationEvent.GO_STATE_EVENT, StateEnum.SALES_GOALS_STATE);
			dispatcher.dispatchEvent(evt);
			hideTourTip();
		}

		public function goAverageRevenuePerSale():void
		{
			var evt:NavigationEvent = new NavigationEvent(NavigationEvent.GO_STATE_EVENT, StateEnum.AVERAGE_REVENUE_PER_SALE_STATE);
			dispatcher.dispatchEvent(evt);
			hideTourTip();
		}

		public function goYearToDateSales():void
		{
			var evt:NavigationEvent = new NavigationEvent(NavigationEvent.GO_STATE_EVENT, StateEnum.YEAR_TO_DATE_SALES_STATE);
			dispatcher.dispatchEvent(evt);
			hideTourTip();
		}

		public function goTopTenOpportunities():void
		{
			var evt:NavigationEvent = new NavigationEvent(NavigationEvent.GO_STATE_EVENT, StateEnum.TOP_TEN_OPPORTUNITIES_STATE);
			dispatcher.dispatchEvent(evt);
			hideTourTip();
		}

		public function goSalesPipeline():void
		{
			var evt:NavigationEvent = new NavigationEvent(NavigationEvent.GO_STATE_EVENT, StateEnum.SALES_PIPELINE_STATE);
			dispatcher.dispatchEvent(evt);
			hideTourTip();
		}


		public function getChartData(chartPresenter:ChartPresenter, reportType:String, startDate:Date = null, endDate:Date = null):void
		{
			var evt:ChartDataEvent = new ChartDataEvent(chartPresenter, reportType, startDate, endDate);
			dispatcher.dispatchEvent(evt);
		}



		//
		// Listeners to events fired by the dispatcher
		//

		protected function goStateHandler(event:NavigationEvent):void
		{
			currentState = event.state;
		}


		public function hideAllTourTips():void
		{
			dispatcher.dispatchEvent(new TourTipEvent(TourTipEvent.HIDE_ALL_TOUR_TIPS));
		}

		public function hideTourTip():void
		{
			var event:TourTipEvent = new TourTipEvent(TourTipEvent.HIDE_TOUR_TIP, TourTipTypeEnum.MAIN_MENU);
			dispatcher.dispatchEvent(event);
		}

	}
}