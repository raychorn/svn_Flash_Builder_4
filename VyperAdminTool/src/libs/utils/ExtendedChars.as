/* Class:ExtendedChars
 * @author Ryan C. Knaggs
 * @date 11/19/2009
 * @since 1.0
 * @version 1.0
 * @description: The Flex htmlText property
 * for the text field and labels components
 * sometimes will not understand the
 * symbol set for displaying the ASCII Extended
 * charater set for international characters
 * This class will intercept the html text data
 * and change the HTML symbols to properly work
 * with the flex text fields to propertly display
 * any internation character set
 * @see GlobalsVO
 */


package libs.utils
{
	import libs.vo.GlobalsVO;
	
	public class ExtendedChars
	{
		
		private var _str:String;
		
		
		public function ExtendedChars() {
		}
		
		
		
		public function convertHTML(str:String):String {
			if(str == null || str == "undefined") return str;
			this._str = str;
			
			var convert:Array = GlobalsVO.htmlSymbols;
			for(var i:int=0; i<convert.length; ++i) {
				this._str = _str.replace(new RegExp(convert[i].from,"gi"), convert[i].to);   
			}
			
			return _str;
		}
		
		
		
		
		public function convertWord(str:String):String {
			if(str == null || str == "undefined") return str;
			
			this._str = str;
			
			var convert:Array = GlobalsVO.wordSymbols;
			for(var i:int=0; i<convert.length; ++i) {
				this._str = _str.replace(new RegExp(convert[i].from,"gi"), convert[i].to);   
			}
			
			return _str;
		}
	}
}