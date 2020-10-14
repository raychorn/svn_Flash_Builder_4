package com.adobe.dashboard.model
{

	public interface ISaleModel
	{


		[Bindable(event="propertyChange")]
		function get dataType():String;
		function set dataType(value:String):void;

		[Bindable(event="propertyChange")]
		function get id():int;
		function set id(value:int):void;

		[Bindable(event="propertyChange")]
		function get client():String;
		function set client(value:String):void;

		[Bindable(event="propertyChange")]
		function get clientContact():String;
		function set clientContact(value:String):void;

		[Bindable(event="propertyChange")]
		function get net():Number;
		function set net(value:Number):void;

		[Bindable(event="propertyChange")]
		function get gross():Number;
		function set gross(value:Number):void;

		[Bindable(event="propertyChange")]
		function get unitCount():Number;
		function set unitCount(value:Number):void;

		[Bindable(event="propertyChange")]
		function get unitPrice():Number;
		function set unitPrice(value:Number):void;

		[Bindable(event="propertyChange")]
		function get openDate():Date;
		function set openDate(value:Date):void;

		[Bindable(event="propertyChange")]
		function get projectedCloseDate():Date;
		function set projectedCloseDate(value:Date):void;

		[Bindable(event="propertyChange")]
		function get saleCloseDate():Date;
		function set saleCloseDate(value:Date):void;

		[Bindable(event="propertyChange")]
		function get productTitle():String;
		function set productTitle(value:String):void;

		[Bindable(event="propertyChange")]
		function get productDescription():String;
		function set productDescription(value:String):void;

		[Bindable(event="propertyChange")]
		function get productType():String;
		function set productType(value:String):void;

		[Bindable(event="propertyChange")]
		function get leadSalesPerson():String;
		function set leadSalesPerson(value:String):void;

		[Bindable(event="propertyChange")]
		function get status():String;
		function set status(value:String):void;




	}
}