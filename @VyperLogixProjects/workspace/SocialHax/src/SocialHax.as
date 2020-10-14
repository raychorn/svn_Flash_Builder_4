package {
	import com.CapabilitiesUtils;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.system.Capabilities;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import mx.core.FlexGlobals;
	
	import views.*;
	
	[SWF(frameRate="24", backgroundColor="#CCCCCC")]

	public class SocialHax extends Sprite {
		private var newStyle:StyleSheet = new StyleSheet();
		private var fullScreenWidth:uint;
		private var fullScreenHeight:uint;
		
		private var txt_output:TextField;
		
//		[Embed(source="NeoSansIntelLight.ttf", fontFamily="NeoSansIntelLight", embedAsCFF="false", mimeType="application/x-font")]
//		private var NeoSansIntelLightClass:Class;
//		
//		[Embed(source="VenusRising.ttf", fontFamily="VenusRising", embedAsCFF="true", mimeType="application/x-font")]
//		private var VenusRisingClass:Class;
		
		public function SocialHax() {
			var _this:SocialHax = this;
			
			this.x = 0;
			this.y = 0;
			
			var app:NativeApplication = NativeApplication.nativeApplication;
			var windows:Array = app.openedWindows;
			
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			
			this.addEventListener(Event.ADDED_TO_STAGE, this._onAddedToStage);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, 
				function (event:KeyboardEvent):void {
					if (event.keyCode == Keyboard.BACK) {
						event.preventDefault();
						_this.output_text = 'Back Pressed !';
						app.exit();
					} else if (event.keyCode == Keyboard.MENU) {
						event.preventDefault();
						_this.output_text = 'Menu Pressed !';
					} else if (event.keyCode == Keyboard.SEARCH) {
						event.preventDefault();
						_this.output_text = 'Search Pressed !';
					}
				}
			);
		}
		
		private function set output_text(output_text:String):void {
			this.txt_output.htmlText = "<body><span class='label3'>"+output_text+"</span></body>";
		}
		
		private function _onStage_OrientationChange(event:StageOrientationEvent):void {
			switch (event.afterOrientation) {
				case StageOrientation.DEFAULT:
					this.output_text = 'Default orientation.';
					break;
				case StageOrientation.ROTATED_RIGHT:
					this.output_text = 'Rotated right.';
					break;
				case StageOrientation.ROTATED_LEFT:
					this.output_text = 'Rotated left.';
					break;
				case StageOrientation.UPSIDE_DOWN:
					this.output_text = 'Upside down.';
					break;
				case StageOrientation.UNKNOWN:
					this.output_text = 'Unknown.';
					break;
			}
		}

		private function _onAddedToStage(event:Event):void {
			var _this:SocialHax = this;
			
			this.fullScreenWidth = stage.fullScreenWidth;
			this.fullScreenHeight = stage.fullScreenHeight;

			var textField1:TextField = new TextField();
			
			var styleObj1:Object = {
				fontWeight: "bold",
				color: "#ff0000",
				fontFamily: 'Arial Black',
				fontSize: 30
			};
			
			var styleObj2:Object = {
				fontWeight: "bold",
				color: "#0000ff",
				fontFamily: 'Arial Black',
				fontSize: 30
			};
			
			var styleObj3:Object = {
				fontWeight: "normal",
				color: "#000000",
				fontFamily: 'Arial Black',
				fontSize: 20
			};
			
			var styleObj4:Object = {
				fontWeight: "normal",
				color: "#000000",
				fontFamily: 'Arial',
				fontSize: 22
			};
			
			this.newStyle.setStyle('.label1',styleObj1);
			this.newStyle.setStyle('.label2',styleObj2);
			this.newStyle.setStyle('.label3',styleObj3);
			this.newStyle.setStyle('.label4',styleObj4);
			
			textField1.styleSheet = this.newStyle;
			
			textField1.x = 5;
			textField1.y = 0;
			textField1.htmlText = "<body><span class='label1'>Hello</span> <span class='label2'>World...</span></body>";
			textField1.width = this.fullScreenWidth-textField1.x-textField1.x;
			textField1.height = 40;
			textField1.border = true;
			
			var textField2:TextField = new TextField();
			textField2.x = 5;
			textField2.y = textField1.y+textField1.height+5;
			textField2.styleSheet = this.newStyle;
			textField2.htmlText = "<body><span class='label3'>fullScreenWidth="+this.fullScreenWidth+"</body>";
			textField2.width = this.fullScreenWidth-textField2.x-textField2.x;
			textField2.height = 30;
			textField2.border = true;
			
			var textField3:TextField = new TextField();
			textField3.x = 5;
			textField3.y = textField2.y+textField2.height+5;
			textField3.styleSheet = this.newStyle;
			textField3.htmlText = "<body><span class='label3'>fullScreenHeight="+this.fullScreenHeight+"</span></body>";
			textField3.width = this.fullScreenWidth-textField3.x-textField3.x;
			textField3.height = 30;
			textField3.border = true;
			
			var textField4:TextField = new TextField();
			textField4.x = 5;
			textField4.y = textField3.y+textField3.height+5;
			textField4.styleSheet = this.newStyle;
			textField4.htmlText = '';
			textField4.width = this.fullScreenWidth-textField4.x-textField4.x;
			textField4.height = 30;
			textField4.border = true;
			textField4.addEventListener(Event.ADDED_TO_STAGE, 
				function (event:Event):void {
					_this.txt_output = event.currentTarget as TextField;
				}
			);
			
			var textField5:TextField = new TextField();
			textField5.x = 5;
			textField5.y = textField4.y+textField4.height+5;
//			var textFormat5:TextFormat = new TextFormat();
//			textFormat5.size = 20;
//			textFormat5.bold = true;
//			textFormat5.color = 0x0000ff;
//			textFormat5.font = 'VenusRising';
//			textField5.defaultTextFormat = textFormat5;
			textField5.border = true;
			textField5.width = this.fullScreenWidth-textField5.x-textField5.x;
			textField5.height = 30;
			textField5.styleSheet = this.newStyle;
//			textField5.text = 'This is a test...';
			textField5.htmlText = "<body><span class='label4'>This is a test...</span></body>";
//			textField5.type = TextFieldType.DYNAMIC;
			
			var textField6_htmlText:String = "<body><span class='label4'>autoOrients="+this.stage.autoOrients+"</span></body>";
			
			var textField6:TextField = new TextField();
			textField6.x = 5;
			textField6.y = textField5.y+textField5.height+5;
			textField6.styleSheet = this.newStyle;
			textField6.htmlText = textField6_htmlText;
			textField6.width = this.fullScreenWidth-textField6.x-textField6.x;
			textField6.height = 30;
			textField6.border = true;

			var textField7_htmlText:String = "<body><span class='label4'>deviceOrientation={{deviceOrientation}}</span></body>";

			var textField7:TextField = new TextField();
			textField7.x = 5;
			textField7.y = textField6.y+textField6.height+5;
			textField7.styleSheet = this.newStyle;
			textField7.htmlText = '';
			textField7.width = this.fullScreenWidth-textField7.x-textField7.x;
			textField7.height = 30;
			textField7.border = true;
			
			var button1:Button = new Button();
			button1.x = 5;
			button1.y = textField7.y+textField7.height+10;
			button1.label = 'Click Me !';
			button1.width = this.fullScreenWidth-button1.x;
			button1.addEventListener(MouseEvent.CLICK, 
				function (event:MouseEvent):void {
					_this.output_text = 'Button1 Clicked !';
				}
			);
			
			if(this.stage.autoOrients) {
				this.stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, _onStage_OrientationChange);
				textField7.htmlText = textField7_htmlText.replace('{{deviceOrientation}}',this.stage.deviceOrientation);
			} else {
				textField7.htmlText = textField7_htmlText.replace('{{deviceOrientation}}',this.stage.deviceOrientation);
			}
			
			this.addChild(textField1);
			this.addChild(textField2);
			this.addChild(textField3);
			this.addChild(textField4);
			this.addChild(textField5);
			this.addChild(button1);
			this.addChild(textField6);
			this.addChild(textField7);
			
			this.graphics.lineStyle(1,0xff0000);
			this.graphics.drawRect(0,0,this.fullScreenWidth,this.fullScreenHeight);
		}
	}
}
