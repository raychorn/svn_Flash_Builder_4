/*

Copyright (c) 2009 Ronny Welter

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
 
*/

package com.nocreativity.playr{
	/**
	 * The PlayrTrack instance is a summary of basic information which reflect ID3 information. However Playr 2.0 doesn't use the ID3 at all. The primary way of getting that data is due the use of the XML playlist. <br/>
	 * The PlayrTrack class is primary used for playlist manipulation.
	 */
	public class PlayrTrack{
		public var title:String = "";
		public var artist:String = "";
		public var album:String = "";
		public var totalTime:String = "0:00";
		public var file:String="";
		public var trackNumber:Number=0;
		private var _totalSeconds:Number = 0;
		
		/**
		 * Constuctor: Builds a PlayrTrack instance.
		 */		 
		public function PlayrTrack(title:String=null,artist:String=null,album:String = null,file:String = null,trackNumber:Number = 0,totalSeconds:Number = 0):void{
			this.title = title;
			this.artist = artist;
			this.album = album;
			this.totalSeconds = totalSeconds;
			this.file = file;
			this.trackNumber = trackNumber;
			this.totalTime = ":"+totalSeconds;
		}
		
		/**
		 * Gets or sets the total seconds of the PlayrTrack.
		 */
		public function set totalSeconds(seconds:Number):void{
			_totalSeconds=seconds;
			var min:Number = (_totalSeconds - (_totalSeconds%60))/60;
			var sec:Number = _totalSeconds%60;
			this.totalTime = min + ':';
			if(sec<10){
				this.totalTime += "0";
			}
			this.totalTime += sec;
		}
		public function get totalSeconds():Number{
			return _totalSeconds;	
		}
		/**
		 * Returns a string version of the track: {trackNumber}. {title} - {artist}
		 */
		public function toString():String{
			return this.trackNumber + ". " + this.title + " - " + this.artist;
		}
		/**
		 * Returns an indipendent copy of the given PlayrTrack instance (Primarly used for creating the shuffled playlist).
		 */
		public function copy():PlayrTrack{
			var copy:PlayrTrack = new PlayrTrack();
			copy.album = this.album;
			copy.artist = this.artist;
			copy.totalTime = this.totalTime;
			copy.totalSeconds = this.totalSeconds;
			copy.file = this.file;
			copy.title = this.title;
			copy.trackNumber = this.trackNumber;
			return copy;
		}
	}
}