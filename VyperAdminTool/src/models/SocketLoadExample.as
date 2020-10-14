package models
{
	
	
	
	import sockets.WebService;
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.controls.Alert;
		
		
		
	public class SocketLoadExample
	{
		
		
		private var server_num:int = 1;
		
		
		
		[Bindable]
		private var ws:WebService;
		
		[Bindable]
		private var is200:Boolean = false;
		
		[Bindable]
		private var is404:Boolean = false;
		
		[Bindable]
		private var servers:Array = [
			{label:'agnew.idc.vzwcorp.com:8001',data:'/globalnav.txt'},
			{label:'127.0.0.1:7001',data:'/WMSWeb/flex/globalnav/globalnav.txt'},
			//{label:'127.0.0.1:8888',data:'/static/global-nav/globalnav.txt'}
		];

		
		
		public function SocketLoadExample() {
		}
		
		
		
		
		public function init():void {
		}



		public function loadGood():void{
			//var selection:int = this.combo_1.selectedIndex;
			var server_name:String = this.servers[0]['label'];
			this.ws = new WebService(server_name);
			this.ws.dataHandler = this.inputDataHandler;
			this.ws.connectionHandler = this.goodConnectedHandler;
			this.ws.statusChangedHandler = this.statusChangedHandler;
		}



		public function loadBad():void{
			//var selection:int = this.combo_1.selectedIndex;
			var server_name:String = this.servers[1]['label'];
			this.ws = new WebService(server_name);
			this.ws.dataHandler = this.inputDataHandler;
			this.ws.connectionHandler = this.badConnectedHandler;
			this.ws.statusChangedHandler = this.statusChangedHandler;
		}



		public function statusChangedHandler(status:String):void {
			//this.status.text = status;
			this.is200 = this.ws.is200;
			this.is404 = this.ws.is404;
			
			trace("status: "+status);
		}
		
		
		
	    public function inputDataHandler(str:String):void {
			//this.console.text+=str;
			trace("inputDataHandler: "+str);
	    }



    	public function goodConnectedHandler(event:Event):void {
    		//this.console.text = '';
			//var selection:int = this.combo_1.selectedIndex;
			var url:String = this.servers[0]['data'];
    		//this.ws.getDataFrom(url);
	    }



	    public function badConnectedHandler(event:Event):void {
    		//this.console.text = '';
    		//this.ws.getDataFrom('/thisfiledoesnotexist.txt');
	    }
	    
	    
	    
	    public function onChange_combo1(event:*):void {
	    }
	}
}