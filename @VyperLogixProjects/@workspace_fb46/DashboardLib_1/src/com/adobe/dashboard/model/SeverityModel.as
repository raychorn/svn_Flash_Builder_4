package com.adobe.dashboard.model
{

	public class SeverityModel
	{

		private var _label:String;

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}


		private var _data:String;

		public function get data():String
		{
			return _data;
		}

		public function set data(value:String):void
		{
			_data = value;
		}

		private var _icon:Object;

		public function get icon():Object
		{
			return _icon;
		}

		public function set icon(value:Object):void
		{
			_icon = value;
		}


		public function SeverityModel(label:String = null, data:String = null, icon:Object = null)
		{
			_label = label;
			_data = data;
			_icon = icon;
		}

		public static function fromXML(x:XML):SeverityModel
		{
			var icon:String = x.icon;
			return new SeverityModel(x.@label, x.@data, icon);
		}
	}
}