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
	 * Dedicated error event class. The class won't be breaking your application which is a good thing. However you won't be notified by the ActionScript debugger when runtime errors occur (such as 'url not found') as they are caught and translated into harmless events.
	 */
	public class PlayrErrorEvent extends Event{
		
		
				
		public static const TRACK_OUT_OF_BOUNDS:String = "track_out_of_bounds";
		public static const PLAYLIST_STREAM_ERROR:String="playlist_stream_error";
		public static const SOUND_STREAM_ERROR:String="sound_stream_error";
		public static const PLAYLIST_INVALID_XML:String="playlist_invalid_xml";
		public static const TRACK_NOT_ADDED_TO_PLAYLIST:String="track_not_added_to_playlist";
		public static const NO_PLAYLIST_SELECTED:String="no_playlist_selected";
		public static const IO_ERROR:String = "io_error";
		
		
		public function PlayrErrorEvent(type:String){
			super(type,true);
		}
	}
}