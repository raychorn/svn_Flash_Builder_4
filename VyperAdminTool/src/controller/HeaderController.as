package controller
{
	import mxml.header.HeaderBar;
	import views.CreateHeader_View;
	import libs.vo.GlobalsVO;
	
	public class HeaderController
	{
		
		public var createHeaderBar:CreateHeader_View;		// To assemble a header bar
		
		private var _headerBarContainer:HeaderBar;
		
		private const HCR:String = "HeaderController";
		private const HBR:String = "HeaderContainer";
		
		
		
		
		
		public function HeaderController() {
			// Load the HeaderBar MXML Class
			GlobalsVO.setGlobal(HBR,this._headerBarContainer = 
			GlobalsVO.getGlobal(GlobalsVO.APPLICATION).addChild(new HeaderBar()));
			// Set reference to this HeaderBar Controller
			GlobalsVO.setGlobal(HCR,this);
			
			// Create a new header bar for presentation logic
			createHeaderBar = new CreateHeader_View();
		}
	}
}