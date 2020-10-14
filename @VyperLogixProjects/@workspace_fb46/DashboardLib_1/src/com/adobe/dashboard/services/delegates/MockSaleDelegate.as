package com.adobe.dashboard.services.delegates
{
	import com.adobe.dashboard.enum.*;
	import com.adobe.dashboard.model.*;
	import com.adobe.dashboard.model.chart.*;
	import com.adobe.dashboard.services.ISaleDelegate;
	import com.adobe.dashboard.util.DateTimeUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.globalization.LocaleID;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.core.mx_internal;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.IMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import spark.formatters.CurrencyFormatter;

	public class MockSaleDelegate implements ISaleDelegate
	{

		/**
		 * The default mock server response time in ms.  Increase or decrease this time based on the type
		 * of testing you are doing.
		 */
		public static const MOCK_ASYNC_TIME:int = 100;


		private var salesXML:XML;

		private var saleCache:ArrayCollection;

		private var goalCache:ArrayCollection;

		private var userCache:UserModel;

		// Bridge multiple async calls with a stored AsyncToken
		private var mockDataSetUpToken:AsyncToken;

		private var currencyFormatter:CurrencyFormatter;

		/**
		 * Constructor
		 */
		public function MockSaleDelegate()
		{
			currencyFormatter = new CurrencyFormatter();
			currencyFormatter.setStyle("locale", LocaleID.DEFAULT);
			currencyFormatter.useCurrencySymbol = true;
			currencyFormatter.trailingZeros = true;
		}

		public function setUp():AsyncToken
		{
			return null;
		}

		/**
		 * Method that loads all sales data
		 * @return
		 *
		 */
		public function getAllSales():AsyncToken
		{
			// Build a new token
			var message:IMessage = new HTTPRequestMessage();
			var token:AsyncToken = new AsyncToken(message);

			if (salesXML == null)
			{
				// Store the token so that we can access it after the async calls complete
				mockDataSetUpToken = token;

				// Load the mock data
				loadSalesXML();

				return token;
			}
			else
			{
				var result:ArrayCollection = saleCache;
				var fakeEvent:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, result, token, message);

				// Fake an async reponse
				var timeout:uint = setTimeout(function():void
				{
					clearTimeout(timeout);
					fakeEvent.mx_internal::callTokenResponders();
				}, MOCK_ASYNC_TIME);

				return token;
			}
		}

		/**
		 * Method that is responsible for initiating a report request
		 * @param reportType
		 * @param startDate
		 * @param endDate
		 * @return
		 *
		 */
		public function getChartData(reportType:String, startDate:Date = null, endDate:Date = null):AsyncToken
		{

			// Build a new token
			var message:IMessage = new HTTPRequestMessage();
			var token:AsyncToken = new AsyncToken(message);

			var result:Object = null;
			//based on the report type we will call different methods
			switch (reportType)
			{
				case ReportTypeEnum.COMPARISON_MY_VS_GOAL_GROSS_REPORT:
				case ReportTypeEnum.COMPARISON_MY_VS_GOAL_GROSS_MONTH_REPORT:
				{
					result = getClosedSalesByDateRange(startDate, endDate, DateRangeEnum.MONTH);
					break;
				}
				case ReportTypeEnum.COMPARISON_MY_VS_GOAL_GROSS_QUARTER_REPORT:
				{
					result = getClosedSalesByDateRange(startDate, endDate, DateRangeEnum.QUARTER);
					break;
				}
				case ReportTypeEnum.COMPARISON_MY_VS_GOAL_GROSS_YEAR_REPORT:
				{
					result = getClosedSalesByDateRange(startDate, endDate, DateRangeEnum.YEAR);
					break;
				}
				case ReportTypeEnum.COMPARISON_MY_COST_VS_PROFIT_REPORT:
				{
					result = getComparisonCostProfit(true);
					break;
				}
				case ReportTypeEnum.COMPARISON_COMPANY_COST_VS_PROFIT_REPORT:
				{
					result = getComparisonCostProfit(false);
					break;
				}

				case ReportTypeEnum.MY_GROSS_REPORT:
				{
					result = getMyGrossByDateRange(startDate, endDate);
					break;
				}
				case ReportTypeEnum.MY_COST_BY_CLIENT_REPORT:
				{
					result = getSalesProfitByClient(true);
					break;
				}
				case ReportTypeEnum.MY_NET_BY_CLIENT_REPORT:
				{
					result = getSalesCostByClient(true);
					break;
				}
				case ReportTypeEnum.COMPANY_COST_BY_CLIENT_REPORT:
				{
					result = getSalesProfitByClient(false);
					break;
				}
				case ReportTypeEnum.COMPANY_NET_BY_CLIENT_REPORT:
				{
					result = getSalesCostByClient(false);
					break;
				}

				case ReportTypeEnum.COMPANY_GROSS_BY_YEAR_REPORT:
				{
					result = getGrossByYear();
					break;
				}
				case ReportTypeEnum.COMPARISON_MY_VS_COMPANY_GROSS_BY_YEAR_REPORT:
				{
					result = getGrossByYear();
					break;
				}
				case ReportTypeEnum.COMPANY_GROSS_BY_YEAR_AND_COMPANY_REPORT:
				case ReportTypeEnum.MY_GROSS_BY_YEAR_AND_COMPANY_REPORT:
				{
					result = getGrossByYearAndCompanyReport();
					break;
				}

				case ReportTypeEnum.COMPARISON_MY_VS_AVERAGE_SALES_PIPELINE_REPORT:
				case ReportTypeEnum.MY_SALES_PIPELINE_REPORT:
				{
					result = getSalesByStatus();
					break;
				}

				case ReportTypeEnum.TOP_OPERTUNITIES_REPORT:
				{
					result = getCompanySalesByExpectedCloseYear();
					break;
				}
				case ReportTypeEnum.TOP_OPERTUNITIES_THIS_YEAR_REPORT:
				{
					result = getCompanySalesByExpectedCloseYear((new Date).fullYear);
					break;
				}
				case ReportTypeEnum.TOP_OPERTUNITIES_NEXT_YEAR_REPORT:
				{
					result = getCompanySalesByExpectedCloseYear((new Date).fullYear + 1);
					break;
				}

				//pipeline results
				case ReportTypeEnum.MY_SALES_PIPELINE_PROSPECT_REPORT:
				{
					result = getCompanySalesByStatus(StatusEnum.PROSPECT);
					break;
				}
				case ReportTypeEnum.MY_SALES_PIPELINE_QUALIFY_REPORT:
				{
					result = getCompanySalesByStatus(StatusEnum.QUALIFY);
					break;
				}
				case ReportTypeEnum.MY_SALES_PIPELINE_CLOSE_REPORT:
				{
					result = getCompanySalesByStatus(StatusEnum.CLOSED);
					break;
				}
			}

			var fakeEvent:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, result, token, message);

			// Fake an async reponse
			var timeout:uint = setTimeout(function():void
			{
				clearTimeout(timeout);
				fakeEvent.mx_internal::callTokenResponders();
			}, MOCK_ASYNC_TIME);

			return token;
		}

		/**
		 * Method responsible for startin a request for overview chart data
		 * @param reportType
		 * @param startDate
		 * @param endDate
		 * @return
		 *
		 */
		public function getChartOverviewData(reportType:String, startDate:Date = null, endDate:Date = null):AsyncToken
		{
			// Build a new token
			var message:IMessage = new HTTPRequestMessage();
			var token:AsyncToken = new AsyncToken(message);

			var result:Object = null;
			var now:Date = new Date();

			switch (reportType)
			{
				case ReportTypeEnum.COMPARISON_MY_VS_GOAL_GROSS_MONTH_REPORT:
				{
					if (startDate == null || endDate == null)
					{
						startDate = DateTimeUtil.getFirstDayOfMonth(now);
						endDate = DateTimeUtil.getLastDayOfMonth(now);
					}
					result = getSalesGoalByDateRange(startDate, endDate);
					SalesGoalModel(result).dateRangeName = "Month";
					break;
				}
				case ReportTypeEnum.COMPARISON_MY_VS_GOAL_GROSS_QUARTER_REPORT:
				{
					if (startDate == null || endDate == null)
					{
						startDate = DateTimeUtil.getFirstDateOfQuarter(now);
						endDate = DateTimeUtil.getLastDateOfQuarter(now);
					}
					result = getSalesGoalByDateRange(startDate, endDate);
					SalesGoalModel(result).dateRangeName = "Quarter";
					break;
				}
				case ReportTypeEnum.COMPARISON_MY_VS_GOAL_GROSS_YEAR_REPORT:
				{
					if (startDate == null || endDate == null)
					{
						startDate = new Date(now.fullYear, 0, 0);
						endDate = new Date(now.fullYear, 11, 30);
					}
					result = getSalesGoalByDateRange(startDate, endDate);
					SalesGoalModel(result).dateRangeName = "Year";
					break;
				}
				case ReportTypeEnum.COMPANY_GROSS_YEAR_BY_MONTH_REPORT:
					result = getTotalSalesCurrentYear();
					break;
				case ReportTypeEnum.COMPANY_GROSS_BY_YEAR_REPORT:
					startDate = new Date(now.fullYear, 0, 1); // Jan 1 of this year
					endDate = new Date(now.fullYear, 0, 365); // Dec 31 of this year
					result = getSalesGoalByDateRange(startDate, endDate);
					SalesGoalModel(result).dateRangeName = "year";
					break;
				case ReportTypeEnum.COMPARISON_MY_COST_VS_PROFIT_REPORT:
					result = getComparisonCostProfitOverview();
					break;
				default:
				{
					break;
				}
			}

			var fakeEvent:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, result, token, message);

			// Fake an async reponse
			var timeout:uint = setTimeout(function():void
			{
				clearTimeout(timeout);
				fakeEvent.mx_internal::callTokenResponders();
			}, MOCK_ASYNC_TIME);


			return token;
		}

		public function getGoalsByDateRange(dateRange:String, year:Number):AsyncToken
		{
			if (dateRange != DateRangeEnum.MONTH && dateRange != DateRangeEnum.QUARTER)
			{
				throw new Error("Invalid Date Range");
			}

			// Build a new token
			var message:IMessage = new HTTPRequestMessage();
			var token:AsyncToken = new AsyncToken(message);

			//hash used to compile report elements
			var saleHash:Object = new Object;
			var data:DateRangeModel = new DateRangeModel();
			var name:String;
			var startDate:Date;
			var endDate:Date;

			//looping through goal models
			for each (var goal:GoalModel in goalCache)
			{
				if (goal.startDate != null && goal.startDate.fullYear == year)
				{
					data = new DateRangeModel();

					if (dateRange == DateRangeEnum.MONTH)
					{
						name = DateTimeUtil.formatMonthName(goal.startDate);
						startDate = DateTimeUtil.getFirstDayOfMonth(goal.startDate);
						endDate = DateTimeUtil.getLastDayOfMonth(goal.startDate);
					}
					else if (dateRange == DateRangeEnum.QUARTER)
					{
						name = DateTimeUtil.formatQuarterName(goal.startDate);
						startDate = DateTimeUtil.getFirstDateOfQuarter(goal.startDate);
						endDate = DateTimeUtil.getLastDateOfQuarter(goal.startDate);
					}

					//if we haven't recorded this report element before we need to create it
					if (!saleHash[name])
					{
						// Make a new entry in the hash
						saleHash[name] = data;

						// Set the name of the date period
						data.label = name;
						data.value = 0;
						data.startDate = startDate;
						data.endDate = endDate;
					}

					// Increment the grossGoal for this object
					data.value += goal.gross;

					// Concat the name and the gross
					data.label = name + " - " + currencyFormatter.format(data.value);
				}
			}

			var list:ArrayCollection = new ArrayCollection();
			//loop through hash to populate resultant array collection
			for each (data in saleHash)
			{
				list.addItem(data);
			}
			var sort:Sort = new Sort();
			sort.compareFunction = sortOnStartDate;
			list.sort = sort;
			list.refresh();

			var fakeEvent:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, list, token, message);

			// Fake an async reponse
			var timeout:uint = setTimeout(function():void
			{
				clearTimeout(timeout);
				fakeEvent.mx_internal::callTokenResponders();
			}, MOCK_ASYNC_TIME);


			return token;
		}

		//
		// Private Methods
		//

		private function loadSalesXML():void
		{
			if (salesXML == null)
			{
				var xmlLoader:URLLoader = new URLLoader();
				var request:URLRequest = new URLRequest("assets/data/sales.xml");
				xmlLoader.addEventListener(Event.COMPLETE, salesLoaderCompleteHandler, false, 0, true);
				xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, genericIOErrorHandler, false, 0, true);

				xmlLoader.load(request);
			}
		}


		private function getSalesGoalByDateRange(startDate:Date, endDate:Date, mySales:Boolean = true):SalesGoalModel
		{
			var salesGoal:SalesGoalModel = new SalesGoalModel();
			salesGoal.startDate = startDate;
			salesGoal.endDate = endDate;
			salesGoal.goal = 0;

			//looping through goals to calculate the sales goal for data range
			for each (var goal:GoalModel in goalCache)
			{
				if (goal.startDate.getTime() >= startDate.getTime() && goal.startDate.getTime() <= endDate.getTime())
				{
					salesGoal.goal += goal.gross;
				}
			}
			//getting the sales for user
			salesGoal.myGross = 0;
			for each (var sale:SaleModel in saleCache)
			{
				// "my" sale
				if (sale.saleCloseDate != null
					&& sale.saleCloseDate.getTime() >= startDate.getTime()
					&& sale.saleCloseDate.getTime() <= endDate.getTime())
				{
					// check if we only want 'my sales'
					if (!mySales || (mySales && sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase()))
					{
						salesGoal.myGross += sale.gross;
						salesGoal.myNet += sale.net;
						salesGoal.myCost += (sale.gross - sale.net);
					}
				}
			}

			return salesGoal;
		}



		private function getClosedSalesByDateRange(startDate:Date, endDate:Date, dateRange:String):ArrayCollection
		{
			var goal:SalesGoalModel = getSalesGoalByDateRange(startDate, endDate);

			var saleList:ArrayCollection = new ArrayCollection();
			var chartSale:ChartSaleModel;

			var i:Number;

			var numDataPoints:Number;
			//configuring chart sale model based on date range
			switch (dateRange)
			{
				case DateRangeEnum.MONTH:
					numDataPoints = DateTimeUtil.numberOfDaysBetweenDates(startDate, endDate);
					for (i = 0; i < numDataPoints; i++)
					{
						chartSale = new ChartSaleModel();
						chartSale.date = new Date(startDate.fullYear, startDate.month, startDate.date + i);
						saleList.addItem(chartSale);
					}
					break;
				case DateRangeEnum.QUARTER:
					numDataPoints = 3;
					for (i = 0; i < numDataPoints; i++)
					{
						chartSale = new ChartSaleModel();
						chartSale.date = new Date(startDate.fullYear, startDate.month + i, 1);
						saleList.addItem(chartSale);
					}
					break;
				case DateRangeEnum.YEAR:
					numDataPoints = 12;
					for (i = 0; i < numDataPoints; i++)
					{
						chartSale = new ChartSaleModel();
						chartSale.date = new Date(startDate.fullYear, i, 1);
						saleList.addItem(chartSale);
					}
					break;
			}

			// Populate the chartSale objects with default values
			for each (chartSale in saleList)
			{
				chartSale.accumulatedGross = 0;
				chartSale.accumulatedNet = 0;
				chartSale.companyGross = 0;
				chartSale.companyNet = 0;
				chartSale.companyCost = 0;
				chartSale.myGross = 0;
				chartSale.myNet = 0;
				chartSale.myCost = 0;
				chartSale.goalGross = goal.goal;
			}


			//looping through each sale to see if it meets our criteria
			for each (var sale:SaleModel in saleCache)
			{
				if (sale.saleCloseDate != null &&
					sale.saleCloseDate >= startDate &&
					sale.saleCloseDate <= endDate)
				{
					switch (dateRange)
					{
						case DateRangeEnum.MONTH:
							i = DateTimeUtil.numberOfDaysBetweenDates(startDate, sale.saleCloseDate);
							chartSale = saleList.getItemAt(i - 1) as ChartSaleModel;
							break;
						case DateRangeEnum.QUARTER:
							i = DateTimeUtil.numberOfMonthsBetweenDates(startDate, sale.saleCloseDate);
							chartSale = saleList.getItemAt(i - 1) as ChartSaleModel;
							break;
						case DateRangeEnum.YEAR:
							i = sale.saleCloseDate.month;
							chartSale = saleList.getItemAt(i) as ChartSaleModel;
							break;
					}

					// Filter current sales person
					if (sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
					{
						if (sale.status == StatusEnum.CLOSED)
						{
							chartSale.myGross += sale.gross;
							chartSale.myNet += sale.net;
							chartSale.myCost += (sale.gross - sale.net);
						}
					}
					chartSale.companyGross += sale.gross;
					chartSale.companyNet += sale.net;
					chartSale.companyCost += (sale.gross - sale.net);
				}
			}



			var accMyGross:Number = 0;
			var accMyNet:Number = 0;
			//calculating sums
			for each (chartSale in saleList)
			{
				chartSale.accumulatedGross = accMyGross;
				chartSale.accumulatedNet = accMyNet;
				accMyGross += chartSale.myGross;
				accMyNet += chartSale.myNet;
			}

			// Sort the source array
			var a:Array = saleList.source;
			a.sort(sortOnDate);
			saleList = new ArrayCollection(a);

			return saleList;
		}

		/**
		 * cost = goss - net;
		 * profit = net;
		 *
		 * @param isMySale
		 * @return
		 *
		 */
		private function getComparisonCostProfit(isMySale:Boolean = false):ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection();
			var profit:RevenuePerSaleModel = new RevenuePerSaleModel();
			profit.label = "Profit";
			profit.value = 0;
			var cost:RevenuePerSaleModel = new RevenuePerSaleModel();
			cost.label = "Cost";
			cost.value = 0;
			//looping through closed sales
			for each (var sale:SaleModel in saleCache)
			{
				if (sale.status.toLowerCase() == StatusEnum.CLOSED.toLowerCase())
				{
					//based on whether or not we want just "my sales" we increment values
					if (isMySale && sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
					{
						profit.value += sale.net;
						cost.value += (sale.gross - sale.net);
					}
					else if (!isMySale)
					{
						profit.value += sale.net;
						cost.value += (sale.gross - sale.net);
					}
				}
			}
			list.addItem(profit);
			list.addItem(cost);
			return list;
		}

		private function getComparisonCostProfitOverview():CostProfitModel
		{
			var a:ArrayCollection = getComparisonCostProfit(true);

			return new CostProfitModel(RevenuePerSaleModel(a[1]).value, RevenuePerSaleModel(a[0]).value)


		}

		private function getSalesProfitByClient(isMySale:Boolean = false):ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection();
			var revenuePerSale:RevenuePerSaleModel;
			var revenueHash:Object = Object;
			//looping through sales
			for each (var sale:SaleModel in saleCache)
			{
				if (isMySale && sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
				{
					//if we don't have a record for this client we need to create one
					if (!revenueHash[sale.client])
					{
						revenuePerSale = new RevenuePerSaleModel();
						revenueHash[sale.client] = revenuePerSale;
						revenuePerSale.label = "Profit";
						revenuePerSale.clientName = sale.client;
						revenuePerSale.value = 0;
					}
					else
					{
						revenuePerSale = revenueHash[sale.client];
					}
					revenuePerSale.value += sale.net;
				}
			}
			//converting hash into an array collection
			for each (revenuePerSale in revenueHash)
			{
				list.addItem(revenuePerSale);
			}
			return list;
		}

		private function getSalesCostByClient(isMySale:Boolean = false):ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection();
			var revenuePerSale:RevenuePerSaleModel;
			var revenueHash:Object = Object;
			//looping through sales
			for each (var sale:SaleModel in saleCache)
			{
				if (isMySale && sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
				{
					//if we don't have a record for this client we need to create one
					if (!revenueHash[sale.client])
					{
						revenuePerSale = new RevenuePerSaleModel();
						revenueHash[sale.client] = revenuePerSale;
						revenuePerSale.label = "Cost";
						revenuePerSale.clientName = sale.client;
						revenuePerSale.value = 0;
					}
					else
					{
						revenuePerSale = revenueHash[sale.client];
					}
					// gross - net = cost
					revenuePerSale.value += (sale.gross - sale.net);
				}
			}
			//converting hash into arraycollection
			for each (revenuePerSale in revenueHash)
			{
				list.addItem(revenuePerSale);
			}
			return list;
		}

		private function getGrossByYear():ArrayCollection
		{
			var yearHash:Object = new Object();
			var totalSalesByYear:TotalSalesByYearModel;
			for each (var sale:SaleModel in saleCache)
			{
				//if we don't have a record for this year we need to create it
				if (!yearHash[sale.saleCloseDate.fullYear])
				{
					totalSalesByYear = new TotalSalesByYearModel();
					yearHash[sale.saleCloseDate.fullYear] = totalSalesByYear;
					totalSalesByYear.year = sale.saleCloseDate.fullYear;
					totalSalesByYear.companyGross = 0;
					totalSalesByYear.myGross = 0;
				}
				totalSalesByYear.companyGross += sale.gross;
				if (sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
				{
					totalSalesByYear.myGross += sale.gross;
				}
			}
			//converting hash to arraycollection
			var list:ArrayCollection = new ArrayCollection();
			for each (totalSalesByYear in yearHash)
			{
				list.addItem(totalSalesByYear);
			}
			// Ordering list by year ascending to help get the growth from previous month
			list.sort = new Sort();
			list.sort.fields = [ new SortField("year", false, true)];
			list.refresh();
			var lastMonthGross:Number = 0;
			var lastMonthMyGross:Number = 0;
			// First month starts from growth 0% .
			if (list.length > 0)
			{
				lastMonthGross = TotalSalesByYearModel(list.getItemAt(0)).companyGross;
				lastMonthMyGross = TotalSalesByYearModel(list.getItemAt(0)).myGross;
			}
			//calculating final values
			for each (totalSalesByYear in list)
			{
				totalSalesByYear.growthOverLastYear = ((totalSalesByYear.companyGross - lastMonthGross) / lastMonthGross) * 100;
				totalSalesByYear.previousYearCompanyGross = lastMonthGross;
				totalSalesByYear.myGrowthOverLastYear = ((totalSalesByYear.myGross - lastMonthMyGross) / lastMonthMyGross) * 100;
				totalSalesByYear.previousYearMyGross = lastMonthMyGross;
				lastMonthGross = totalSalesByYear.companyGross;
				lastMonthMyGross = totalSalesByYear.myGross;
			}
			// Result ordered by year descending
			list.sort.fields = [ new SortField("year", true, true)];
			list.refresh();
			return list;
		}

		private function getTotalSalesCurrentYear():TotalSalesByYearModel
		{
			var now:Date = new Date();
			var currentYear:Number = now.fullYear;
			var previousYear:Number = now.fullYear - 1;

			var totalSalesByYear:TotalSalesByYearModel = new TotalSalesByYearModel();
			totalSalesByYear.companyGross = 0;
			totalSalesByYear.myGross = 0;
			totalSalesByYear.previousYearCompanyGross = 0;
			totalSalesByYear.previousYearMyGross = 0;
			//looping through sales and incrementing the appropriate values
			for each (var sale:SaleModel in saleCache)
			{
				if (sale.saleCloseDate.fullYear == currentYear)
				{
					totalSalesByYear.companyGross += sale.gross;
					if (sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
					{
						totalSalesByYear.myGross += sale.gross;
					}
				}
				else if (sale.saleCloseDate.fullYear == previousYear)
				{
					totalSalesByYear.previousYearCompanyGross += sale.gross;
					if (sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
					{
						totalSalesByYear.previousYearMyGross += sale.gross;
					}
				}

			}
			return totalSalesByYear;
		}

		private function getGrossByYearAndCompanyReport():ArrayCollection
		{
			var yearHash:Object = new Object();
			var clientHash:Object;
			var list:ArrayCollection = new ArrayCollection();
			var companySales:CompanySalesModel;

			//looping through sales
			for each (var sale:SaleModel in saleCache)
			{
				//if we don't have a record for this year we need to create one
				if (!yearHash[sale.saleCloseDate.fullYear])
				{
					clientHash = new Object();
					yearHash[sale.saleCloseDate.fullYear] = clientHash;
				}
				//if we don't have a record for this client we need to create one
				if (!clientHash[sale.client])
				{
					companySales = new CompanySalesModel();
					companySales.clientName = sale.client;
					companySales.gross = 0;
					companySales.myGross = 0;
					companySales.year = sale.saleCloseDate.fullYear;
				}
				//incrementing appropriate values
				companySales.gross += sale.gross;
				if (sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
				{
					companySales.myGross += sale.gross;
				}
			}
			//converting hash into array collection
			for (var year:String in yearHash)
			{
				list.addItem(new Date(year, 0, 1));
				for each (companySales in yearHash[year])
				{
					list.addItem(companySales);
				}
			}
			return list;
		}

		private function getSalesByStatus():ArrayCollection
		{
			//main hash that will populate the result object
			var pipelineHash:Object = new Object();

			//hash to keep track of the average values per status type
			var averageHash:Object = new Object();

			//props for loops
			var salesPipeline:SalesPipelineModel;
			var averageAux:Object;

			//initiating sales pipeline models for each sales status type
			for each (var sale:SaleModel in saleCache)
			{
				//if pipeline for status does not exist create it
				if (!pipelineHash[sale.status])
				{
					salesPipeline = new SalesPipelineModel();
					salesPipeline.averageGross = 0;
					salesPipeline.myGross = 0;
					salesPipeline.name = sale.status;

					// Add to the hash
					pipelineHash[sale.status] = salesPipeline;

					averageAux = new Object();
					averageAux.sum = 0;
					averageAux.qnt = 0;
					averageAux.avg = 0;
					averageHash[sale.status] = averageAux;
				}
				//switching to appropriate models/data object
				salesPipeline = pipelineHash[sale.status];
				averageAux = averageHash[sale.status];

				averageAux.sum += sale.gross;
				averageAux.qnt++;
				averageAux.avg = averageAux.sum / averageAux.qnt;
				//attributing gross for person if sale matches
				if (sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
				{
					salesPipeline.myGross += sale.gross;
				}
			}
			//building result list
			var list:ArrayCollection = new ArrayCollection();
			for each (salesPipeline in pipelineHash)
			{
				salesPipeline.averageGross = averageHash[salesPipeline.name].avg;
				list.addItem(salesPipeline);
			}
			return list;
		}

		private function getCompanySalesByStatus(status:String):ArrayCollection
		{
			var companyHash:Object = new Object();

			var companySales:CompanySalesModel;

			//looping through sales
			for each (var sale:SaleModel in saleCache)
			{
				//if sale meets the appropriate status
				if (sale.status == status)
				{
					//if we don't have a record for this client we need to create one
					if (!companyHash[sale.client])
					{
						companySales = new CompanySalesModel();
						companySales.clientName = sale.client;
						companySales.gross = 0;
						companySales.myGross = 0;
						companyHash[sale.client] = companySales;
					}
					//incrementing and setting values
					companySales = companyHash[sale.client];
					companySales.gross += sale.gross;
					if (sale.leadSalesPerson.toLowerCase() == userCache.username.toLowerCase())
					{
						companySales.myGross += sale.gross;
					}
				}
			}
			//converting hash into array collection
			var list:ArrayCollection = new ArrayCollection();
			for each (companySales in companyHash)
			{
				list.addItem(companySales);
			}
			return list;
		}

		private function getCompanySalesByExpectedCloseYear(year:Number = 0):ArrayCollection
		{
			var saleOportunity:SaleOportunityModel;
			var list:ArrayCollection = new ArrayCollection();
			//looping through sales
			for each (var sale:SaleModel in saleCache)
			{
				//if status is closed add a new sale opportunity
				if (sale.status != StatusEnum.CLOSED
					&& (year == 0 || sale.projectedCloseDate.fullYear == year))
				{
					saleOportunity = new SaleOportunityModel();
					saleOportunity.companyName = sale.client;
					saleOportunity.expectedCloseDate = sale.projectedCloseDate;
					saleOportunity.expectedGross = sale.gross;

					list.addItem(saleOportunity);
				}

			}
			return list;
		}

		private function getMyGrossByDateRange(startDate:Date, endDate:Date):ArrayCollection
		{
			if (startDate == null || endDate == null)
			{
				throw new Error("getMyGrossByDateRange must be supplied a startDate and endDate");
			}

			var a:Array = [];
			var currentUser:String = userCache.username.toLowerCase();

			for each (var sale:SaleModel in saleCache)
			{
				if (sale.saleCloseDate >= startDate && sale.saleCloseDate <= endDate) // Only sales in the provided date range
				{
					if (sale.leadSalesPerson.toLowerCase() == currentUser) // Only 'my' sales
					{
						if (sale.status == StatusEnum.CLOSED) // Only closed sales
						{
							a.push(new ChartSaleModel(sale.client, sale.gross, sale.net, sale.gross - sale.net, NaN, NaN, NaN, NaN, NaN, NaN, sale.saleCloseDate));
						}
					}
				}
			}
			return new ArrayCollection(a);
		}


		//
		// Event Handlers
		//

		protected function genericIOErrorHandler(event:IOErrorEvent):void
		{
			trace("IO Error!");
		}

		protected function salesLoaderCompleteHandler(event:Event):void
		{
			event.currentTarget.removeEventListener(Event.COMPLETE, salesLoaderCompleteHandler);
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, genericIOErrorHandler);
			salesXML = new XML(event.currentTarget.data);

			var saleXMLList:XMLList = salesXML..sale;
			var a:Array = [];
			for each (var sale:XML in saleXMLList)
			{
				// Build  ForumTopicModel object
				a.push(SaleModel.fromXML(sale));
			}

			saleCache = new ArrayCollection(a);

			var goalXMLList:XMLList = salesXML..goal;
			a = [];
			for each (var goal:XML in goalXMLList)
			{
				// Build  ForumTopicModel object
				a.push(GoalModel.fromXML(goal));
			}

			goalCache = new ArrayCollection(a);

			userCache = new UserModel(salesXML.salesPerson.@name);

			var result:ArrayCollection = saleCache;
			var fakeEvent:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, result, mockDataSetUpToken, mockDataSetUpToken.message);

			// Cause the listeners in to fire
			fakeEvent.mx_internal::callTokenResponders();

		}


		//
		// Util Methods
		//

		/**
		 * Method used as a compareFunction for sorting
		 */
		private function sortOnStartDate(a:Object, b:Object, fields:Array = null):int
		{
			if (!a.startDate || !b.startDate)
			{
				return -1;
			}
			else if (a.startDate.time > b.startDate.time)
			{
				return 1;
			}
			else if (a.startDate.time == b.startDate.time)
			{
				return 0;
			}
			else
			{
				return -1;
			}
		}

		/**
		 * Method used as a compareFunction for sorting
		 */
		private function sortOnDate(a:Object, b:Object, fields:Array = null):int
		{
			if (!a.date || !b.date)
			{
				return -1;
			}
			else if (a.date.time > b.date.time)
			{
				return 1;
			}
			else if (a.date.time == b.date.time)
			{
				return 0;
			}
			else
			{
				return -1;
			}
		}


	}
}