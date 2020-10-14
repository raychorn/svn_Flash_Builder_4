package views
{
	import libs.vo.GlobalsVO;
	
	import mxml.header.HeaderBar;
	
	public class CreateHeader_View
	{
		
		private var _headerBar:HeaderBar;
		private var _css:Function;
		
		private const HCR:String = "HeaderController";
		private const HBC:String = "HeaderContainer";
		private const HBH:String = "headerHeight";
		
		
		public function CreateHeader_View() {
			
			this._headerBar = GlobalsVO.getGlobal(HBC);
			
			this._css = GlobalsVO.getCSSProperty;
			// Define the menu bar height from the CSS style
			GlobalsVO.setMaxHeight(this._headerBar.componentHeight = Number(_css(HBH)));
		}
	}
}