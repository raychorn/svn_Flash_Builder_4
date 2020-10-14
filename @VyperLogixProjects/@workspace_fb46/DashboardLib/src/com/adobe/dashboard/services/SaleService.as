package com.adobe.dashboard.services
{
	import com.adobe.dashboard.model.ISaleModel;

	import mx.rpc.AsyncToken;

	public class SaleService
	{

		private var delegate:CacheProxy;

		/**
		 * Constructor
		 *
		 * @param delegate		Service delegate with a specific mock data or server implementation
		 *
		 */
		public function SaleService(delegate:ISaleDelegate)
		{
			this.delegate = new CacheProxy(delegate);
		}

		public function setUp():AsyncToken
		{
			return delegate.setUp();
		}

		public function getAllSales():AsyncToken
		{
			return delegate.getAllSales();
		}

		public function getSaleById(id:int):AsyncToken
		{
			return delegate.getSaleById(id);
		}

		public function createSale(sale:ISaleModel):AsyncToken
		{
			return delegate.createSale(sale);
		}

		public function updateSale(sale:ISaleModel):AsyncToken
		{
			return delegate.updateSale(sale);
		}

		public function deleteSale(id:int):AsyncToken
		{
			return delegate.deleteSale(id);
		}

		public function search(keyword:String):AsyncToken
		{
			return search(keyword);
		}

		public function getChartData(reportType:String, startDate:Date = null, endDate:Date = null):AsyncToken
		{
			return delegate.getChartData(reportType, startDate, endDate);
		}

		public function getChartOverviewData(reportType:String, startDate:Date = null, endDate:Date = null):AsyncToken
		{
			return delegate.getChartOverviewData(reportType, startDate, endDate);
		}

		public function getGoalsByDateRange(dateRange:String, year:Number):AsyncToken
		{
			return delegate.getGoalsByDateRange(dateRange, year);
		}
	}
}