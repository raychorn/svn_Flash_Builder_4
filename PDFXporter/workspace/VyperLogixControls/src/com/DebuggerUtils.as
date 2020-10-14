package com {
	import flash.system.Capabilities;

	public class DebuggerUtils {
		public static function get isDebugging():Boolean {
			return Capabilities.isDebugger;
		}
		
		public static function explainThis(obj:Object):String {
			var ex:ObjectExplainer = new ObjectExplainer(obj);
			return ex.explainThisWay();
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