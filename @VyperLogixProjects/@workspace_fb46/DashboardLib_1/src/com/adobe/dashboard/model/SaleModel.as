package com.adobe.dashboard.model
{

	public class SaleModel implements ISaleModel
	{

		/**
		 * Value that is the same for every sale data point.  Used in rendering charts.
		 */
		private var _dataType:String = "Sale";

		public function get dataType():String
		{
			return _dataType;
		}

		public function set dataType(value:String):void
		{
			_dataType = value;
		}


		private var _id:int;

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		private var _client:String;

		public function get client():String
		{
			return _client;
		}

		public function set client(value:String):void
		{
			_client = value;
		}

		private var _clientContact:String;

		public function get clientContact():String
		{
			return _clientContact;
		}

		public function set clientContact(value:String):void
		{
			_clientContact = value;
		}

		private var _gross:Number;

		public function get gross():Number
		{
			return _gross;
		}

		public function set gross(value:Number):void
		{
			_gross = value;
		}

		private var _net:Number;

		public function get net():Number
		{
			return _net;
		}

		public function set net(value:Number):void
		{
			_net = value;
		}

		private var _unitCount:Number;

		public function get unitCount():Number
		{
			return _unitCount;
		}

		public function set unitCount(value:Number):void
		{
			_unitCount = value;
		}

		private var _unitPrice:Number;

		public function get unitPrice():Number
		{
			return _unitPrice;
		}

		public function set unitPrice(value:Number):void
		{
			_unitPrice = value;
		}

		private var _openDate:Date;

		public function get openDate():Date
		{
			return _openDate;
		}

		public function set openDate(value:Date):void
		{
			_openDate = value;
		}

		private var _projectedCloseDate:Date;

		public function get projectedCloseDate():Date
		{
			return _projectedCloseDate;
		}

		public function set projectedCloseDate(value:Date):void
		{
			_projectedCloseDate = value;
		}

		private var _saleCloseDate:Date;

		public function get saleCloseDate():Date
		{
			return _saleCloseDate;
		}

		public function set saleCloseDate(value:Date):void
		{
			_saleCloseDate = value;
		}

		private var _productTitle:String;

		public function get productTitle():String
		{
			return _productTitle;
		}

		public function set productTitle(value:String):void
		{
			_productTitle = value;
		}

		private var _productDescription:String;

		public function get productDescription():String
		{
			return _productDescription;
		}

		public function set productDescription(value:String):void
		{
			_productDescription = value;
		}

		private var _productType:String;

		public function get productType():String
		{
			return _productType;
		}

		public function set productType(value:String):void
		{
			_productType = value;
		}

		private var _leadSalesPerson:String;

		public function get leadSalesPerson():String
		{
			return _leadSalesPerson;
		}

		public function set leadSalesPerson(value:String):void
		{
			_leadSalesPerson = value;
		}

		private var _status:String;

		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			_status = value;
		}




		public function SaleModel(id:int, client:String = null, clientContact:String = null,
								  gross:Number = -1, net:Number = -1, unitCount:Number = -1, unitPrice:Number = -1,
								  openDate:Date = null, projectedCloseDate:Date = null, saleCloseDate:Date = null,
								  productTitle:String = null, productDescription:String = null, productType:String = null,
								  leadSalesPerson:String = null, status:String = null)
		{
			_id = id;
			_client = client;
			_clientContact = clientContact;
			_gross = gross;
			_net = net;
			_unitCount = unitCount;
			_unitPrice = unitPrice;
			_openDate = openDate;
			_projectedCloseDate = projectedCloseDate;
			_saleCloseDate = saleCloseDate;
			_productTitle = productTitle;
			_productDescription = productDescription;
			_productType = productType;
			_leadSalesPerson = leadSalesPerson;
			_status = status;
		}


		public static function fromXML(x:XML):SaleModel
		{

			var gross:Number = parseFloat(x.gross);
			var net:Number = parseFloat(x.net);
			var unitCount:Number = parseFloat(x.unitCount);
			var unitPrice:Number = parseFloat(x.unitPrice);

			var openDate:Date = new Date();
			openDate.time = Date.parse(x.openDate);

			var projectedCloseDate:Date = new Date();
			projectedCloseDate.time = Date.parse(x.projectedCloseDate);

			var saleCloseDate:Date = new Date();
			saleCloseDate.time = Date.parse(x.saleCloseDate);


			return new SaleModel(x.id, x.client, x.clientContact,
								 gross, net,
								 unitCount, unitPrice,
								 openDate, projectedCloseDate, saleCloseDate,
								 x.productTitle, x.productDescription, x.productType,
								 x.leadSalesPerson, x.status);

		}


	}
}