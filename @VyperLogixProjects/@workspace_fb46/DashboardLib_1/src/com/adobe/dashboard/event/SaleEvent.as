package com.adobe.dashboard.event
{
	import com.adobe.dashboard.model.ISaleModel;

	import flash.events.Event;

	public class SaleEvent extends Event
	{
		public static const CREATE_SALE_EVENT:String="createSaleEvent";

		public static const DELETE_SALE_EVENT:String="deleteSaleEvent";

		public static const UPDATE_SALE_EVENT:String="updateSaleEvent";

		public static const GET_SALE_BY_ID_EVENT:String="getSaleByIdEvent";

		public static const GET_ALL_SALES_EVENT:String="getAllSalesEvent";


		/**
		 * the optional SaleModel
		 */
		private var _sale:ISaleModel;

		public function get sale():ISaleModel
		{
			return _sale;
		}

		/**
		 * the optional id
		 */
		private var _id:int;

		public function get id():int
		{
			return _id;
		}


		/**
		 * constuctor
		 */
		public function SaleEvent(type:String, sale:ISaleModel=null, id:int=-1)
		{
			super(type);

			_sale=sale;
			_id=id;
		}

		/**
		 * always override the clone event
		 */
		override public function clone():Event
		{
			return new SaleEvent(type, _sale, _id);
		}
	}
}
