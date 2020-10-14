package controls.flow {
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

	public class FlowPlayer extends Group {
		// Member variables.
		private var __player__:Object;
		private var playerLoader:SWFLoader;

		// CONSTANTS.
		private static const SECURITY_DOMAIN:String="";
		private static const PLAYER_URL:String=SECURITY_DOMAIN+"/videoplayers/flowplayer-3.2.8.swf?config=";

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
		
		private var __timer__:Timer = new Timer(2500);
		private var __delayed__:Array = [];

		public function FlowPlayer():void {
			try {
				Security.allowDomain(SECURITY_DOMAIN);
			} catch (err:Error) {}

			this.addEventListener(FlexEvent.CREATION_COMPLETE, 
				function (event:FlexEvent):void {
					setupPlayerLoader();
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
				this.__config__ = config.replace('config=','');
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
		
		private function setupPlayerLoader():void {
			playerLoader=new SWFLoader();
			playerLoader.addEventListener(Event.INIT, playerLoaderInitHandler);
			playerLoader.addEventListener(IOErrorEvent.IO_ERROR, playerLoaderIOErrorHandler);
			playerLoader.load(PLAYER_URL+__config__);
		}

		private function playerLoaderInitHandler(event:Event):void {
			if (this.__videoID__) {
				playerLoader.x = 0;
				playerLoader.y = 0;
				playerLoader.width = this.width;
				playerLoader.height = this.height;
				trace("playerLoader.width="+playerLoader.width+', playerLoader.height='+playerLoader.height);
			}
			addElement(playerLoader);
			playerLoader.content.addEventListener("onReady", onPlayerReady);
			playerLoader.content.addEventListener("onError", onPlayerError);
			playerLoader.content.addEventListener("onStateChange", onPlayerStateChange);
			playerLoader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		}

		private function playerLoaderIOErrorHandler(event:IOErrorEvent):void {
			//AlertPopUp.surpriseNoOkay('Could not load this stream...','WARNING');
		}
		
		public function get player():* {
			return playerLoader.content;
		}
		
		private function onPlayerReady(event:Event):void {
			__player__=playerLoader.content;
			__player__.visible=false;
		}

		private function onPlayerError(event:Event):void {
			trace("Player error:", Object(event).data);
		}

		private function onPlayerStateChange(event:Event):void {
			trace("State is", Object(event).data);

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
			trace("Current video quality:", Object(event).data);
			resizePlayer(Object(event).data);
		}

		private function resizePlayer(qualityLevel:String):void {
			__player__.visible=true;
		}
	}
}