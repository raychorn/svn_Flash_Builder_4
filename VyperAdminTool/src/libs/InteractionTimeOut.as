/*
 * Class: InteractionTimeOut
 * @author Ryan C. Knaggs
 * @date 01/18/2010
 */


package libs
{
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.*;
	
	
	public class InteractionTimeOut
	{
		
		private var _timer:Timer;
		private var _duration:int;
		private var _callBack:Function;
		
		
		
		public function InteractionTimeOut(duration:int, callBack:Function) {
			this._duration = duration;
			this._callBack = callBack;
		}
		
		private function debug_wrapper(e:*):void {
			if (this._callBack is Function) {
				try {
					this._callBack(e);
				} catch (e:Error) {}
			}
		}
		
		public function setTimeOut(e:MouseEvent):void {
			var _this:Object = this;
			
			if(e.type == MouseEvent.MOUSE_OVER) {
				try {
					_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _callBack);
					_timer.stop();
				} catch(e:Error) {}
			}
			if(e.type == MouseEvent.MOUSE_OUT) {
				_timer = new Timer(_duration,1);
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.debug_wrapper);
				_timer.start();
			}
		}
		
		
		
		public function reset():void {
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _callBack);
			_timer.stop();
		}
	}
}