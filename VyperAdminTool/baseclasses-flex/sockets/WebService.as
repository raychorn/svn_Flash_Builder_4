package sockets {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	import utils.strings.URLUtils;
	
	public class WebService {
		private var _server:String = '';
		private var _port:int = 80;

		private var _url:String = '';

		private var _connection_handler:Function;
		private var _data_handler:Function;
		private var _close_handler:Function;
		private var _ioError_handler:Function;
		private var _securityError_handler:Function;

		private var _statusChanged_handler:Function;
		
        public var dummy:Function = function ():void {};

		public var socket:Socket;
		
		private const CR:String = '\n';
		private const CRLF:String = '\r\n';

		private var isOkay_RegExp:RegExp = /HTTP\/[0-9].[0-9]\s200/;		
		private var isMissing_RegExp:RegExp = /HTTP\/[0-9].[0-9]\s404/;		

		private var _isOkay_received:Boolean = false;
		private var _isMissing_received:Boolean = false;
		
		private var _status:String = '';
		private var _headers:Array = [];
		
		public function WebService(server:String,port:int=80,connection_handler:Function=null,data_handler:Function=null,close_handler:Function=null,ioError_handler:Function=null,securityError_handler:Function=null) {
			this.open_socket(server,port);

			this._connection_handler = connection_handler;
        	this.socket.addEventListener(Event.CONNECT, (connection_handler is Function) ? connection_handler : this.dummy);

			this._data_handler = data_handler;
			this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.data_handler);

			this._close_handler = close_handler;
			this.socket.addEventListener(Event.CLOSE, (close_handler is Function) ? close_handler : this.dummy);

			this._ioError_handler = ioError_handler;
			this.socket.addEventListener(IOErrorEvent.IO_ERROR, (ioError_handler is Function) ? ioError_handler : this.dummy);

			this._securityError_handler = securityError_handler;
			this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, (securityError_handler is Function) ? securityError_handler : this.dummy);
			
			this._statusChanged_handler = this.dummy;
		}
		
		public function open_socket(server:String,port:int=80):void {
			var domain:String = URLUtils.domain_with_port_and_protocol(server);
			var doesNotHaveURL:Boolean = (domain.length == 0);
			domain = (doesNotHaveURL) ? server : domain;
			this._url = server.replace(domain,'');
			var s:String = (doesNotHaveURL) ? '' : server.replace(this._url,'');
			trace('open_socket().1 --> this._url='+this._url);
			domain = URLUtils.domain_with_port(s);
			domain = (domain.length == 0) ? server : domain;
			var toks:Array = domain.split(':');
			if (this._server != toks[0]) {
				this._server = toks[0];
			}
			var _port:int = (toks.length == 2) ? toks[toks.length -1] : port;
			if (this._port != _port) {
				this._port = _port;
			}
			this.socket = new Socket();
			trace('open_socket().2 --> this._server='+this._server+', this._port='+this._port);
			this.socket.connect(this._server, this._port);
		}
		
		public function get serverAddress():String {
			return this._server;
		}
		
		public function get portNumber():int {
			return this._port;
		}
		
		public function set connectionHandler(connection_handler:Function):void {
			if ( (this._connection_handler != connection_handler) && (this._connection_handler is Function) ) {
	        	this.socket.removeEventListener(Event.CONNECT, this._connection_handler);
			}
        	if (connection_handler is Function) {
	        	this._connection_handler = connection_handler;
	        	this.socket.addEventListener(Event.CONNECT, connection_handler);
        	}
		}
		
		public function set dataHandler(data_handler:Function):void {
			if (this._data_handler != data_handler) {
	        	this._data_handler = data_handler;
			}
		}
		
		public function set closeHandler(close_handler:Function):void {
			if ( (this._close_handler != close_handler) && (this._close_handler is Function) ) {
	        	this.socket.removeEventListener(Event.CLOSE, this._close_handler);
			}
        	if (close_handler is Function) {
	        	this._close_handler = close_handler;
				this.socket.addEventListener(Event.CLOSE, close_handler);
        	}
		}
		
		public function set ioErrorHandler(ioError_handler:Function):void {
			if ( (this._ioError_handler != ioError_handler) && (this._ioError_handler is Function) ) {
	        	this.socket.removeEventListener(IOErrorEvent.IO_ERROR, this._ioError_handler);
			}
        	if (ioError_handler is Function) {
	        	this._ioError_handler = ioError_handler;
				this.socket.addEventListener(IOErrorEvent.IO_ERROR, ioError_handler);
        	}
		}
		
		public function set securityErrorHandler(securityError_handler:Function):void {
			if ( (this._securityError_handler != securityError_handler) && (this._securityError_handler is Function) ) {
	        	this.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this._securityError_handler);
			}
        	if (securityError_handler is Function) {
	        	this._securityError_handler = securityError_handler;
				this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError_handler);
        	}
		}
		
		public function set statusChangedHandler(statusChanged_handler:Function):void {
			if (this._statusChanged_handler != statusChanged_handler) {
				this._statusChanged_handler = statusChanged_handler
			}
		}
		
		public function get status():String {
			return this._status;
		}
		
		public function get is200():Boolean {
			return this._isOkay_received;
		}
		
		public function get is404():Boolean {
			return this._isMissing_received;
		}
		
		private function seek_first_CRLF(lines:Array):Array {
			if (lines is Array) {
				while ( (lines.length > 1) && (String(lines[0]).length > 0) ) {
					this._headers.push(lines[0]);
					if (lines.length == 1) {
						lines.pop();
					} else {
						lines.splice(0,1); // eat the header data...
					}
				}
				if (String(lines[0]).length == 0) {
					if (lines.length == 1) {
						lines.pop();
					} else {
						lines.splice(0,1); // eat the CRLF that is supposed to exist.
					}
				}
			}
			return lines;
		}
		
	    private function data_handler(event:ProgressEvent):void {
	    	var _str:String;
			var bytesLoaded:int = this.socket.bytesAvailable;
			var str:String = this.socket.readUTFBytes(this.socket.bytesAvailable);
			var lines:Array = str.split(this.CRLF);

	    	function handle_lines_of_data():void {
				lines = seek_first_CRLF(lines);
				if (lines.length > 0) {
					_str = lines.join(CR);
					if (this._data_handler is Function) {
						try { this._data_handler(_str) } catch (e:Error) {trace(e.message)}
					}
				}
	    	}

			if ( (!this._isOkay_received) && (!this._isMissing_received) ) {
				this._isOkay_received = (this.isOkay_RegExp.test(str));
				this._isMissing_received = (this.isMissing_RegExp.test(str));
				if ( (this._isOkay_received) || (this._isMissing_received) ) {
					for (var i:String in lines) {
						if ( ( (this._isOkay_received) && (this.isOkay_RegExp.test(lines[i])) ) || ( (this._isMissing_received) && (isMissing_RegExp.test(lines[i])) ) ) {
							if (this._statusChanged_handler is Function) {
								try {this._statusChanged_handler(lines[i])} catch (e:Error) {}
							}
							var _lines:Array = lines.splice(int(i),1);
							this._status = (_lines.length > 1) ? _lines.join(this.CR) : _lines[0];
							handle_lines_of_data();
							break;
						}
					}
				}
			} else {
				handle_lines_of_data();
			}
	    }

		public function getDataFrom():void {
    		this._isOkay_received = this._isMissing_received = false;
    		this._status = '';
    		this._headers.splice(0,this._headers.length);
			trace('getDataFrom() --> this._url='+this._url);
        	this.socket.writeUTFBytes("GET " + this._url + " HTTP/1.0\n\n");
        	this.socket.flush();
		}

		public function postDataTo(data:String):void {
    		this._isOkay_received = this._isMissing_received = false;
    		this._status = '';
    		this._headers.splice(0,this._headers.length);
    		var _data:String = ((data is String) ? String(data) : '');
        	this.socket.writeUTFBytes("POST " + this._url + " HTTP/1.0\nUser-Agent: Flex 3.3/1.0\nContent-Type: application/x-www-form-urlencoded\nContent-Length: "+_data.length+"\n"+_data.length);
        	this.socket.flush();
		}
	}
}
