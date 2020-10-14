package com.adobe.dashboard.model
{
	import com.adobe.dashboard.presenter.*;

	public class AppModel
	{
		private static var instance:AppModel;

		public function AppModel()
		{
			if (instance)
			{
				throw new Error("Please call AppModel.getInstance() instead of new.");
			}
		}

		public static function getInstance():AppModel
		{
			if (!instance)
			{
				instance = new AppModel();
			}
			return instance;
		}


		//
		// Instances of Presenters
		// Note: If you are using framework similar to Swiz or Robotlegs this will
		// most likely be handled in framework code
		//

		public var mainPresenter:MainPresenter;



		// Dashboard

		public var salesGoalsPresenter:SalesGoalsPresenter;

		public var averageRevenuePresenter:AverageRevenuePresenter;

		public var yearToDatePresenter:YearToDatePresenter;

		public var salesPipelinePresenter:SalesPipelinePresenter;

		public var topOpportunitiesPresenter:TopOpportunitiesPresenter;


	}
}