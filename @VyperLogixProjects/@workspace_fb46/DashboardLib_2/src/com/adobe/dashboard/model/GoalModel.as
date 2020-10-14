package com.adobe.dashboard.model
{

	public class GoalModel
	{

		private var _id:int;

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
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


		private var _startDate:Date;

		public function get startDate():Date
		{
			return _startDate;
		}

		public function set startDate(value:Date):void
		{
			_startDate = value;
		}


		private var _periodName:String;

		public function get periodName():String
		{
			return _periodName;
		}

		public function set periodName(value:String):void
		{
			_periodName = value;
		}


		/**
		 * constuctor
		 */
		public function GoalModel(id:int, gross:Number = -1, startDate:Date = null, periodName:String = null)
		{
			_id = id;
			_gross = gross;
			_startDate = startDate;
			_periodName = periodName
		}


		/**
		 * parse an xml object into a GoalModel
		 */
		public static function fromXML(x:XML):GoalModel
		{
			var gross:Number = parseFloat(x.gross);

			var startDate:Date = new Date();
			startDate.time = Date.parse(x.startDate);

			return new GoalModel(x.id, gross, startDate, x.periodName);
		}

	}
}