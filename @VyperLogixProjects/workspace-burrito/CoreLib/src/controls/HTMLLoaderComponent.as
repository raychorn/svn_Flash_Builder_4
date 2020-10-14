package controls {
	import com.DebuggerUtils;
	
	import flash.events.Event;
	import flash.events.HTMLUncaughtScriptExceptionEvent;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	[Event(name="HTML_RENDER", type="flash.events.Event")]

	public class HTMLLoaderComponent extends UIComponent {
		public function HTMLLoaderComponent() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private var _htmlLoader:HTMLLoader;
		
		/**
		 * @private
		 * */
		public function get htmlLoader():HTMLLoader {
			return _htmlLoader;
		}
		
		/**
		 * HTML Loader is a window to the native browser. It accepts a URL location.
		 * */
		[Bindable]
		public function set htmlLoader(value:HTMLLoader):void {
			if (_htmlLoader != value) {
				_htmlLoader = value;
			}
		}
		
		private var _source:String;
		
		/**
		 * @private
		 * */
		public function get source():String {
			return _source;
		}
		
		/**
		 * Source URL for stage web view. If autoLoad is set to true then the URL is loaded automatically.
		 * If not use load method to load the source URL
		 * */
		[Bindable]
		public function set source(value:String):void {
			_source = value;
			
			if (htmlLoader) {
				var urlReq:URLRequest = new URLRequest(source);
				htmlLoader.load(urlReq);
			}
		}
		
		/**
		 * When the stage property is available add it to the web view
		 * */
		public function addedToStageHandler(event:Event):void {
			invalidateDisplayList();
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			if (this.htmlLoader) {
				this.htmlLoader.width = value;
			}
		}
		
		/**
		 * Add event listeners to stage web view events
		 * */
		override protected function createChildren():void {
			super.createChildren();
			
			var _this:HTMLLoaderComponent = this;
			
			this.htmlLoader = new HTMLLoader();
			this.htmlLoader.addEventListener(Event.ADDED_TO_STAGE, 
				function (event:Event):void {
					_this.htmlLoader.width = _this.width;
					_this.htmlLoader.height = _this.height;
					if (source is String) {
						var urlReq:URLRequest = new URLRequest(source);
						trace(DebuggerUtils.getFunctionName(new Error())+'.1 --> '+urlReq.url);
						_this.htmlLoader.load(urlReq);
					}
				}
			);
			this.htmlLoader.addEventListener(Event.HTML_RENDER, 
				function (event:Event):void {
					trace(DebuggerUtils.getFunctionName(new Error())+'.2 --> '+event.toString());
					var ii:int = -1;
				}
			);
			this.htmlLoader.addEventListener(Event.LOCATION_CHANGE, 
				function (event:Event):void {
					trace(DebuggerUtils.getFunctionName(new Error())+'.3 --> '+event.toString());
					var ii:int = -1;
				}
			);
			this.htmlLoader.addEventListener(Event.COMPLETE, 
				function (event:Event):void {
					trace(DebuggerUtils.getFunctionName(new Error())+'.4 --> '+event.toString());
					var ii:int = -1;
				}
			);
			this.htmlLoader.addEventListener(HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION, 
				function (event:HTMLUncaughtScriptExceptionEvent):void {
					trace(DebuggerUtils.getFunctionName(new Error())+'.5 --> '+event.toString());
					var ii:int = -1;
				}
			);
			addChild(this.htmlLoader);
		}
		
		/**
		 * Dispatched when the page or web content has been fully loaded
		 * */
		private function completeHandler(event:Event):void {
			dispatchEvent(event.clone());
		}
		
	}
}
