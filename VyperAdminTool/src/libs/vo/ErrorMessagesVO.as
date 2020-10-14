package libs.vo
{
	public class ErrorMessagesVO
	{
		
		public static const E_404:String = "Error:404 - File not found: ";
		public static const E_DATAMODEL:String = "Missing Data Model File";
		public static const ERROR1:String = "ERROR: Graphic Asset name in CSS or GlobalsVO in Application is missing or mis-named for: ";
		public static const ERROR2:String = "ERROR: Graphic Asset (File not found) in CSS for: ";
		public static const ERROR3:String = "CSS ERROR - File not found: ";
		public static const ERROR4:String = "ERROR:(404) File not found - CSS can't locate the file on the server.";
		public static const ERROR401:String = "ERROR:(401) Reference to CSS image name is invalid";
		public static const ERROR5:String = "ERROR:(410) Data Model format appears to be curropt";
		
		
		public function ErrorMessagesVO() {
		}

	}
}