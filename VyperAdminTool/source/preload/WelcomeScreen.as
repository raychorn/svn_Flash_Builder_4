package preload {
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.*;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	public class WelcomeScreen extends Loader {
		
		[Bindable]
		public static var hasLoaded:Boolean = false;
		
		[Bindable]
		public static var timeAutoClose:int = 1500;
		
		[Bindable]
		public static var waitForSignal:Boolean = false;
		
		[Embed(source="splash-image-VLC-03-25-2010.png", mimeType="application/octet-stream")]
		public var WelcomeGif:Class;
		
		public var timer:Timer;
		private var fadeInRate:Number  = 0.25;
		private var fadeOutRate:Number = 0.25;
		public var ready:Boolean = false; 
		
		public function WelcomeScreen() {
			this.visible = false;
			this.alpha = 0;
			timer = new Timer( 5 );
            timer.addEventListener( TimerEvent.TIMER, updateView );
			timer.start();

			this.loadBytes( new WelcomeGif() as ByteArray );
			this.addEventListener( MouseEvent.MOUSE_DOWN, mouseDown );			 
		}
		
		private function get canClose():Boolean {
			return (WelcomeScreen.waitForSignal) ? (WelcomeScreen.hasLoaded) : ((this.ready && timer.currentCount > WelcomeScreen.timeAutoClose) || (WelcomeScreen.hasLoaded));
		}
		
		public function updateView( event:TimerEvent ):void {
			if( this.alpha < 1)	this.alpha = this.alpha + this.fadeInRate;
			this.stage.addChild(this)
			this.x = this.stage.stageWidth/2 - this.width/2
			this.y = this.stage.stageHeight/2 - this.height/2
			this.visible=true;
			if (this.canClose) {
				closeScreen();
			}	
		}
		
		public function closeScreen():void {
            timer.removeEventListener( TimerEvent.TIMER, updateView );
			timer.removeEventListener( MouseEvent.MOUSE_DOWN, mouseDown);
			timer.addEventListener( TimerEvent.TIMER, closeScreenFade );					
		}
		
		public function closeScreenFade( event:TimerEvent ):void {
			if (this.alpha > 0) {
				this.alpha = this.alpha - fadeOutRate;
			} else {
				timer.stop()
				this.parent.removeChild(this);
			}
		}		
		
		public function mouseDown( event:MouseEvent ):void {
			if (this.canClose) {
				closeScreen();
			}	
		}
				
	}
}