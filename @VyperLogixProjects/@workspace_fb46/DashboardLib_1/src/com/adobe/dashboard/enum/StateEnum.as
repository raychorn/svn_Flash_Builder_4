package com.adobe.dashboard.enum
{

	/**
	 * All the valid states as constants.
	 * Spark states do not support constants as names, so there is a loose contract
	 * with the string names here and the state names typed into the <s:State name=""/> tags
	 * Please use the state enum values everywhere else even thought simple strings would also work :).
	 */
	public class StateEnum
	{
		public static const HOME_STATE:String="homeState";

		public static const LOGIN_STATE:String="loginState";


		// Sales Goals View
		public static const SALES_GOALS_STATE:String="salesGoalsState";

		public static const SALES_GOALS_DETAILS_STATE:String="salesGoals_DetailsState";


		// Average Revenue Per Sale View
		public static const AVERAGE_REVENUE_PER_SALE_STATE:String="averageRevenuePerSaleState";

		public static const AVERAGE_REVENUE_PER_SALE_DETAILS_STATE:String="averageRevenuePerSale_DetailsState";


		// Year to Date Sales
		public static const YEAR_TO_DATE_SALES_STATE:String="yearToDateSalesState";

		public static const YEAR_TO_DATE_SALES_DETAILS_STATE:String="yearToDateSales_DetailsState";


		// Top Ten Opportunities
		public static const TOP_TEN_OPPORTUNITIES_STATE:String="topTenOpportunitiesState";

		public static const TOP_TEN_OPPORTUNITIES_DETAILS_STATE:String="topTenOpportunities_DetailsState";


		// Sales Pipeline
		public static const SALES_PIPELINE_STATE:String="salesPipelineState";

		public static const SALES_PIPELINE_DETAILS_STATE:String="salesPipeline_DetailsState";




	}
}
