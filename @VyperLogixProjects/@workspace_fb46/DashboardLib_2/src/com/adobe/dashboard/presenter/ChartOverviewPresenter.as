package com.adobe.dashboard.presenter
{
	import com.adobe.dashboard.model.chart.IChartOverviewDataModel;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class ChartOverviewPresenter extends EventDispatcher
	{
		private var dispatcher:IEventDispatcher;

		[Bindable]
		public var dataModel:IChartOverviewDataModel;

		public function ChartOverviewPresenter(dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;
		}
	}
}