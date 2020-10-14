package com {
	import flash.display.*;
	import flash.utils.ByteArray;
	
	import mx.controls.Image;
	import mx.graphics.ImageSnapshot;

	public class SnapshotDisplayObject {
		public function SnapshotDisplayObject() {
		}
		public function takeSnapshot(source:IBitmapDrawable):Image {
            var imageSnap:ImageSnapshot = ImageSnapshot.captureImage(source);
            var img:Image = new Image();
	        img.source = imageSnap.data as ByteArray;
            return img;
        }
	}
}