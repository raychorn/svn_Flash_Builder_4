package com {
	import controls.Alert.AlertPopUp;
	
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	
	import utils.AIRHelper;

	public class ContentCache {
		public static function cache(source:String):String {
			var toks:Array = source.split(File.separator);
			var toks2:Array = toks.slice(toks.indexOf('data'),toks.length);
			toks2.splice(0,0,'app:');
			var target:String = toks2.join(File.separator);
			// +++ Make sure the target folders exist... use a similar technique as the AIRHelper class...
			var targetFile:File;
			AIRHelper.walk_folder_paths(target,
				function (aFile:File,index:int):void {
					targetFile = aFile;
					if (aFile.exists == false) {
						aFile.createDirectory();
						trace('ContentCache.cache().walk_folder_paths().1 --> createDirectory ! --> aFile='+aFile.nativePath);
					}
				}
			);
			var ac:ArrayCollection = new ArrayCollection(target.split(File.separator));
			targetFile = targetFile.resolvePath(String(ac.getItemAt(ac.length-1)));
			var sourceFile:File = new File(source);
			if (targetFile.exists) {
				//return AIRHelper.normalize_url(targetFile.nativePath);
				return targetFile.nativePath;
			} else {
				try {
					sourceFile.copyTo(targetFile, false);
					//return AIRHelper.normalize_url(targetFile.nativePath);
					return targetFile.nativePath;
				} catch (err:Error) {trace(''+err.toString());}
			}
			AlertPopUp.surpriseNoOkay('Unable to show the document you selected.','WARNING');
			return '';
		} 
	}
}