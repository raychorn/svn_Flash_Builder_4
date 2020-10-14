package sockets {
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.FlexEvent;
	
	import sockets.WebService;
	
	public class DataLoader {
		[Bindable]
		public static var ws:WebService;
		
		public static function loadDataFrom(url:String,dataHandler:Function,connectedHandler:Function,statusChangedHandler:Function):void{
			DataLoader.ws = new WebService(url);
			DataLoader.ws.dataHandler = dataHandler;
			DataLoader.ws.connectionHandler = connectedHandler;
			DataLoader.ws.statusChangedHandler = statusChangedHandler;
			DataLoader.ws.getDataFrom();
		}
		
		public function statusChangedHandler(status:String):void {
			trace("status: "+status);
		}
		
		public function inputDataHandler(str:String):void {
			//this.console.text+=str;
			trace("inputDataHandler: "+str);
		}
		
		public function goodConnectedHandler(event:Event):void {
			//var url:String = this.servers[0]['data'];
			//this.ws.getDataFrom(url);
		}
	}
}
