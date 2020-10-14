package libs.utils
{
	import mx.controls.Image;
	import libs.vo.GlobalsVO;
	import utils.displayObject.DuplicateImage;
	
	public class ValidateImage
	{
		
		public function ValidateImage() {
		}
		
		
		public static function check(source:Image):Image {
			var d:Image;
			try {
				d = source;
			} catch(e:Error) {
				d = new Image();
				d.source = GlobalsVO.MissingImage;
				return d;
			}
			
			return d;
		}
	}
}