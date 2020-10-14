package sockets {
	import flash.events.Event;
	
	import utils.strings.URLUtils;
	
	public class SocketWebService extends WebService {
		private var _data:Array = [];

		private var data:String;
		
		private var _callback:Function = null;
		
		private var _isDoingPost:Boolean = false;
		
		public function SocketWebService(server:String='127.0.0.1', port:int=80, connection_handler:Function=null, data_handler:Function=null, close_handler:Function=null, ioError_handler:Function=null, securityError_handler:Function=null) {
			super(server, port, connection_handler, data_handler, close_handler, ioError_handler, securityError_handler);
		}
		
		public function set callback(callback:Function):void {
			if (this._callback != callback) {
				this._callback = callback;
			}
		}
		
		public function get callback():Function {
			return this._callback;
		}

	    private function _dataHandler(str:String):void {
			this._data.push(str);
			trace('_dataHandler().1 !');
	    }

    	private function _connectionHandler(event:Event):void {
    		this._data.splice(0,this._data.length);
			trace('_connectionHandler().1 !');
    		if (this._isDoingPost) {
    			var _data:String = this.data;
	    		this.data = '';
    			this.postDataTo(_data);
				trace('_connectionHandler().2 !');
    		} else {
	    		this.data = '';
	    		this.getDataFrom();
				trace('_connectionHandler().3 !');
    		}
	    }

		private function _statusChangedHandler(status:String):void {
			this._data.push('');
			trace('_statusChangedHandler().1 status='+status);
		}

		private function _closeHandler(event:Event):void {
			this.data = this._data.join('');
			trace('_closeHandler().1 !');
			if (this._callback is Function) {
				try { this._callback(this.data) } catch (e:Error) {}
			}
		}

		public function send(url:String,callback:Function):void {
			this._isDoingPost = false;
			this._callback = callback;
			this.dataHandler = this._dataHandler;
			this.connectionHandler = this._connectionHandler;
			this.statusChangedHandler = this._statusChangedHandler;
			this.closeHandler = this._closeHandler;
			this.open_socket(url);
		}

		public function post(url:String,data:String,callback:Function):void {
			this._isDoingPost = true;
			this.data = data;
			this._callback = callback;
			this.dataHandler = this._dataHandler;
			this.connectionHandler = this._connectionHandler;
			this.statusChangedHandler = this._statusChangedHandler;
			this.closeHandler = this._closeHandler;
			this.open_socket(url);
		}
	}
}