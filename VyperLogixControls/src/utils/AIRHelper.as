package utils {
	public class AIRHelper {
		private static var prefixes:Object = {};

		public static var default_prefix:String = 'app:/';
		
		private static var _installable_software_fpaths:Array = [];

		public static function set_prefix(key:String,value:*):void {
			AIRHelper.prefixes[key] = value;
		}

		public static function get get_prefix():String {
			var prefix:String = AIRHelper.prefixes[AIRHelper.default_prefix];
			return (prefix is String) ? prefix : AIRHelper.default_prefix;
		}
	}
}