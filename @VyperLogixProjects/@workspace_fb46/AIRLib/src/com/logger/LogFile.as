package com.logger {
	import com.DateUtils;
	import com.StringUtils;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	
	import controls.popups.PopUpWindow;
	
	import vyperlogix.FileIO.serializer.FileWriter;
	
	public class LogFile {
		public var logFile:File;
		private var aFileStream:FileStream;
		
		private var __target__:PopUpWindow;
		
		public var selector:String;
		
		public static var LOGPATH:String = 'logs';
		
		private static var __cache__:* = {};
		
		private var __use_static_filename__:Boolean = true;

		private var __delete_files__:Boolean = false;
		
		public function LogFile(pathName:String,window:PopUpWindow=null) {
			this.__target__ = window;
			if (pathName) {
				var folder:File = new File(pathName+File.separator+LOGPATH);
				if (!folder.exists) {
					folder.createDirectory();
				} else if (delete_files) {
					folder.deleteDirectory(true);
					folder.createDirectory();
				}
			}
		}
		
		public function set delete_files(delete_files:Boolean):void {
			if (this.__delete_files__ != delete_files) {
				this.__delete_files__ = delete_files;
			}
		}
		
		public function get delete_files():Boolean {
			return this.__delete_files__;
		}
		
		public function get use_static_filename():Boolean {
			return this.__use_static_filename__;
		}
		
		public function set use_static_filename(value:Boolean):void {
			if (this.__use_static_filename__ != value) {
				this.__use_static_filename__ = value;
			}
		}
		
		public function get target():PopUpWindow {
			return this.__target__;
		}
		
		public function write_to_file(pathName:String,msgs:*,closeHandler:Function=null,doneHandler:Function=null,errorHandler:Function=null):void {
			try {
				var folder:File = new File(pathName+File.separator+LOGPATH);
				var dt:String = StringUtils.replaceAll(StringUtils.replaceAll(DateUtils.toShortUTCDateString(new Date()),' ','_'),':','');
				var fname:String = __cache__['fname'];
				var __fname:String = folder.nativePath+File.separator+dt+'.log';
				if (this.use_static_filename) {
					if (fname == null) {
						__cache__['fname'] = __fname;
					}
					fname = __cache__['fname'];
				} else {
					fname = __fname;
				}
				//delete __cache__['fname'];
				this.logFile = new File(fname);
				var aFileStream:FileStream = FileWriter.createSync(this.logFile.nativePath,null,true);
				if (closeHandler is Function) {
					aFileStream.addEventListener(Event.CLOSE, closeHandler);
				}
				if (aFileStream is FileStream) {
					var i:int;
					if (msgs is Array) {
						for (i=0; i < msgs.length; i++) {
							aFileStream.writeMultiByte(DateUtils.toShortUTCDateString(new Date())+' --> '+((this.selector is String) ? msgs[i][this.selector] : msgs[i])+'\r\n', "iso-8859-1");
						}
					} else if (msgs is ArrayCollection) {
						for (i=0; i < msgs.length; i++) {
							aFileStream.writeMultiByte(DateUtils.toShortUTCDateString(new Date())+' --> '+((this.selector is String) ? msgs.getItemAt(i)[this.selector] : msgs.getItemAt(i))+'\r\n', "iso-8859-1");
						}
					} else if (msgs is String) {
						aFileStream.writeMultiByte(DateUtils.toShortUTCDateString(new Date())+' --> '+msgs+'\r\n', "iso-8859-1");
					}
					aFileStream.close();
					if (doneHandler is Function) {
						doneHandler();
					}
				}
			} catch (err:Error) {
				if (errorHandler is Function) {
					errorHandler(err);
				}
			}
		}

		public function write(msg:String):void {
			if (this.__target__ is PopUpWindow) {
				this.__target__.text = DateUtils.toShortUTCDateString(new Date())+' --> '+msg;
			}
		}
	}
}