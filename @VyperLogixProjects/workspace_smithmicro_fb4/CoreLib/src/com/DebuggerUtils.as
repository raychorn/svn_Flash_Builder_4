package com {
	import flash.system.Capabilities;
	
	public class DebuggerUtils {
		private static var output:*; 	 // this is the widget that receives the output...
		private static var aspect:String; // this is the aspect of the output that receives the output...
		
		public static function start_tracer(output:*,aspect:String):void {
			DebuggerUtils.output = output;
			DebuggerUtils.aspect = aspect;
		}
		
		public static function get is_tracer():Boolean {
			return ( (DebuggerUtils.output) && (DebuggerUtils.aspect) );
		}
		
		public static function tracer(message:String):void {
			try {
				if (DebuggerUtils.is_tracer) {
					DebuggerUtils.output[DebuggerUtils.aspect] = message + DebuggerUtils.output[DebuggerUtils.aspect];
				}
			} catch (err:Error) {}
		}
		
		public static function stop_tracer():void {
			DebuggerUtils.output = null;
			DebuggerUtils.aspect = null;
		}
		
		public static function get isDebugging():Boolean {
			return Capabilities.isDebugger;
		}
		
		public static function explainThis(obj:Object,sep:String = ", ", pre:String = "(", post:String = ")"):String {
			var ex:ObjectExplainer = new ObjectExplainer(obj);
			return ex.explainThisWay(sep,pre,post);
		}
		
		public static function assert(condition:Boolean, warning:String):int {
			DebuggerUtils.isDebugging {
				if (!condition) {
					trace("ERROR: " + warning);
					// throw if the bit is set
					throw(new Error(DebuggerUtils.getFunctionName(new Error())+"::Assert: " + warning));
					return 1;
				}
			}
			return 0;
		}

		public static function getFunctionName(e:Error):String {
			var s:String = e.getStackTrace();
			var i:int = s.indexOf("at ");
			var j:int = s.indexOf("()");
			return s.substring(i + 3, j);
		}
		
		public static function getCallingFunctionName(e:Error):String {
			var s:String = e.getStackTrace();
			var i:int = s.indexOf("at ");
			i = s.indexOf("at ", i + 3);
			if (i == -1) {
				return "caller unknown";
			}
			
			var j:int = s.indexOf("()", i + 3);
			return s.substring(i + 3, j);
		}
		
		public static function doSomething():void {
			trace(getFunctionName(new Error()));
			DebuggerUtils.doit();
		}
		
		public static function doSomethingElse():void
		{
			trace(getFunctionName(new Error()));
			DebuggerUtils.doit();
		}
		
		public static function doit():void {
			trace(getFunctionName(new Error()));
			trace("   called by", getCallingFunctionName(new Error()));
		}
	}
}