package libs.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.*;
	import flash.net.LocalConnection;
	import flash.utils.*;
	
	import libs.vo.GlobalsVO;
	
	import mxml.Menu;
	
	
	public class JSInterface extends EventDispatcher
	{
		
        private var conn:LocalConnection;
		private var callJSID:int = -1;
		private var _currentKey:Object;
		
		private const SPEED:int = 1;
		private const LIMIT:int = 3;
		
		
		public function JSInterface() {
		}
		
		
		
		private var _maxHeight:Number=0;					// To keep the last known max height for the DIV
		
		/**
		 * Call the external JS container
		 * and set the DIV height 
		 * @param target - An abstract var that can
		 * determine if you are targeting a specific
		 * component or if the menthod is being passed
		 * a number to determine the new size height
		 * of the application.
		 */
		 		
		public function setExternalContainerHeight(target:*=null):void {
			
			// To manually set the DIV to a value from target
			if(target is Number) _maxHeight = target;
			
			/* If the target is a menu, then get
			 * the menu's y position and height
			 * to set the new height */
			if(target is Menu) {
				var h:Number = target.y + target.height;
				if(h>=_maxHeight) _maxHeight = h;
			}
			
			// Call the JS container and update the new height
			loopMessage(_maxHeight);		
		}
		
		
		
		
		
		/**
		 * The external interface call to adjust
		 * the size of the DIV container may not
		 * resize on the first try.  The loop
		 * will tell the JS container to resize
		 * more then once to insure that the
		 * message is sent
		 * @param value:Number - New application height
		 */
		 		
		private function loopMessage(value:Number):void {
			clearInterval(callJSID);
			var _this:Object = this;
			var cnt:Number = 0;		
				
			var f:Function = function():void {
//				cnt++<LIMIT ? ExternalInterface.call(GlobalsVO.TOJS, Math.round(value)) :
//							  clearInterval(callJSID);
			}
			
			// Loop to send the message X times
			callJSID = setInterval(f,SPEED);
		}
		
		
		
		
		/**
		 * Call external interface to
		 * JS function "from
		 * JS function will need to provide a
		 * dynamic DIV creation with a Button
		 * and the provided string in order
		 * for the external screen reader
		 * to announce.
		 */
		 
		public function talk(str:String):void {
			//ExternalInterface.call(GlobalsVO.TALK, str);
		}
		
		
		
		
		
		/**
		 * Send Javascript status messages 
		 * @param value
		 */
		 		
		public function flexStatus(value:String):void {
			
			if(ExternalInterface.available) {
				//ExternalInterface.call(GlobalsVO.FLEXSTATUS, value);
			}
		}
		
		
		
		
		public function flexReady(value:String):void {
			//ExternalInterface.call(GlobalsVO.FLEXREADY, value);
		}
		
		
		
		
		public function toFlex(value:*):* {
			if(value == "ping") {
				flexReady("pong");
			}
			return 1;
		}
		
		
		
		
		
		/**
		 * Tell JS that 
		 */
		 
		public function tabOut():void {
			//ExternalInterface.call(GlobalsVO.TABOUT, null);
		}
		
		
		
		
		
		/**
		 * Get the current JS key selected
		 * value from this class.  This
		 * is used with the eventListener
		 * for the class that needs to know about
		 * the keyboard commands from JS 
		 * @return 
		 */
		 		
		public function get currentKey():Object {
			return _currentKey;
		}
		
		
		/**
		 * Called from JS that is used
		 * for the menu navigation by keyboard 
		 * @param keyCode
		 * @param isShift
		 */
		 	
		public function keyboard(keyCode:*, isShift:*):void {
			_currentKey = {keyCode:keyCode, isShift:isShift};
			this.dispatchEvent(new Event(GlobalsVO.JSKEYBOARD));
		}
	}
}