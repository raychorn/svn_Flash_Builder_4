package menu.builder {
	import com.libs.utils.FilterURL;
	
	import mx.controls.Image;
	
	import utils.displayObject.DuplicateImage;
	import utils.displayObject.imgLoader;
	import utils.strings.URLUtils;
	
	public class UserProfile {
		[Bindable]
		public static var company_name:String = 'Vyper Logix';

		private static var _image_logoAsset:String = "./static/images/Logo.gif";
		
		private static var _img_override:String = '';
			
		public static function get_image_logoAsset(container:*,callback:Function):void {
			function onImageLoaded_handler(image:*):void {
				var img:Image = DuplicateImage.copy(image.image,true,true);
				if (callback is Function) {
					callback(img);
				}
			}
			var imgSource:String = URLUtils.domain(UserProfile._image_logoAsset);
			var isDomain:Boolean = ((imgSource is String) && (imgSource.length > 0) && (imgSource.indexOf('://') > -1));
			if (!isDomain) {
				var s:String = UserProfile._img_override;
				s = URLUtils.domain_with_port_and_protocol(s);
				imgSource = FilterURL.filter(s,UserProfile._image_logoAsset);
			}
			var loader:imgLoader = new imgLoader(imgSource,container,onImageLoaded_handler);
		}

		public static function set_img_override(img_override:String):void {
			UserProfile._img_override = img_override;
		}
	}
}