package core {
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.core.FlexGlobals;

	public class SWFHelper {
		public static var default_prefix:String = 'app:/';
		
		public static var file_prefix:String = 'file://';
		
		public static function normalize_url(fpath:String):String {
			return (fpath is String) ? ((fpath.indexOf(SWFHelper.file_prefix) > -1) ? fpath : SWFHelper.file_prefix+fpath) : fpath;
		}
		
		public static function navigate_to_url(url:String,target:String):void {
			var request:URLRequest = new URLRequest(url); 
			trace('AIRHelper.navigateToUrl.1 --> url='+url);
			navigateToURL(request,target); 				
		}
		
		public static function get is_web_based():Boolean {
			var url:String = FlexGlobals.topLevelApplication.url;
			return (url.indexOf(SWFHelper.default_prefix) == -1);
		}

		public static function get app_name():String {
			var url:String = FlexGlobals.topLevelApplication.url;
			var toks:Array = url.split('/');
			var ar:Array = toks[toks.length-1].split('.');
			if (ar[ar.length-1].toLowerCase().indexOf('swf') > -1) {
				ar.pop();
			}
			return ar.join('.');
		}
		
		public static function get is_localhost():Boolean {
			var url:String = FlexGlobals.topLevelApplication.url;
			return ( (url.indexOf('localhost') > -1) || (url.indexOf('127.0.0.1') > -1) || (url.indexOf(SWFHelper.file_prefix) > -1) );
		}
		
		public static function saveData_for_browsed_file(prompt:String,data:*,callback:Function,onError:Function=null):void {
			var file:File = new File();
			file.addEventListener(Event.SELECT, 
				function (event:Event):void {
					try {
						var newFile:File = event.target as File;
						if (!newFile.exists) {
							var stream:FileStream = new FileStream();
							stream.open(newFile, FileMode.WRITE);
							stream.writeUTFBytes(data);
							stream.close();
						}
					} catch (err:Error) {
						if (onError is Function) {
							try {onError(err);} catch (err:Error) {}
						}
					}
					if (callback is Function) {
						try {callback();} catch (err:Error) {}
					}
				});
			file.browseForSave(prompt)
		}
	}
}