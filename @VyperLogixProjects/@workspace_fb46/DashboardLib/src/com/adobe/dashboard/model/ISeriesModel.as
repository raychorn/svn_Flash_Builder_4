package com.adobe.dashboard.model
{

	public interface ISeriesModel
	{


		[Bindable(event="propertyChange")]
		function get field():String;
		function set field(value:String):void;

		[Bindable(event="propertyChange")]
		function get axis():String;
		function set axis(value:String):void;

		[Bindable(event="propertyChange")]
		function get name():String;
		function set name(value:String):void;

	}
}