package utils {
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;

	public class MediaHelper {
		private static var sound:Sound;
		private static var channel:SoundChannel;
		public static var is_playing_media:Boolean = false;
		private static var pausePos:int = 0;

		public static function is_image(fname:String):Boolean {
			var i:int = fname.toLowerCase().indexOf('.png');
			var j:int = fname.toLowerCase().indexOf('.jpg');
			var k:int = fname.toLowerCase().indexOf('.gif');
			var n:int = fname.length - 4;
			return ( (i == n) || (j == n) || (k == n) );
		}
		
		public static function is_video(fname:String):Boolean {
			var i:int = fname.toLowerCase().indexOf('.mp4');
			var n:int = fname.length - 4;
			return (i == n);
		}
		
		public static function is_sound(fname:String):Boolean {
			var i:int = fname.toLowerCase().indexOf('.mp3');
			var n:int = fname.length - 4;
			return (i == n);
		}
		
		private static function createSound(file:String):Sound {
			MediaHelper.sound = new Sound(new URLRequest(file));
			return MediaHelper.sound;
		}
		
		private static function playAudio(sound:Sound):void {
			MediaHelper.channel= sound.play();
		}
		
		public static function stopAudio():void {
			try {
				MediaHelper.pausePos = MediaHelper.channel.position;
				MediaHelper.channel.stop();
			} catch (err:Error) {}
		}
		
		public static function resumeAudio():void {
			MediaHelper.channel = MediaHelper.sound.play(pausePos);
		}
		
		public static function play_sound_file(play:String):Boolean {
			var fPlay:File = new File(play);
			if ( (fPlay.exists) && (!fPlay.isDirectory) ) {
				if (MediaHelper.is_sound(fPlay.nativePath)) {
					MediaHelper.playAudio(MediaHelper.createSound(fPlay.url));
					MediaHelper.is_playing_media = true;
					return MediaHelper.is_playing_media;
				}
			}
			MediaHelper.is_playing_media = false;
			return MediaHelper.is_playing_media;
		}
	}
}