                                                                                            package communication
{
	import flash.events.*;
	import flash.net.*;

    
	public class WebServices
	{
		private var _errorCnt:Boolean = false;
		private var _loader:URLLoader;
		private var _onStatus:Function = null;
		private var _url:String = "";
		private var _errorObj:Object = {};
		
		private const ERR1:String = "404";
		private const ERR2:String = "Security Sandbox - no crossdomain policy";
		
		/**
		 * Constructor
		 */
		 
		public function WebServices() {
		}
		
		/**
		 * Navigate to new URL 
		 * @param url
		 * @param window
		 */
		public static function navigateToUrl(url:String, window:String = null):void {
			var req:URLRequest = new URLRequest(url);
            try
            {
                navigateToURL(req, window);
            }
            catch (e:Error)
            {
                trace("Navigate to URL failed", e.message);
            }
		}
	
	
	
		/**
		 * Get Raw Data NEW
		 * @param url
		 * @param returnHandle
		 */
		public function getData(url:String, onStatus:Function=null, cacheBuster:Boolean=false):void {
			this._url = url;
			
			onStatus is Function && onStatus==null ?
				this._onStatus = function():void{} : this._onStatus = onStatus;
			
			if(cacheBuster) _url+="?"+int(Math.random()*1000000000);

		    var myLoader:URLLoader = new URLLoader();
		    myLoader.load(new URLRequest(url));
		    //onLoad listeners
		    myLoader.addEventListener(Event.COMPLETE, onComplete);
		    myLoader.addEventListener(Event.OPEN, onOpen);
		    myLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
		    myLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		    myLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
		    myLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		
		
		public function onComplete(e:Event):void {
			onSuccess(e.type, true,"",e.currentTarget.data);
		}
		
		
		public function onOpen(e:Event):void {
		}
		
		public function onHTTPStatus(e:HTTPStatusEvent):void {
			if(e.status == 404) onError(e.type, false,ERR1,"");
		}
		
		public function onIOError(e:IOErrorEvent):void {
			onError(e.type, false,ERR1,"");
		}
		
		public function onProgress(e:ProgressEvent):void {
		}
		
		public function onSecurityError(e:SecurityErrorEvent):void {
      		onError(e.type, false,ERR2,"");
		}
		
		private function onSuccess(type:String, success:Boolean, status:String, data:*):void {
			this._onStatus({type:type, success:success, status:status, data:data});
		}
		
		private function onError(type:String, success:Boolean, status:String, data:*):void {
			if(_errorCnt) return;
			this._errorCnt = true;
			this._onStatus({type:type, success:success, status:status, data:data});
		}
		
		
	}
}