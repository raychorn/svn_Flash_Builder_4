package com.adobe.dashboard.control
{
	import com.adobe.dashboard.enum.*;
	import com.adobe.dashboard.event.*;
	import com.adobe.dashboard.model.*;
	import com.adobe.dashboard.model.chart.IChartOverviewDataModel;
	import com.adobe.dashboard.presenter.*;
	import com.adobe.dashboard.services.*;
	import com.adobe.dashboard.services.delegates.*;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	/**
	 * The main controller for the application.  This controller is used in both the web and mobile apps
	 */
	public class AppController extends EventDispatcher
	{
		/**
		 * if flag is true then use mock data sevces
		 */
		private var isMocking:Boolean=false;

		/**
		 * local pointer to AppModel singelton
		 */
		protected var appModel:AppModel;

		/**
		 * instance of SalesService
		 */
		protected var saleService:SaleService;

		/**
		 * cache of AsyncTokens that is used for matching up requests to async returned results
		 */
		private var tokenDictionary:Dictionary=new Dictionary(true);


		/**
		 * Constuctor
		 * @param isMocking		if true mock date services will be used
		 *
		 */
		public function AppController(isMocking:Boolean)
		{
			this.isMocking=isMocking;

			appModel=AppModel.getInstance();
			buildPresentationModels();
			buildService();
			addListeners();
		}



		//
		// Private Methods
		//

		/**
		 * The controler builds the presenters to be used
		 *
		 * Note: If you are using a framework like Swiz or RobotLegs wiring of the Presenters
		 * 		 and Controllers will most likly happen with framework code
		 */
		private function buildPresentationModels():void
		{
			appModel.mainPresenter=new MainPresenter(this);

			// Dashboard
			appModel.salesGoalsPresenter=new SalesGoalsPresenter(this);
			appModel.averageRevenuePresenter=new AverageRevenuePresenter(this);
			appModel.yearToDatePresenter=new YearToDatePresenter(this);
			appModel.salesPipelinePresenter=new SalesPipelinePresenter(this);
			appModel.topOpportunitiesPresenter=new TopOpportunitiesPresenter(this);
		}

		public function onAppActivated():void
		{
			appModel.salesGoalsPresenter.skipAnimation=false;
			appModel.averageRevenuePresenter.skipAnimation=false;
			appModel.salesPipelinePresenter.skipAnimation=false;
		}

		/**
		 * Build the service object used to communicate with the server, or
		 * in this case with a mock data service layer
		 */
		private function buildService():void
		{
			if (isMocking)
			{
				saleService=new SaleService(new MockSaleDelegate());
			}
			else
			{
				// This is the spot to define the live service delegate particular to your application
				// LoginService(<ILoginDelegate>) accepts a custom delegate for communicating with 
				// the server of your choice.  Simply write a service delegate that implments ILoginService
				// and pass a new instance of that class to LoginService constructor is is done above with 
				// the mock service
				//
				// For example:				
				// expenseService = new LoginService(new LoginJ2EEService());
			}
		}


		/**
		 * Listen for events being dispatched from the presenters
		 */
		private function addListeners():void
		{
			// NavigationEvent
			addEventListener(NavigationEvent.GO_STATE_EVENT, goStateHandler, false, 0, true);

			// SaleEvent
			addEventListener(SaleEvent.GET_ALL_SALES_EVENT, getAllSalesHandler, false, 0, true);

			// ChartDataEvent
			addEventListener(ChartDataEvent.GET_CHART_DATA_EVENT, getChartDataHandler, false, 0, true);
			addEventListener(ChartOverviewEvent.GET_CHART_OVERVIEW_DATA_EVENT, getChartOverviewDataHandler, false, 0, true);

			// SaleGoalsEvent
			addEventListener(SaleGoalsEvent.GET_GOALS_BY_DATE_RANGE, getGoalsByDateRangeHandler, false, 0, true);

			// SetUpEvent
			addEventListener(SetUpEvent.SET_UP_EVENT, setUpHandler, false, 0, true);

			//TourTipEvent
			addEventListener(TourTipEvent.HIDE_TOUR_TIP, hideTourTipHandler, false, 0, true);
			addEventListener(TourTipEvent.HIDE_ALL_TOUR_TIPS, hideAllTourTipsHandler, false, 0, true);
		}


		protected function hideTourTipHandler(event:TourTipEvent):void
		{
			switch (event.tourTipType)
			{
				case TourTipTypeEnum.MAIN_MENU:
					appModel.mainPresenter.showTourTip=false;
					break;
				case TourTipTypeEnum.SALES_GOAL:
					appModel.salesGoalsPresenter.showTourTip=false;
					break;
				case TourTipTypeEnum.SALES_PIPELINE:
					appModel.salesPipelinePresenter.showTourTip=false;
					break;
				case TourTipTypeEnum.AVG_REVENUE_PER_SALE:
					appModel.averageRevenuePresenter.showTourTip=false;
					break;
			}
		}

		protected function hideAllTourTipsHandler(event:TourTipEvent):void
		{
			appModel.mainPresenter.showTourTip=false;
			appModel.salesGoalsPresenter.showTourTip=false;
			appModel.salesPipelinePresenter.showTourTip=false;
			appModel.averageRevenuePresenter.showTourTip=false;
		}

		//
		// Protected Methods
		//

		/**
		 * Helper method to dispatch the new current state
		 * @param state		The curentState string (StateEnum.as)
		 */
		protected function dispatchCurrentStateChange(state:String, doPop:Boolean=false):void
		{
			// Set the state for those views that are bound to currentState
			appModel.mainPresenter.currentState=state;

			// Dispatch an event for views not using binding
			appModel.mainPresenter.dispatchEvent(new NavigationEvent(NavigationEvent.GO_STATE_EVENT, state, doPop));
		}

		protected function getCompanySales(user:String, data:ArrayCollection):Array
		{
			var a:Array=[];

			for each (var sale:SaleModel in data)
			{
				if (sale.leadSalesPerson != user && sale.leadSalesPerson != "TargetSales")
				{
					a.push(sale);
				}
			}

			return a;
		}

		protected function getSalesByUser(user:String, data:ArrayCollection):Array
		{
			var a:Array=[];

			for each (var sale:SaleModel in data)
			{
				if (sale.leadSalesPerson == user)
				{
					a.push(sale);
				}
			}

			return a;
		}




		// ***
		//
		// Event Handlers
		//
		// ***


		//
		// SetUpEvent Handlers
		//

		protected function setUpHandler(event:SetUpEvent):void
		{
			// Load all sales
			getAllSalesHandler(null);
		}


		//
		// NavigationEvent Handlers
		//

		protected function goStateHandler(event:NavigationEvent):void
		{
			dispatchCurrentStateChange(event.state, event.doPop);
		}


		//
		// SaleEvent Handlers
		//

		protected function getAllSalesHandler(event:SaleEvent):void
		{
			var token:AsyncToken=saleService.getAllSales();

			// Add listeners on the fly to the new AsyncToken
			token.addResponder(new Responder(getAllSalesResultHandler, genericFaultHandler));
		}


		//
		// ChartDataEvent Handlers
		//

		protected function getChartDataHandler(event:ChartDataEvent):void
		{
			var token:AsyncToken=saleService.getChartData(event.reportType, event.startDate, event.endDate);

			// Add listeners on the fly to the new AsyncToken
			token.addResponder(new Responder(getChartDataResultHandler, genericFaultHandler));

			// Store the token
			tokenDictionary[token]=event.presenter;
		}

		protected function getChartOverviewDataHandler(event:ChartOverviewEvent):void
		{
			var token:AsyncToken=saleService.getChartOverviewData(event.reportType);

			token.addResponder(new Responder(getChartOverviewDataResultHandler, genericFaultHandler));

			// Store the token / event
			tokenDictionary[token]=event.presenter;
		}


		//
		// SaleGoalEvent Handlers
		//

		protected function getGoalsByDateRangeHandler(event:SaleGoalsEvent):void
		{
			var token:AsyncToken=saleService.getGoalsByDateRange(event.dateRange, event.year);

			token.addResponder(new Responder(getGoalsByDateRangeResultHandler, genericFaultHandler));

			// Store the token / event
			tokenDictionary[token]=event;
		}


		// ***
		//
		// Service Result Handlers
		//
		// ***


		// 
		// SetUpEvent Service Result Handlers
		//

		protected function setUpResultHandler(event:ResultEvent):void
		{
			// Load all sales
			getAllSalesHandler(null);
		}

		//
		// SaleEvent Service Result Handlers
		//

		protected function getAllSalesResultHandler(event:ResultEvent):void
		{
			var saleList:ArrayCollection=event.result as ArrayCollection;
			appModel.mainPresenter.saleList=saleList;

			// Dispatch 'set up complete' event on the main presenter
			appModel.mainPresenter.dispatchEvent(new SetUpEvent(SetUpEvent.SET_UP_COMPLETE_EVENT));
		}

		// 
		// ChartDateEvent Service Result Handlers
		//

		protected function getChartDataResultHandler(event:ResultEvent):void
		{
			var list:ArrayCollection=event.result as ArrayCollection;

			// Lookup the presenter that made this request and cares about the results
			var chartPresenter:ChartPresenter=tokenDictionary[event.token];

			//
			chartPresenter.dataProvider=list;

			// Dispatch a simple change event the views can listen to to know the model has changed
			var evt:Event=new Event(Event.CHANGE);
			chartPresenter.dispatchEvent(evt);
		}

		protected function getChartOverviewDataResultHandler(event:ResultEvent):void
		{
			var model:IChartOverviewDataModel=IChartOverviewDataModel(event.result);

			// Look up the model associated with this request for data
			var requester:ChartOverviewPresenter=tokenDictionary[event.token];

			requester.dataModel=model;

			// Dispatch a simple change event the views can listen to to know the model has changed
			var evt:Event=new Event(Event.CHANGE);
			requester.dispatchEvent(evt);
		}

		//
		// SalesGoalsEvent Service Result Handlers
		//

		protected function getGoalsByDateRangeResultHandler(event:ResultEvent):void
		{
			appModel.salesGoalsPresenter.dateRangeSelectorList=event.result as ArrayCollection;
		}




		/**
		 * Generic fault event used for all service calls that don't need custom fault handeling
		 */
		protected function genericFaultHandler(event:FaultEvent):void
		{
			trace(event.fault.toString());
		}


	}
}
