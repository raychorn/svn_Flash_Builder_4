package globals {
	public class GlobalsVO {
		private static var values:Object = {};
		
		public static const APPLICATION_TITLE:String = 'application_title';
		public static const APPLICATION_VERSION:String = 'application_version';
		public static const APPLICATION_COPYRIGHT:String = 'application_copyright';
		
		public static function getValueByName(name:String):* {
			return GlobalsVO.values[name];
		}

		public static function setValueByName(name:String,value:*):* {
			GlobalsVO.values[name] = value;
		}
}
}