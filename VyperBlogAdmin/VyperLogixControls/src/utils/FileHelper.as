package utils {
	import controls.Alert.AlertPopUp;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class FileHelper {
		public static function selectSaveAsDestination(callback:Function):void {
			var desktop:File = File.desktopDirectory
			try {
				desktop.browseForDirectory("Select a directory");
				desktop.addEventListener(Event.SELECT, callback);
			} catch (err:Error) {
				AlertPopUp.surpriseNoOkay(err.message,'ERROR.FileHelper.1');
			}
		}

		public static function copyFile(fileOrig:File, fileDest:File, callback:Function):void {
			fileOrig.addEventListener(Event.COMPLETE, callback);
			
			if (!fileDest.exists) {
				fileOrig.copyToAsync(fileDest);
			}
			else {
				AlertPopUp.confirm("Are you sure you want to replace the existing file ?","Replace with new file ?", 
					function(event:CloseEvent):void {
						if (event.detail == Alert.YES) {
							fileOrig.copyToAsync(fileDest, true);
						}
						else {
							if (callback is Function) {
								try {
									callback(new Event(Event.COMPLETE));
								} catch (err:Error) {
									AlertPopUp.surpriseNoOkay(err.message,'ERROR.FileHelper.2');
								}
							}
						}
					} 
				);
			}
		}

		private static function deleteFile(aFile:File, callback:Function):void {
			AlertPopUp.confirm("Do you really want to delete this file ?","Delete Confirmation", 
				function(event:CloseEvent):void {
					if (event.detail==Alert.YES) {
						if (aFile.isDirectory) {
							aFile.deleteDirectory(false);
						} else {
							aFile.deleteFile();
						}
						if (callback is Function) {
							try {
								callback(new Event(Event.COMPLETE));
							} catch (err:Error) {
								AlertPopUp.surpriseNoOkay(err.message,'ERROR.FileHelper.3');
							}
						}
					}
				} 
			);
		}
		
		public static function moveFile(fileOrig:File, fileDest:File, callback:Function):void {
			fileOrig.addEventListener(Event.COMPLETE, callback);
			if (!fileDest.exists) {
				fileOrig.moveToAsync(fileDest);
			}
			else {
				AlertPopUp.confirm("Are you sure you want to replace the existing file ?","Replace with new file ?", 
					function(event:CloseEvent):void {
						if (event.detail== Alert.YES) {
							fileOrig.moveToAsync(fileDest, true);
						}
						else {
							if (callback is Function) {
								try {
									callback(new Event(Event.COMPLETE));
								} catch (err:Error) {
									AlertPopUp.surpriseNoOkay(err.message,'ERROR.FileHelper.4');
								}
							}
						}
					} 
				);
			}
			
		}		
	}
}