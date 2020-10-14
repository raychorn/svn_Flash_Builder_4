/*
Copyright 2009 Google Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package com.google.youtube {
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.MouseEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLVariables;
  import flash.system.Security;
  
  import mx.collections.ArrayCollection;
  import mx.controls.SWFLoader;
  import mx.events.FlexEvent;
  import mx.events.ResizeEvent;
  
  import spark.components.Button;
  import spark.components.ComboBox;
  import spark.components.Group;
  import spark.components.TextInput;
  import spark.events.IndexChangeEvent;
  import spark.events.ListEvent;

  public class AS3Player extends Group {
    // Member variables.
    private var _cueButton_:Button;
    private var _isQualityPopulated_:Boolean;
    private var _isWidescreen_:Boolean;
    private var _pauseButton_:Button;
    private var _playButton_:Button;
    private var _player_:Object;
    private var _playerLoader_:SWFLoader;
    private var _qualityComboBox_:ComboBox;
    private var _videoIdTextInput_:TextInput;
    private var _youtubeApiLoader_:URLLoader;
	private var _isChromeless_:Boolean = false;
	private var _video_id_:String;
	
	private var _gui_children_:Array = [];

    // CONSTANTS.
	private static const SYMBOL_ID:String = "{{id}}";
    private static const DEFAULT_VIDEO_ID:String = "0QRO3gKj3qw";
    private static const PLAYER_URL:String = "http://www.youtube-nocookie.com/v/"+SYMBOL_ID+"?fs=0&hl=en_US&hd=1";
	private static const CHROMELESS_PLAYER_URL:String = "http://www.youtube.com/apiplayer?version=3";
    private static const SECURITY_DOMAIN:String = "http://www.youtube.com";
    private static const YOUTUBE_API_PREFIX:String = "http://gdata.youtube.com/feeds/api/videos/";
    private static const YOUTUBE_API_VERSION:String = "2";
    private static const YOUTUBE_API_FORMAT:String = "5";
    private static const WIDESCREEN_ASPECT_RATIO:String = "widescreen";
    private static const QUALITY_TO_PLAYER_WIDTH:Object = {
															small: 320,
															medium: 640,
															large: 854,
															hd720: 1280
														};
    private static const STATE_ENDED:Number = 0;
    private static const STATE_PLAYING:Number = 1;
    private static const STATE_PAUSED:Number = 2;
    private static const STATE_CUED:Number = 5;

    public function AS3Player(isChromeless:Boolean=false):void {
      // Specifically allow the chromless player .swf access to our .swf.
	  try {Security.allowDomain(SECURITY_DOMAIN);} catch (err:Error) {}
	  
	  this._isChromeless_ = isChromeless;

	  this._gui_children_ = [];
	  
      setupUi();
      setupPlayerLoader();
      setupYouTubeApiLoader();
	  
	  var _this:AS3Player = this;
	  this.addEventListener(ResizeEvent.RESIZE, 
		  function (event:ResizeEvent):void {
			  trace(_this+'.ResizeEvent.RESIZE.1 --> x='+x);
			  trace(_this+'.ResizeEvent.RESIZE.2 --> y='+y);
			  trace(_this+'.ResizeEvent.RESIZE.3 --> width='+width);
			  trace(_this+'.ResizeEvent.RESIZE.4 --> height='+height);
		  }
	  );
    }

	public function get video_id():String {
		return this._video_id_;
	}
	
	public function set video_id(video_id:String):void {
		if (this._video_id_ != video_id) {
			this._video_id_ = video_id;
			this.setupPlayerLoader();
		}
	}
	
	public function get videoIdTextInput():TextInput {
		return this._videoIdTextInput_;
	}
	
	public function get cueButton():Button {
		return this._cueButton_;
	}
	
	public function get isQualityPopulated():Boolean {
		return this._isQualityPopulated_;
	}
	
	public function get isWidescreen():Boolean {
		return this._isWidescreen_;
	}
	
	public function get pauseButton():Button {
		return this._pauseButton_;
	}
	
	public function get playButton():Button {
		return this._playButton_;
	}
	
	public function get player():Object {
		return this._player_;
	}
	
	public function get playerLoader():SWFLoader {
		return this._playerLoader_;
	}
	
	public function get qualityComboBox():ComboBox {
		return this._qualityComboBox_;
	}
	
	public function get youtubeApiLoader():URLLoader {
		return this._youtubeApiLoader_;
	}
	
	public function get isChromeless():Boolean {
		return this._isChromeless_;
	}
	
    private function setupUi():void {
      // Create a TextInput field for the YouTube video id, and pre-populate it.
      this._videoIdTextInput_ = new TextInput();
      this.videoIdTextInput.text = DEFAULT_VIDEO_ID;
      this.videoIdTextInput.width = 100;
      this.videoIdTextInput.x = 10;
      this.videoIdTextInput.y = 10;
	  this._gui_children_.push(this.videoIdTextInput);
      addChild(this.videoIdTextInput);

      // Create a Button for cueing up the video whose id is specified.
      this._cueButton_ = new Button();
      this.cueButton.enabled = false;
      this.cueButton.label = "Cue Video";
      this.cueButton.width = 100;
      this.cueButton.x = 120;
      this.cueButton.y = 10;
      this.cueButton.addEventListener(MouseEvent.CLICK, cueButtonClickHandler);
	  this._gui_children_.push(this.cueButton);
      addChild(this.cueButton);

      // Create a ComboBox that will contain the list of available playback
      // qualities. Selecting from the ComboBox will change the playback quality
      // and resize the player. Note that playback qualities are only available
      // once a video has started playing, so the values in this ComboBox can't
      // be populated until then.
      this._qualityComboBox_ = new ComboBox();
      this.qualityComboBox.prompt = "n/a";
      this.qualityComboBox.width = 100;
      this.qualityComboBox.x = 230;
      this.qualityComboBox.y = 10;
      this.qualityComboBox.addEventListener(IndexChangeEvent.CHANGE, // ???
                                       qualityComboBoxChangeHandler);
	  this._gui_children_.push(this.qualityComboBox);
      addChild(this.qualityComboBox);

      // Create a Button for playing the cued video.
      this._playButton_ = new Button();
      this.playButton.enabled = false;
      this.playButton.label = "Play";
      this.playButton.width = 100;
      this.playButton.x = 340;
      this.playButton.y = 10;
      this.playButton.addEventListener(MouseEvent.CLICK, playButtonClickHandler);
	  this._gui_children_.push(this.playButton);
      addChild(this.playButton);

      // Create a Button for pausing the cued video.
      this._pauseButton_ = new Button();
      this.pauseButton.enabled = false;
      this.pauseButton.label = "Pause";
      this.pauseButton.width = 100;
      this.pauseButton.x = 450;
      this.pauseButton.y = 10;
      this.pauseButton.addEventListener(MouseEvent.CLICK, pauseButtonClickHandler);
	  this._gui_children_.push(this.pauseButton);
      addChild(this.pauseButton);
    }

    private function setupPlayerLoader():void {
      this._playerLoader_ = new SWFLoader();
      this.playerLoader.addEventListener(Event.INIT, playerLoaderInitHandler);
	  var s:String = (this.isChromeless) ? CHROMELESS_PLAYER_URL : PLAYER_URL;
	  var url:String = s.replace(SYMBOL_ID,(this.video_id is String) ? this.video_id : this.videoIdTextInput.text);
      this.playerLoader.load(url);
    }
	
	private function get gui_floor():Number {
		var y:Number = 0;
		for (var i:int = 0; i < this._gui_children_.length; i++) {
			if ( (this._gui_children_[i].visible) && (this._gui_children_[i].includeInLayout) ) {
				y = Math.max(y,this._gui_children_[i].y);
			}
		}
		return y;
	}
	
	private function connect_playerLoader_content_handlers():void {
		try {
			this.playerLoader.content.addEventListener("onReady", onPlayerReady);
			this.playerLoader.content.addEventListener("onError", onPlayerError);
			this.playerLoader.content.addEventListener("onStateChange", onPlayerStateChange);
			this.playerLoader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		} catch (err:Error) {
			trace(this.className+'.connect_playerLoader_content_handlers().ERROR.1 error='+err.toString());
		}
	}

    private function playerLoaderInitHandler(event:Event):void {
		var _this:AS3Player = this;
		addChild(this.playerLoader);
		this.callLater(this.connect_playerLoader_content_handlers);
		this.playerLoader.addEventListener(FlexEvent.CREATION_COMPLETE, 
			function (event:FlexEvent):void {
				var f:Number = _this.gui_floor;
				_this.playerLoader.x = 0;
				_this.playerLoader.y = ((f > 0) ? f + 30 : 0);
				_this.playerLoader.width = _this.width;
				_this.playerLoader.height = _this.height;
			}
		);
    }

    private function setupYouTubeApiLoader():void {
      this._youtubeApiLoader_ = new URLLoader();
      this.youtubeApiLoader.addEventListener(IOErrorEvent.IO_ERROR, youtubeApiLoaderErrorHandler);
      this.youtubeApiLoader.addEventListener(Event.COMPLETE, youtubeApiLoaderCompleteHandler);
    }

    private function youtubeApiLoaderCompleteHandler(event:Event):void {
      var atomData:String = this.youtubeApiLoader.data;

      // Parse the YouTube API XML response and get the value of the
      // aspectRatio element.
      var atomXml:XML = new XML(atomData);
      var aspectRatios:XMLList = atomXml..*::aspectRatio;

      this._isWidescreen_ = aspectRatios.toString() == WIDESCREEN_ASPECT_RATIO;

      this._isQualityPopulated_ = false;
      // Cue up the video once we know whether it's widescreen.
      // Alternatively, you could start playing instead of cueing with
      // player.loadVideoById(videoIdTextInput.text);
	  if (this.player) {
		  this.player.cueVideoById(this.videoIdTextInput.text);
	  }
    }

    private function qualityComboBoxChangeHandler(event:Event):void {
      var qualityLevel:String = ComboBox(event.target).selectedItem['label']; // ???
      this.player.setPlaybackQuality(qualityLevel);
    }

	public function cue_a_video_url(url:String):void {
		if ( (url is String) && (url.length > 0) ) {
			var request:URLRequest = new URLRequest(url);
			
			var urlVariables:URLVariables = new URLVariables();
			urlVariables.v = YOUTUBE_API_VERSION;
			urlVariables.format = YOUTUBE_API_FORMAT;
			request.data = urlVariables;
			
			try {
				this.youtubeApiLoader.load(request);
			} catch (error:SecurityError) {
				trace("A SecurityError occurred while loading", request.url);
			}
		}
	}
	
	public function cue_a_video(video_id:String):void {
		this.cue_a_video_url(YOUTUBE_API_PREFIX + video_id);
		this.videoIdTextInput.text = video_id;
	}
	
    private function cueButtonClickHandler(event:MouseEvent):void {
		this.cue_a_video(this.videoIdTextInput.text);
    }

    private function playButtonClickHandler(event:MouseEvent):void {
      this.player.playVideo();
    }

    private function pauseButtonClickHandler(event:MouseEvent):void {
      this.player.pauseVideo();
    }

    private function youtubeApiLoaderErrorHandler(event:IOErrorEvent):void {
      trace("Error making YouTube API request:", event);
    }

    private function onPlayerReady(event:Event):void {
      this._player_ = this.playerLoader.content;
      this.player.visible = false;

      this.cueButton.enabled = true;
	  this.player.cueVideoById(this.videoIdTextInput.text);
    }

    private function onPlayerError(event:Event):void {
      trace("Player error:", Object(event).data);
    }

    private function onPlayerStateChange(event:Event):void {
      trace("State is", Object(event).data);

      switch (Object(event).data) {
        case STATE_ENDED:
          this.playButton.enabled = true;
          this.pauseButton.enabled = false;
          break;

        case STATE_PLAYING:
          this.playButton.enabled = false;
          this.pauseButton.enabled = true;

          if(!this.isQualityPopulated) {
            populateQualityComboBox();
          }
          break;

        case STATE_PAUSED:
          this.playButton.enabled = true;
          this.pauseButton.enabled = false;
          break;

        case STATE_CUED:
          this.playButton.enabled = true;
          this.pauseButton.enabled = false;

          resizePlayer("medium");
          break;
      }
    }

    private function onVideoPlaybackQualityChange(event:Event):void {
      trace("Current video quality:", Object(event).data);
      resizePlayer(Object(event).data);
    }

    private function resizePlayer(qualityLevel:String):void {
      var newWidth:Number = QUALITY_TO_PLAYER_WIDTH[qualityLevel] || 640;
      var newHeight:Number;

      if (this.isWidescreen) {
        // Widescreen videos (usually) fit into a 16:9 player.
        newHeight = newWidth * 9 / 16;
      } else {
        // Non-widescreen videos fit into a 4:3 player.
        newHeight = newWidth * 3 / 4;
      }

      trace("isWidescreen is", this.isWidescreen, ". Size:", newWidth, newHeight);
      this.player.setSize(newWidth, newHeight);

      this.player.visible = true;
    }

    private function populateQualityComboBox():void {
      this._isQualityPopulated_ = true;

      var qualities:Array = this.player.getAvailableQualityLevels();
      this.qualityComboBox.dataProvider = ArrayCollection(qualities);

      var currentQuality:String = this.player.getPlaybackQuality();
      this.qualityComboBox.selectedItem = currentQuality;
    }
  }
}