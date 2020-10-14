package com.adobe.dashboard.model
{

	public interface IChartModel
	{
		[Bindable(event="propertyChange")]
		function get id():int;
		function set id(value:int):void;

		[Bindable(event="propertyChange")]
		function get reportType():String;
		function set reportType(value:String):void;

		[Bindable(event="propertyChange")]
		function get chartType():String;
		function set chartType(value:String):void;

		[Bindable(event="propertyChange")]
		function get title():String;
		function set title(value:String):void;

		[Bindable(event="propertyChange")]
		function get fromDate():Date;
		function set fromDate(value:Date):void;

		[Bindable(event="propertyChange")]
		function get toDate():Date;
		function set toDate(value:Date):void;

		[Bindable(event="propertyChange")]
		function get showLegend():Boolean;
		function set showLegend(value:Boolean):void;

		[Bindable(event="propertyChange")]
		function get inDashboard():Boolean;
		function set inDashboard(value:Boolean):void;

		function clone():IChartModel;

	}
}