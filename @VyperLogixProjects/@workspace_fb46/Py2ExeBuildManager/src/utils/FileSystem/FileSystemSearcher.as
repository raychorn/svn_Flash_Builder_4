package utils.FileSystem {
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	
	import controls.navigators.EventViewer;
	
	public class FileSystemSearcher {
		private var __top__:String;
		
		private var __parent__:*;
		
		private var stack:Array = [];
		
		private var __files__:Array;
		private var __i__:int;

		private var __num_files__:int;
		private var __num_folders__:int;
		
		private var __file__:File = new File();
		
		private var __events__:EventViewer;
		
		public function FileSystemSearcher(top:String,parent:*=null,events:EventViewer=null) {
			this.__top__ = top;
			this.__events__ = events;
			this.__parent__ = parent;
			this.__num_files__ = 0;
			this.__num_folders__ = 0;
			this.__events__.handle_event = '(1) (+++)';
			this.__file__.addEventListener(FileListEvent.DIRECTORY_LISTING, 
				function (event:FileListEvent):void {
					var i:int;
					this.__events__.handle_event = event.toString()+'::(1) BEGIN:';
					for (i = 0; i < event.files.length; i++) {
						this.__events__.handle_event = event.files[i];
					}
					this.__events__.handle_event = event.toString()+'::(2)  END !!!';
				}
			);
			this.__file__.addEventListener(Event.CANCEL, 
				function (event:FileListEvent):void {
					this.__events__.handle_event = event.toString()+'::(1)  !!!';
				}
			);
			this.__file__.addEventListener(Event.COMPLETE, 
				function (event:FileListEvent):void {
					this.__events__.handle_event = event.toString()+'::(1)  !!!';
				}
			);
			this.__file__.addEventListener(IOErrorEvent.IO_ERROR, 
				function (event:FileListEvent):void {
					this.__events__.handle_event = event.toString()+'::(1)  !!!';
				}
			);
			this.__file__.addEventListener(SecurityErrorEvent.SECURITY_ERROR, 
				function (event:FileListEvent):void {
					this.__events__.handle_event = event.toString()+'::(1)  !!!';
				}
			);
			this.__file__.addEventListener(Event.SELECT, 
				function (event:FileListEvent):void {
					this.__events__.handle_event = event.toString()+'::(1)  !!!';
				}
			);
			this.__file__.addEventListener(FileListEvent.SELECT_MULTIPLE, 
				function (event:FileListEvent):void {
					this.__events__.handle_event = event.toString()+'::(1)  !!!';
				}
			);
		}
		
		public function get i():int {
			return this.__i__;
		}
		
		public function get num_files():int {
			return this.__num_files__;
		}
		
		public function get num_folders():int {
			return this.__num_folders__;
		}
		
		public function next():File {
			var file:File;
			if ( (this.__files__ == null) || (this.__files__.length == 0) ) {
				this.__events__.handle_event = 'next().(1) --> this.__top__='+this.__top__;
				this.__file__.nativePath = this.__top__;
				this.__files__ = this.__file__.getDirectoryListing();
				this.__i__ = 0;
				this.__events__.handle_event = 'next().(2) --> files.length='+this.__files__.length;
			} else {
				this.__i__++;
				if (this.__i__ >= this.__files__.length) {
					if (this.stack.length > 0) {
						file = this.stack.shift();
						this.__top__ = file.nativePath;
						this.__files__ = null;
						this.next();
					}
				}
				this.__events__.handle_event = 'next().(3) --> this.__top__='+this.__top__;
			}
			var response:File;
			if ( (this.__files__ is Array) && (this.__files__.length > 0) ) {
				response = this.__files__[this.__i__] as File;
				if (response.isDirectory) {
					this.stack.push(this.__file__);
					this.__num_folders__++;
				} else {
					this.__num_files__++;
				}
			}
			return response;
		}
	}
}