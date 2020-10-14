package com.adobe.dashboard.presenter
{
	import com.adobe.dashboard.model.IChartModel;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class ChartPresenter extends EventDispatcher
	{
		private var dispatcher:IEventDispatcher;

		private var _dataProvider:ArrayCollection;

		[Bindable(event="dataProviderChange")]
		public function get dataProvider():ArrayCollection
		{
			return _dataProvider;
		}

		public function set dataProvider(value:ArrayCollection):void
		{
			if (_dataProvider !== value)
			{
				_dataProvider = value;
				dispatchEvent(new Event("dataProviderChange"));
			}
		}

		[Bindable]
		public var maxiumAxisValue:Number;

		[Bindable]
		public var chartModel:IChartModel;

		[Bindable]
		public var seriesList:ArrayCollection;

		[Bindable]
		public var selectedFillEntries:Array = [];

		/**
		 * Constructor
		 */
		public function ChartPresenter(dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;

			// Set some default data for testing purposes
			dataProvider = new ArrayCollection();
		}


		//
		// Public Methods
		//

		public function clone():ChartPresenter
		{
			var presenter:ChartPresenter = new ChartPresenter(dispatcher);
			presenter.chartModel = chartModel.clone();
			presenter.dataProvider = new ArrayCollection(dataProvider.source);
			return presenter;
		}


	}
}