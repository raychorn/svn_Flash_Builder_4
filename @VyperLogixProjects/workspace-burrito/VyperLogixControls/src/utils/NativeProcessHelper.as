package utils {
	import controls.Alert.AlertPopUp;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	
	import mx.core.FlexGlobals;

	public class NativeProcessHelper {
		public static function launchProcess(fname:String):void {
			execute(new NativeProcess(),fname);
		}

		private static function execute(process:NativeProcess, arg:String):void {
			var startProcess:NativeProcess;
			var exe:File = new File(arg);
			
			try {
				var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
				nativeProcessStartupInfo.executable = exe;
				nativeProcessStartupInfo.workingDirectory = new File();
				var processArgs:Vector.<String> = new Vector.<String>();
				nativeProcessStartupInfo.arguments = processArgs;
				startProcess = new NativeProcess();
				startProcess.start(nativeProcessStartupInfo);
				startProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, function (event:ProgressEvent):void {});
				startProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, function (event:ProgressEvent):void {});
			}
			catch (e:Error) {
				if (e.errorID == 3219) {
					AlertPopUp.surpriseNoOkay('Cannot launch the software you selected.  Please remain patient, this feature is under developed and may not work at this time.','WARNING');
				} else if (FlexGlobals.topLevelApplication.is_debugging) {
					AlertPopUp.surpriseNoOkay(e.message+'\n'+e.getStackTrace(),'Error');
				} else {
					AlertPopUp.surpriseNoOkay(e.message,'Error');
				}
			}
		}
	}
}