/*
 * Class: Assets_Model
 * @author Ryan C. Knaggs
 * @since 1.0
 * @version 1.0 - RCK
 * @date 08/14/2009
 * @description: This class object was written
 * to get information about the local asset(s)
 * dimentions.  The local asset(s) are stored
 * in a Flash SWF file.  The dimention information
 * such as asset width and height is required
 * to properly mathmatically position the graphics
 * in their respective place for the application.
 */


package utils.graphics
{
	
	import flash.geom.*;
	import flash.utils.*;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	
	
	
	public class Asset_Dimentions
	{
		
		private const TIME_OUT:int = 20;
		private var numOfAssets:int = 0;
		
		
		/**
		 * Constructor
		 */
		 		
		public function Asset_Dimentions() {
		}
		
		
		
		
		
		/**
		 * To get the correct dimentions for each
		 * local asset(s) (i.e. Assets are stored in a
		 * Flash SWF file), this method will setup a temporary
		 * container to load the graphic asset(s) into and
		 * loop until the loaded graphic returns either
		 * a height and or width greater then zero.
		 * The loop will stop and the return handle
		 * will be called with the graphic(s) with and height
		 * information passed back as an object.
		 * @param location:Object - The location where to place the canvas generated from this method
		 * @param source:Class - The embedded class object that as reference to the local asset
		 * @param ret:Function - The function call to return the image Dimentions
		 */
		 
		public function getIconDimentions(location:Object, source:Class, ret:Function):void {
			
			numOfAssets++;
			
			var canvas:Canvas = new Canvas();
       		var image:Image = new Image();
       		image.source = source;
       		
			location.addChild(canvas).addChild(image);
			var counter:int = 0;
			var _this:Object = this;
			
			// Loop until image has dimention
			var f:Function = function():void {
				// If image has dimention	
				if(image.width > 0 || image.height > 0) {
					
					// Stop loop
					clearInterval(interval);
					
					// Remove from temporary canvas
					location.removeChild(canvas);
					
					// Return new image dimentions
					ret({width:image.width, height:image.height},--numOfAssets);
					
				}
				
				// Increment timeout if image doesn't have dimention
				if(counter++ >= TIME_OUT) {
					clearInterval(interval);
					
					// Return Missing image dimentions
					ret({width:-1, height:-1},--numOfAssets);
				}
				
			}
			
			// Start loop until image has dimention
			var interval:int = setInterval(f,0);
			
		}
		
	}
	
}