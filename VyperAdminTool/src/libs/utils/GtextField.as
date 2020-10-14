/* Class: GTextField
 * @author Ryan C. Knaggs
 * @date 10/20.2009
 * @since 1.0
 * @version 1.0
 * @description: Designed to create a textfield
 * that will display graphics (i.e. TradeMark graphic)
 * in the menuitem.  This class will read a string
 * and look for a specific data pattern match
 * to insert the proper graphic between to strings
 * @see ItemItem
 */
 


package libs.utils
{
    import flash.display.*;
    
    import libs.vo.GlobalsVO;
    
    import mx.containers.*;
    import mx.controls.*;
    
    import utils.displayObject.DuplicateImage;



    public class GtextField extends Sprite
    {
        
        private var hBox:HBox;
        private var _style:String;
        private var _shift:Number;
        
        private const COPYRIGHT:String = "&copy;";
        private const COPYRIGHT_SYMBOL:String = "copyRightSymbol";
        private const TRADEMARK:String = "&#8482;";
        private const TRADEMARK_SYMBOL:String = "tradeMarkSymbol";
        private const REGISTERED_TRADEMARK:String = "&reg;";
        private const REGISTERED_TRADEMARK_SYMBOL:String = "registeredTradeMarkSymbol";
        
        
        
        /**
        * Constructor
        */
        
        public function GtextField(target:Object) {
        	hBox = new HBox();
        	hBox.styleName = "MenuItemText";
        	target.addChild(hBox);
        }
        
        private var _callBack:Function;
        
        /**
         * Add new string with reserved symbols 
         * from the data model 
         * @param str:String - Text String
         * @param style
         * @param shift
         */
         
        public function addData(callBack:Function,str:String,style:String,shift:Number):void {
        	this._callBack = callBack;
        	this._style = style;
        	this._shift = shift;
        	
        	var keys:Array = [COPYRIGHT,REGISTERED_TRADEMARK,TRADEMARK];
        	var start:int = 0;
        	
        	if ( (str is String) && (str.length > 0) ) {
	        	for(var i:int = 0; i<str.length; ++i) {
	        		
	        		for(var key:int = 0; key < keys.length; ++key) {
		        		var ss:String = str.substr(i,keys[key].length);
		        		if(ss == keys[key]) {
		        			buildString(str.substring(start,i),keys[key]);
		        			start=i+keys[key].length;
		        		}
		        	}
	        	}
	        	buildString(str.substring(start,i));
        	}
        }
        
        
        
        
        
        /**
         * Assemble the string text with
         * the graphic symbol 
         * @param str
         * @param key
         */    
             
        public function buildString(str:String,key:String=null):void {
        	addText(str);
        	
        	switch(key) {
        		
        		case COPYRIGHT :
		        	addImage(COPYRIGHT_SYMBOL);
        		break;
        		
        		case REGISTERED_TRADEMARK :
		        	addImage(REGISTERED_TRADEMARK_SYMBOL);
        		break;
        		
        		case TRADEMARK :
		        	addImage(TRADEMARK_SYMBOL);
        		break;
        	}
        }
        
        
        
        /**
         * Add new text field 
         * @param str
         */        
        
        public function addText(str:String):void {
        	var l:Label = new Label();
        	l.htmlText = str;
        	l.styleName = _style;
        	l.setStyle("paddingLeft",Number(GlobalsVO.getCSSProperty("symbolLpadding")));
        	l.setStyle("paddingRight",Number(GlobalsVO.getCSSProperty("symbolRpadding")));
        	hBox.addChild(l);
        	hBox.x += _shift;
        }
        
        
       
        /**
         * Insert pre-loaded image
         * @param image
         */
         
        public function addImage(image:String):void {
			var asset:Object = DuplicateImage.validate(GlobalsVO.getGlobal(image),this);
			var img:Image = DuplicateImage.copy(asset.image,false,false);
        	
        	var c:Canvas = new Canvas();
			c.addChild(img);
			// If Error
				if(asset.error != null) {
		        	this._callBack(asset.error);
				}
        	hBox.addChild(c);
        }
    }
}
