package utils {
	public class TermsAndConditionsHelper {
		[Embed(source="assets/docs/terms/TermsAndConditions.html",mimeType="application/octet-stream")]
		[Bindable]
		public static var TermsAndConditionsCls:Class;
	}
}