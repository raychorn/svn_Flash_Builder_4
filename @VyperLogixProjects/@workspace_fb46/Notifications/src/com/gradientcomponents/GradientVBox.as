﻿/**
 * @author Arnaud FOUCAL - http://afoucal.free.fr - afoucal@free.fr
 * 
 * @licence
 * This file is part of the component called Flex Notification.
 * It is delivered under the CC Attribution 3.0 Unported licence (http://creativecommons.org/licenses/by/3.0/) and under the following condition:
 *
 *		Mention the name and the url of the author in a part of your product that is visible to the user ("About"/"Credits" section, documentation...)
 *	
 * This condition can be waived:
 * - if you get permission from the copyright holder and purchasing a non restrictive licence.
 * - if you contribute to the projet by sharing your enhancements.
 * Please contact me at afoucal@free.fr.
 * 
 */

package com.gradientcomponents {
	import spark.components.VGroup;
	
	include "imports.inc";
	
	include "styles.inc";
	
	public class GradientVBox extends VGroup
	{
		
		include "body.inc";
		
		/**
		 * Constructor
		 */
		public function GradientVBox()
		{
			super();
		}
		
	}
}