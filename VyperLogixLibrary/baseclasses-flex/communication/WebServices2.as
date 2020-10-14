/*
 * Class: WebServices
 * @author Ryan C. Knaggs - 02/10/2010
 * @description: Designed to load text and binary
 * data files.  If access to the file has
 * an error the return handle will specify
 * the error.
 */



package communication
{
	import flash.net.*;
	import flash.events.*;
    
	public class WebServices2
	{
		private var _loader:URLLoader;
		private var _errorObj:Object = {};
		private var _onStatus:Function = null;
		private var _url:String = "";
		private var _errorCnt:Boolean = false;
		private var _error_F:Boolean = false;
		
		// Cache
		private const _CRND:int = 100000000;
		
		// HTTP Status
		public const S1:int = 404;
		
		// Error Messages
		public const ERR01:String = "ERROR (404): File not Found: ";
		public const ERR02:String = "Security Sandbox - no crossdomain policy";
		
		
		/**
		 * Constructor
		 */
		 
		public function WebServices2() {
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
			
			if(cacheBuster) _url+="?"+int(Math.random()*_CRND);

		    var myLoader:URLLoader = new URLLoader();
		    myLoader.load(new URLRequest(url));
		   
			// On Load Listeners
		    myLoader.addEventListener(Event.COMPLETE, onComplete);
		    myLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
		    myLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		    myLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
		    myLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
        
        
       
        
		/**
		 * On Load Success 
		 * @param e:Event
		 */
		 		
		private function onComplete(e:Event):void {
			if(_error_F) return;
			onSuccess(e.type, true,"",e.currentTarget.data);
		}
		
		
		/**
		 * On HTTP Status
		 * @param e:HTTPStatusEvent
		 */		
		 
		private function onHTTPStatus(e:HTTPStatusEvent):void {
			if(e.status == S1) {
				_error_F = true;
				onError(e.type, false,ERR01,"");
			}
		}
		
		
		/**
		 * On IOError 
		 * @param e:IOErrorEvent
		 */
		 		
		private function onIOError(e:IOErrorEvent):void {
			_error_F = true;
			onError(e.type, false,ERR01,"");
		}
		
		
		/**
		 * On load progress 
		 * @param e:ProgressEvent
		 */
		 
		private function onProgress(e:ProgressEvent):void {
		}
		
		
		/**
		 * On Security Error - If no crossdomain file
		 * or crossdomain file is not configured
		 * to access present domain or port where
		 * this SWF file is located 
		 * @param e:SecurityErrorEvent
		 */
		 		
		private function onSecurityError(e:SecurityErrorEvent):void {
      		onError(e.type, false,ERR02,"");
		}
		
		
		/**
		 * @private
		 * Send back an Object if file load success 
		 * @param type
		 * @param success
		 * @param status
		 * @param data
		 */
		 
		private function onSuccess(type:String, success:Boolean, status:String, data:*):void {
			this._onStatus({type:type, success:success, status:status, data:data});
		}
		
		
		/**
		 * @private
		 * Send back an Object if file load error 
		 * @param type
		 * @param success
		 * @param status
		 * @param data
		 */
		 		
		private function onError(type:String, success:Boolean, status:String, data:*):void {
			if(_errorCnt) return;
			this._errorCnt = true;
			this._onStatus({type:type, success:success, status:status, data:data});
		}
	}
}