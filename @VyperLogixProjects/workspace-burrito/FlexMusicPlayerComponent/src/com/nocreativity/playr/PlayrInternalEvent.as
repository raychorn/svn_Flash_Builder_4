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
	import flash.events.Event;
	/**
	 * Used for interal error and event handling.
	 */
	public class PlayrInternalEvent extends Event{
		
		
		public static const DEBUG:String = "playr_debug";		
		public static const PLAYLIST_LOADED:String = "playlist_loaded";
		public static const PLAYLIST_TRACK_OUT_OF_BOUNDS:String="playlist_track_out_of_bounds";
		public static const PLAYLIST_STREAM_ERROR:String="playlist_stream_error";
		public static const PLAYLIST_INVALID_XML:String="playlist_invalid_xml";
		public static const TRACK_NOT_ADDED_TO_PLAYLIST:String="track_not_added_to_playlist";
		public static const TRACK_ADDED_TO_PLAYLIST:String="track_added_to_playlist";
		public static const TRACK_LOADING:String = "track_loading";
		public static const CURRENT_TRACK_TO_BE_REMOVED:String="current_track_to_be_removed";
		public function PlayrInternalEvent(type:String){
			super(type);
		}
		public var message:String = "";
	}
}