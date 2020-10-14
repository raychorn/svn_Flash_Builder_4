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
	 * Defines that states in which the Playr instance can be residing.
	 */
	public class PlayrStates{		
		/**
		 * The music is playing.
		 */
		public static const PLAYING:String="playing";
		/**
		 * The music is paused.
		 */
		public static const PAUSED:String="pause";
		/**
		 * The music has stopped playing.
		 */
		public static const STOPPED:String="stopped";
		/**
		 * The music is buffering.
		 */
		public static const BUFFERING:String="buffering";
		/**
		 * The Playr instance is initializing.
		 */
		public static const INIT:String="init";
		/**
		 * The Playr instance is loading a playlist file.
		 */
		public static const LOADING_PLAYLIST:String="loading_playlist";
		/**
		 * The Playr instance is initialized and is ready to take over the heavy lifting.
		 */
		public static const READY:String="ready";
		/**
		 * The Playr instance is waiting for internal process to complete.
		 */
		public static const WAITING:String="waiting";
	}
}