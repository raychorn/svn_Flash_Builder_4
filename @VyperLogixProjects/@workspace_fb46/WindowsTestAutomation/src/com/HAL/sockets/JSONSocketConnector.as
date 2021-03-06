package com.HAL.sockets {
    import com.HAL.sockets.events.CloseHandlerEvent;
    import com.HAL.sockets.events.ConnectHandlerEvent;
    import com.HAL.sockets.events.DataHandlerEvent;
    import com.HAL.sockets.events.ErrorHandlerEvent;
    import com.HAL.sockets.events.IOErrorHandlerEvent;
    import com.HAL.sockets.events.ProgressHandlerEvent;
    import com.HAL.sockets.events.SecurityErrorHandlerEvent;
    import com.HAL.utils.StringUtils;
    
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.Socket;

    public class JSONSocketConnector extends Sprite {
        private var hostName:String = "127.0.0.1";
        private var port:uint = 7800;
        private var socket:Socket;
        
        public static const none_encryptionMethod:String = '';
        public static const custom_encryptionMethod:String = 'custom';
        
        private var _encryptionMethod:String = JSONSocketConnector.none_encryptionMethod;

		[Event(name="connectHandler", type="com.HAL.sockets.events.ConnectHandlerEvent")]
		[Event(name="closeHandler", type="com.HAL.sockets.events.CloseHandlerEvent")]
		[Event(name="dataHandler", type="com.HAL.sockets.events.DataHandlerEvent")]
		[Event(name="ioErrorHandler", type="com.HAL.sockets.events.IOErrorHandlerEvent")]
		[Event(name="progressHandler", type="com.HAL.sockets.events.ProgressHandlerEvent")]
		[Event(name="securityErrorHandler", type="com.HAL.sockets.events.SecurityErrorHandlerEvent")]
		[Event(name="errorHandler", type="com.HAL.sockets.events.ErrorHandlerEvent")]

        public function JSONSocketConnector(hostName:String = 'localhost', port:uint = 7800) {
            this.socket = new Socket();
            this.hostName = hostName;
            this.port = port;
            configureListeners(this.socket);
            this.socket.connect(this.hostName, this.port);
        }
        
        public function set useEncryptionNone(bool:Boolean):void {
        	this.encryptionMethod = JSONSocketConnector.none_encryptionMethod;
        }
        
        public function get useEncryptionNone():Boolean {
        	return this.isEncryptionNone;
        }
        
        public function set useEncryptionCustom(bool:Boolean):void {
        	this.encryptionMethod = ((bool) ? JSONSocketConnector.custom_encryptionMethod : JSONSocketConnector.none_encryptionMethod);
        }
        
        public function get useEncryptionCustom():Boolean {
        	return this.isEncryptionCustom;
        }
        
        public function set encryptionMethod(encryptionMethod:String):void {
        	var isMethodValid:Boolean = false;
        	switch (encryptionMethod) {
        		case JSONSocketConnector.custom_encryptionMethod:
        			isMethodValid = true;
        		break;
        	}
        	if (isMethodValid) {
        		this._encryptionMethod = encryptionMethod;
        	}
        }
        
        public function get encryptionMethod():String {
        	return this._encryptionMethod;
        }

        public function get isEncryptionCustom():Boolean {
        	return (this._encryptionMethod == JSONSocketConnector.custom_encryptionMethod);
        }

        public function get isEncryptionNone():Boolean {
        	return (this._encryptionMethod == JSONSocketConnector.none_encryptionMethod);
        }

        public function send(data:*):void {
        	var x:*;
        	if (this.isEncryptionCustom) {
        		if (data is String) {
	        		data = StringUtils.obscure(data,StringUtils.mode_OBSCURE_ALL_SWAPPER);
        		}
        	}
    		x = StringUtils.dumpAsHexBytesString(data);
        	try { this.socket.writeUTFBytes(x); }
        	catch (err:Error) {
	        	this.dispatchEvent(new ErrorHandlerEvent(ErrorHandlerEvent.TYPE_ERROR_HANDLER, data));
        	}
        }

        private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.CLOSE, closeHandler);
			dispatcher.addEventListener(Event.CONNECT, connectHandler);
			dispatcher.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        }

        private function closeHandler(event:Event):void {
        	this.dispatchEvent(new CloseHandlerEvent(CloseHandlerEvent.TYPE_CLOSE_HANDLER, event));
        }

        private function connectHandler(event:Event):void {
        	this.dispatchEvent(new ConnectHandlerEvent(ConnectHandlerEvent.TYPE_CONNECT_HANDLER, event));
        }

        private function dataHandler(event:ProgressEvent):void {
			var data:* = this.socket.readUTFBytes(this.socket.bytesAvailable);
        	if ( (this.useEncryptionCustom) || (StringUtils.isHexDigits(data)) ) {
        		this.useEncryptionCustom = true;
				data = StringUtils.deobscure(StringUtils.fromHexBytesString(data),StringUtils.mode_OBSCURE_ALL_SWAPPER);
        	}
        	this.dispatchEvent(new DataHandlerEvent(DataHandlerEvent.TYPE_DATA_HANDLER, data));
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
        	this.dispatchEvent(new IOErrorHandlerEvent(IOErrorHandlerEvent.TYPE_IOERROR_HANDLER, event));
        }

        private function progressHandler(event:ProgressEvent):void {
        	this.dispatchEvent(new ProgressHandlerEvent(ProgressHandlerEvent.TYPE_PROGRESS_HANDLER, event));
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
        	this.dispatchEvent(new SecurityErrorHandlerEvent(SecurityErrorHandlerEvent.TYPE_SECURITY_ERROR_HANDLER, event));
        }
    }
}