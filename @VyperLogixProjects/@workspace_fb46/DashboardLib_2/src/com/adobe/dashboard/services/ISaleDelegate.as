package com.adobe.dashboard.services
{
	import com.adobe.dashboard.model.ISaleModel;

	import mx.rpc.AsyncToken;

	public interface ISaleDelegate
	{
		function setUp():AsyncToken;

		function getAllSales():AsyncToken;

		function getChartData(reportType:String, startDate:Date = null, endDate:Date = null):AsyncToken;

		function getChartOverviewData(reportType:String, startDate:Date = null, endDate:Date = null):AsyncToken;

		function getGoalsByDateRange(dateRange:String, year:Number):AsyncToken;
	}
}