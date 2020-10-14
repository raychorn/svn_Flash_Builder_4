package communication {
    import flash.display.Sprite;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.URLRequest;
    import flash.net.URLStream;

    public class Stream extends Sprite {
        private static const ZLIB_CODE:String = "CWS";
        private var stream:URLStream;


		public function Stream() {
			
		}

        public function load():void {
            stream = new URLStream();
            var request:URLRequest = new URLRequest("http://127.0.0.1/phase1/assets.swf");
            //var request:URLRequest = new URLRequest("http://127.0.0.1/phase1/tester.txt");
            configureListeners(stream);
            try {
                stream.load(request);
            } catch (error:Error) {
                trace("Unable to load requested URL.");
            }
        }

        private function configureListeners(dispatcher:EventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        }

        private function parseHeader():void {
//            trace("parseHeader");
//            trace("isCompressed: " + isCompressed());
//            trace("version: " + stream.readByte());
//            trace("version1: " + stream.read());
        }

        private function isCompressed():Boolean {
            return (stream.readUTFBytes(3) == ZLIB_CODE);
        }

        private function completeHandler(event:Event):void {
            trace("completeHandler: " + event);
            
            parseHeader();
        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
            
        }

        private function progressHandler(event:Event):void {
        	
            trace("progressHandler: " + event);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }
    }
}