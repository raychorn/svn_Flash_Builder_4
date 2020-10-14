package com {
	public class ImageAssets {
		[Embed(source="/assets/activity/FireFoxRoller.swf")]
		[Bindable]
		public static var fireFoxRollerClass:Class;
		
		[Embed(source="/assets/nav/images/navigateHome.gif")]
		[Bindable]
		public static var navigateHomeClass:Class;
		
		[Embed(source="/assets/nav/images/navigateUp.gif")]
		[Bindable]
		public static var navigateUpClass:Class;
		
		[Embed(source="/assets/nav/images/navigateUpDisabled.gif")]
		[Bindable]
		public static var navigateUpDisabledClass:Class;
	}
}