package controls.timers {
	public class TimerProxy {
		private var __data__:*;
		
		/*
		target is a pointer to the object that tracks the actual timer.
		*/
		public function TimerProxy() {
		}
		
		public function get data():* {
			return this.__data__;
		}
		
		public function set data(data:*):void {
			if (this.__data__ != data) {
				this.__data__ = data;
			}
		}
		
		public function get target():* {
			return ( (this.__data__) && (this.__data__['target']) );
		}
		
		public function get aspect():String {
			return ( (this.__data__) && (this.__data__['aspect']) );
		}
		
		public function get running():Boolean {
			return ( (this.__data__) && (this.__data__['running']) );
		}
		
		/* dummy function */
		public function removeEventListener(name:String,handler:Function):void {
		}
		
		/* dummy function */
		public function addEventListener(name:String,handler:Function):void {
		}
		
		public function stop():void {
			if (this.__data__) {
				this.__data__['running'] = false;
			}
		}
		
		public function start():void {
			if (this.__data__) {
				this.__data__['running'] = true;
			}
		}
	}
}