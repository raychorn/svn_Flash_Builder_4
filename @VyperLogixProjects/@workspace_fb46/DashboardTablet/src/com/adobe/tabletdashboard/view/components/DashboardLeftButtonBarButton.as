package com.adobe.tabletdashboard.view.components
{
	import skins.buttons.LeftToggleButtonSkin;

	import spark.components.ButtonBarButton;

	public class DashboardLeftButtonBarButton extends ButtonBarButton
	{
		public function DashboardLeftButtonBarButton()
		{
			super();
			this.setStyle("skinClass", LeftToggleButtonSkin);
			this.width=100;
		}
	}
}
