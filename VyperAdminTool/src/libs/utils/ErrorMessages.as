/* class ErrorMessages
 * @author Ryan C. Knaggs
 * @description: This is a wrapper
 * class to call the Error_View
 * class to display any error messages
 * on the stage
 * This wrapper class file is also
 * needed incase their is other
 * conditional logic to support the displaying
 * of the error message
 */
 

package libs.utils
{
	import libs.vo.GlobalsVO;
	
	import views.Error_View;
	public class ErrorMessages
	{
		public function ErrorMessages(asset:Object,errorMsg:String) {
			new Error_View(asset,errorMsg);
			GlobalsVO.getGlobal(GlobalsVO.JSINTERFACE)[GlobalsVO.FLEXSTATUS](errorMsg);
		}
	}
}