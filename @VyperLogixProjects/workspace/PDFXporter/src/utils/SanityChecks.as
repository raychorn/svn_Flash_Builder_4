package utils {
	import com.FileUtils;
	
	public class SanityChecks {
		private static var _has_data_folder:* = null;
 
		public static var url_data_folder:String;
		
		public static function has_data_folder():Boolean {
			if (SanityChecks._has_data_folder is Boolean) {
				return SanityChecks._has_data_folder;
			} else {
				SanityChecks._has_data_folder = FileUtils.exists(SanityChecks.url_data_folder);
				return SanityChecks._has_data_folder;
			}
		}
	}
}