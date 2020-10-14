package com {
	import flash.system.Capabilities;
	
	import mx.core.FlexGlobals;

	public class DebuggerUtils {
		private static var output:*; 	 // this is the widget that receives the output...
		private static var aspect:String; // this is the aspect of the output that receives the output...
		private static var __use_default_trace__:Boolean = false;
		
		public static function start_tracer(output:*,aspect:String):void {
			DebuggerUtils.output = output;
			DebuggerUtils.aspect = aspect;
		}
		
		public static function get is_tracer():Boolean {
			return ( (DebuggerUtils.output) && (DebuggerUtils.aspect) );
		}

		public static function set __trace(message:String):void {
			if ( (FlexGlobals.topLevelApplication.appProxy) && (FlexGlobals.topLevelApplication.appProxy.txt_debugger) ) {
				FlexGlobals.topLevelApplication.appProxy.txt_debugger.text += message + '\n';
			} else if (!DebuggerUtils.__use_default_trace__) {
				DebuggerUtils.__use_default_trace__ = true;
				trace(DebuggerUtils.getCallingFunctionName(new Error())+'.'+message);
				//AlertPopUp.surpriseNoOkay('Cannot use that slick Debugging thing due to some kind of technical issue... Reverting to the built-in trace().','WARNING '+DebuggerUtils.getFunctionName(new Error()));
			} else {
				trace(DebuggerUtils.getCallingFunctionName(new Error())+'.'+message);
			}
		}
		
		public static function _trace(message:String):void {
			DebuggerUtils.__trace = message;
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
			try {
				var s:String = e.getStackTrace();
				var i:int = s.indexOf("at ");
				var j:int = s.indexOf("()");
				return s.substring(i + 3, j);
			} catch (err:Error) {}
			return '*** NO STACKTRACK AVAILABLE ***';
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