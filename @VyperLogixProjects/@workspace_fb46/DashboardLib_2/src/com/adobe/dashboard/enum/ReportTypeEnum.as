package com.adobe.dashboard.enum
{

	public class ReportTypeEnum
	{

		public static const ADD_REPORT_ACTION:String="addReportAction";

		// *****
		// Sales Goals Reports 
		// *****

		// Sales Goals > Overview This Month
		public static const COMPARISON_MY_VS_GOAL_GROSS_MONTH_REPORT:String="comparisonMyVsGoalGrossMonthReport";

		// Sales Goals > Overview This Quarter
		public static const COMPARISON_MY_VS_GOAL_GROSS_QUARTER_REPORT:String="comparisonMyVsGoalGrossQuarterReport";

		// Sales Goals > Overview This Year
		public static const COMPARISON_MY_VS_GOAL_GROSS_YEAR_REPORT:String="comparisonMyVsGoalGrossYearReport";

		// Sales Goals
		public static const COMPARISON_MY_VS_GOAL_GROSS_REPORT:String="comparisonMyVsCompanyGrossReport";

		// Details > Sales Goals
		public static const MY_GROSS_REPORT:String="myGrossReport";



		// *****
		// Average Recenue Per Sale Reports
		// *****

		// My Net vs Gross > Overview
		public static const COMPARISON_MY_COST_VS_PROFIT_REPORT:String="comparisonMyNetVsGrossReport";

		// Company Sales Profit vs Cost
		public static const COMPARISON_COMPANY_COST_VS_PROFIT_REPORT:String="comparisonCompanyNetVsGrossReport";

		// Company Sales > Costs
		public static const COMPANY_COST_BY_CLIENT_REPORT:String="companyGrossReport";

		// Company Sales > Profit
		public static const COMPANY_NET_BY_CLIENT_REPORT:String="companyNetReport";

		// My Sales > Profit vs Cost
		// COMPARISON_MY_NET_VS_GROSS_REPORT (see above)

		// My Sales > Costs
		public static const MY_COST_BY_CLIENT_REPORT:String="myCostByClientReport";

		// My Sales > Profit
		public static const MY_NET_BY_CLIENT_REPORT:String="myNetByClientReport";



		// *****
		// Year to Date Dales Reports
		// *****

		// Year to Date Sales > Overview (sales per each month of the year)
		public static const COMPANY_GROSS_YEAR_BY_MONTH_REPORT:String="companyGrossYearByMonthReport";

		// 2010 vs prior years
		public static const COMPANY_GROSS_BY_YEAR_REPORT:String="companyGrossByYearReport";

		// My Sales vs Compnay		
		public static const COMPARISON_MY_VS_COMPANY_GROSS_BY_YEAR_REPORT:String="comparisonMyVsCompanyGrossByYearReport";

		// Details > Company Sales
		public static const COMPANY_GROSS_BY_YEAR_AND_COMPANY_REPORT:String="companyGrossByYearAndCompanyReport";

		// Details > My Sales
		public static const MY_GROSS_BY_YEAR_AND_COMPANY_REPORT:String="myGrossByYearAndCompanyReport";


		// *****
		// Top Ten Opportunities Reports
		// *****

		// All Closing Dates
		public static const TOP_OPERTUNITIES_REPORT:String="topOpertunitiesReport";

		// This Year Closing Dates
		public static const TOP_OPERTUNITIES_THIS_YEAR_REPORT:String="topOpertunitiesThisYearReport";

		// Next Year Closing Dates
		public static const TOP_OPERTUNITIES_NEXT_YEAR_REPORT:String="topOpertunitiesNextYearReport";


		// *****
		// Sales Pipeline Reports
		// *****

		// Sales Pipeline > Overview (3 data points Prospect, Qualify, Close)
		public static const MY_SALES_PIPELINE_BY_STATUS_REPORT:String="mySalesPipelineByStatusReport";

		// My Sales Pipline
		public static const MY_SALES_PIPELINE_REPORT:String="mySalesPipelineReport";

		// My Pipeline vs Average
		public static const COMPARISON_MY_VS_AVERAGE_SALES_PIPELINE_REPORT:String="comparisonMyVsAverageSalesPipelineReport";

		// Sales Pipeline > Prospect
		public static const MY_SALES_PIPELINE_PROSPECT_REPORT:String="mySalesPipelineProspectReport";

		// Sales Pipeline > Qualify
		public static const MY_SALES_PIPELINE_QUALIFY_REPORT:String="mySalesPipelineQualifyReport";

		// Sales Pipeline > Close
		public static const MY_SALES_PIPELINE_CLOSE_REPORT:String="mySalesPipelineCloseReport";



	}
}
