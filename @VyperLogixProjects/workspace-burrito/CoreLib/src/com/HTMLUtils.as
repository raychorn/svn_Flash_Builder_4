package com {
	import flash.events.Event;
	import flash.html.HTMLLoader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;

	public class HTMLUtils {
		public static function load_pdf(url:String,width:Number,height:Number,callback:Function):* {
			var request:URLRequest = new URLRequest(url);
			var pdf:HTMLLoader = new HTMLLoader();
			pdf.width = width;
			pdf.height = height;
			pdf.addEventListener(Event.COMPLETE, function (event:Event):void {
				if (callback is Function) {
					var uic:UIComponent = new UIComponent();
					uic.addChild(pdf);
					callback(uic);
				}
			});
			pdf.load(request);
		}

		public static function load_data(url:String,callback:Function):* {
			var request:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function (event:Event):void {
				if (callback is Function) {
					var xml:URLLoader = event.target as URLLoader;
					callback(xml.data.toString());
				}
			});
			loader.load(request);
		}
	}
}