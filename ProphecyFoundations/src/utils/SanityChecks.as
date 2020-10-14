package utils {
	import com.FileUtils;
	
	public class SanityChecks {
		private static var _has_data_folder:* = null;
 
		private static var _url_data_folder:String = AIRHelper.get_prefix+'data/';
		
		public static function has_data_folder():Boolean {
			if (SanityChecks._has_data_folder is Boolean) {
				return SanityChecks._has_data_folder;
			} else {
				SanityChecks._has_data_folder = FileUtils.exists(SanityChecks._url_data_folder);
				return SanityChecks._has_data_folder;
			}
		}
	}
}