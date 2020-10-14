package com.adobe.dashboard.presenter
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class TopOpportunitiesPresenter extends EventDispatcher
	{
		private var dispatcher:IEventDispatcher;

		[Bindable]
		public var chartOverviewPresenter:ChartOverviewPresenter;

		[Bindable]
		public var chartDetailsPresenter:ChartPresenter;

		public function TopOpportunitiesPresenter(dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;
			buildPresenters();
		}

		private function buildPresenters():void
		{
			chartOverviewPresenter = new ChartOverviewPresenter(dispatcher);
			chartDetailsPresenter = new ChartPresenter(dispatcher);
		}

		//
		// Public methods
		//



	}
}