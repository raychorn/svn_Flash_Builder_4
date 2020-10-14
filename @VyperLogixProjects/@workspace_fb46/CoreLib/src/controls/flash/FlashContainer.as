package controls.flash {
	import controls.Alert.AlertPopUp;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.Security;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.controls.SWFLoader;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import spark.components.Button;
	import spark.components.ComboBox;
	import spark.components.Group;
	import spark.components.TextInput;
	import spark.events.ListEvent;

	public class FlashContainer extends Group {
		// Member variables.
		private var __player__:Object;
		private var playerLoader:SWFLoader;

		// CONSTANTS.
		//private static const SECURITY_DOMAIN:String="";
		//private static const PLAYER_URL:String=SECURITY_DOMAIN+"/videoplayers/flowplayer-3.2.8.swf?config=";

		private static const STATE_ENDED:Number=0;
		private static const STATE_PLAYING:Number=1;
		private static const STATE_PAUSED:Number=2;
		private static const STATE_CUED:Number=5;

		[Bindable]
		private var __videoID__:String;
		
		[Bindable]
		private var __autoplay__:Boolean = false;
		
		[Bindable]
		private var __config__:String;
		
		[Bindable]
		private var __swf__:String;
		
		[Bindable]
		private var __domain__:String;
		
		private var __endpoint__:String;
		
		private var __timer__:Timer = new Timer(2500);
		private var __delayed__:Array = [];

		public function FlashContainer():void {
			this.addEventListener(FlexEvent.CREATION_COMPLETE, 
				function (event:FlexEvent):void {
					//setupPlayerLoader();
				}
			);
			this.addEventListener(ResizeEvent.RESIZE, 
				function (event:ResizeEvent):void {
					if (__player__) {
					}
				}
			);
			this.__timer__.addEventListener(TimerEvent.TIMER, 
				function (event:TimerEvent):void {
					var aFunc:Function = __delayed__.pop();
					if (aFunc is Function) {
						aFunc();
					}
				}
			);
			this.__timer__.start();
		}
		
		public function get videoID():String {
			return this.__videoID__;
		}
		
		public function set videoID(videoID:String):void {
			if (this.__videoID__ != videoID) {
				this.__videoID__ = videoID;
			}
		}

		public function get config():String {
			return this.__config__;
		}
		
		public function set config(config:String):void {
			if (this.__config__ != config) {
				this.__config__ = config;
				var toks:Array = config.split('=');
				if (toks.length > 1) {
					this.__config__ = config.replace(toks[0]+'=','');
				} else if (toks.length == 1) {
					this.__config__ = config;
				}
				//AlertPopUp.surpriseNoOkay('toks.length=('+toks.length+')'+', toks[0]=('+toks[0]+')'+', config=('+config+')'+', __config__=('+this.__config__+')','DEBUG.1');
			}
		}
		
		public function get swf():String {
			return this.__swf__;
		}
		
		public function set swf(swf:String):void {
			if (this.__swf__ != swf) {
				this.__swf__ = swf;
			}
		}
		
		public function get domain():String {
			return ( ( (this.__domain__ is String) && (this.__domain__.length > 0) ) ? this.__domain__ : '');
		}
		
		public function set domain(domain:String):void {
			if (this.__domain__ != domain) {
				this.__domain__ = domain;
			}
		}
		
		public function get timer_delay():Number {
			return this.__timer__.delay;
		}
		
		public function set timer_delay(timer_delay:Number):void {
			if (this.__timer__.delay != timer_delay) {
				this.__timer__.delay = timer_delay;
				if (timer_delay > 0) {
					if (this.__autoplay__) {
						this.__timer__.stop();
						this.__timer__.reset();
						this.__timer__.start();
					}
				} else {
					this.__timer__.stop();
				}
			}
		}
		
		public function get autoplay():Boolean {
			return this.__autoplay__;
		}
		
		public function set autoplay(autoplay:Boolean):void {
			if (this.__autoplay__ != autoplay) {
				this.__autoplay__ = autoplay;
				if (!autoplay) {
					this.__timer__.stop();
				} else {
					this.__timer__.stop();
					this.__timer__.reset();
					this.__timer__.start();
				}
			}
		}
		
		public function setupPlayerLoader():void {
			try {
				Security.allowDomain(this.domain);
			} catch (err:Error) {}

			playerLoader=new SWFLoader();
			playerLoader.addEventListener(Event.INIT, playerLoaderInitHandler);
			playerLoader.addEventListener(IOErrorEvent.IO_ERROR, playerLoaderIOErrorHandler);
			this.__endpoint__ = this.domain+this.swf+this.config;
			playerLoader.load(this.__endpoint__);
		}

		private function playerLoaderInitHandler(event:Event):void {
			if (this.__videoID__) {
				playerLoader.x = 0;
				playerLoader.y = 0;
				playerLoader.width = this.width;
				playerLoader.height = this.height;
			}
			addElement(playerLoader);
			playerLoader.content.addEventListener("onReady", onPlayerReady);
			playerLoader.content.addEventListener("onError", onPlayerError);
			playerLoader.content.addEventListener("onStateChange", onPlayerStateChange);
			playerLoader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		}

		private function playerLoaderIOErrorHandler(event:IOErrorEvent):void {
			//AlertPopUp.surpriseNoOkay('Could not load this stream ('+this.__endpoint__+')...\n'+event.toString(),'WARNING: FlashContainer.playerLoaderIOErrorHandler()');
		}
		
		public function get player():* {
			return playerLoader.content;
		}
		
		private function onPlayerReady(event:Event):void {
			__player__=playerLoader.content;
			__player__.visible=false;
		}

		private function onPlayerError(event:Event):void {
		}

		private function onPlayerStateChange(event:Event):void {
			switch (Object(event).data) {
				case STATE_ENDED:
					break;

				case STATE_PLAYING:
					break;

				case STATE_PAUSED:
					break;

				case STATE_CUED:
					break;
			}
		}

		private function onVideoPlaybackQualityChange(event:Event):void {
			resizePlayer(Object(event).data);
		}
		
		private function resizePlayer(qualityLevel:String):void {
			__player__.visible=true;
		}
	}
}