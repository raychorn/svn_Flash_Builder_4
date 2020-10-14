package com {
	import flash.filesystem.File;

	public class URLUtils {
		public function URLUtils() {
		}

		public static function isURLValid(fname:String):Boolean {
			var aFile:File = File.documentsDirectory.resolvePath(fname);
			return ( (fname is String) && (aFile.exists) );
		}
	}
}