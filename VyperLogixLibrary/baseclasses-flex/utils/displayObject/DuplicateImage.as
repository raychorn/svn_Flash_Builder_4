package utils.displayObject
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import mx.controls.Image;
	
	public class DuplicateImage
	{
		private static var missingImage:*;
		private static var ERROR401:String = '';
		
		public function DuplicateImage()
		{
		}
		
		public static function validate(asset:*,classRef:*):Object {
			if(asset == null || asset == undefined) {
				asset = new Object();
				asset.error = DuplicateImage.ERROR401+" for Class: "+classRef.name;
				asset.image = buildDefaultImage();
			}
			return asset;
		}
		
		public static function buildDefaultImage():Image {
			var i:Image = new Image();
			i.source = DuplicateImage.missingImage;
			return i;
		}
		
		/**
		 * Duplicate the image
		 * You need to duplicate the graphics when
		 * you access and reference the GlobalsVO
		 * graphics
		 * @param source:Image - The image source
		 * from the GlobalsVO that you want to duplicate
		 * @return Image - New duplicated image
		 */
		 
		public static function copy(myimage:*, scale:Boolean, ratio:Boolean):Image {
			
			/* If the calling class for the image
			 * can't get reference of the CSS image name
			 * send back a default image */
			if(myimage.content == null) {
				return buildDefaultImage();
			}
			
			var data:BitmapData;
			var i:Image = new Image();
			// Try to process the graphics
			try {
			// If the image is broken
	        	if(myimage.content.toString().toLowerCase().indexOf("brokenimage") > -1) {
	        		i.source = DuplicateImage.missingImage;
	        	} else {
	        		// Otherwise, copy the preloaded image
	        		data = Bitmap(myimage.content).bitmapData;
		            var bitmap:Bitmap = new Bitmap(data);
		            i.source = bitmap;
		            i.scaleContent = scale;
		            i.maintainAspectRatio = ratio;
		        }
		        // Catch if the bandwidth is low
			} catch(e:Error) {
				i.source = DuplicateImage.missingImage;
			}
 			return i;
        }
        
        public static function copyToBitmap(source:Image):Bitmap {
        	try {
        		var data:BitmapData = Bitmap(source.content).bitmapData;
            	var bitmap:Bitmap = new Bitmap(data);
	    		return bitmap;
        	} catch(e:Error) {
        		return null;
        	}
        	
        	return bitmap;
        }
	}
}