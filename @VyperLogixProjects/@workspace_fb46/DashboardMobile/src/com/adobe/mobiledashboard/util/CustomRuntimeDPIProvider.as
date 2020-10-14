package com.adobe.mobiledashboard.util
{
	import flash.system.Capabilities;

	import mx.core.RuntimeDPIProvider;

	public class CustomRuntimeDPIProvider extends RuntimeDPIProvider
	{
		public function CustomRuntimeDPIProvider()
		{
			super();
		}

		override public function get runtimeDPI():Number
		{
			// This is a workaround for an issue where the motorola Atrix returns the
			// wrong screen dpi
			if (Capabilities.screenResolutionX == 540 && Capabilities.screenResolutionY == 960 || Capabilities.screenResolutionX == 960 && Capabilities.screenResolutionY == 540)
				return 240;

			return super.runtimeDPI;
		}
	}
}
