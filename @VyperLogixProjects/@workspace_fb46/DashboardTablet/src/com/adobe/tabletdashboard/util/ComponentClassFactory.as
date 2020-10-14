package com.adobe.tabletdashboard.util
{
	import mx.core.ClassFactory;
	import mx.core.UIComponent;
	
	public class ComponentClassFactory extends ClassFactory
	{
		public var styles:Object = null;
		
		public function ComponentClassFactory(generator:Class=null, properties:Object=null, styles:Object=null)
		{
			super(generator);
			this.properties = properties;
			this.styles = styles;
		}
		
		override public function newInstance():*{
			var instance:Object = new generator();
			
			if (properties != null)
			{
				for (var p:String in properties)
				{
					instance[p] = properties[p];
				}
			}
			if (styles != null && instance is UIComponent)
			{
				for (var s:String in styles)
				{
					
					instance.setStyle(s,styles[s]);
				}
			}
			return instance;
		}
	}
}