
[Bindable]
public var fonts:Array = [ 
		{label:"Arial", data:"arial"}, 
		{label:"Arial Black", data:"arial black"}, 
		{label:"Comic Sans MS", data:"comic sans ms"}, 
		{label:"Courier", data:"courier"}, 
		{label:"Georgia", data:"georgia"},
		{label:"Impact", data:"impact"},
		{label:"Monaco", data:"monaco"},
		{label:"Palatino", data:"palatino"},
		{label:"Tahoma", data:"tahoma"},
		{label:"Times New Roman", data:"times new roman"},
		{label:"Trebuchet MS", data:"trebuchet ms"},
		{label:"Verdana", data:"verdana"}];

[Bindable]		
public var fontsizes:Array = [ 
		{label:"8"}, 
		{label:"9"}, 
		{label:"10"}, 
		{label:"11"}, 
		{label:"12"},
		{label:"14"},
		{label:"16"},
		{label:"18"},
		{label:"20"},
		{label:"22"},
		{label:"24"},
		{label:"28"},
		{label:"32"},
		{label:"48"},
		{label:"72"}
		];


 public var isBold:Boolean = false;
 public var isItalic:Boolean = false;
 public var isUnderline:Boolean = false;
 
 public var cssfontFamily:String = "";
 public var cssfontSize:String = "";
 public var csscolor:String = "";
 public var cssfontWeight:String = "";
 public var cssfontStyle:String = "";
 public var csstextDecoration:String = "";
 public var csstextAlign:String = "";
 public var csspaddingLeft:String = "";
 public var csspaddingRight:String = "";
 public var cssleading:String = "";
 public var csstextIndent:String = "";
 

public function setValue(whichStyle:String, whatValue:Number, whatType:String):void {
	myTextArea.setStyle(whichStyle, whatValue); 
	setCSS(whichStyle, whatValue, whatType);
}

public function rgbToHex(val:Number):String {
	var newVal:String = val.toString(16);
	while (newVal.length < 6) {	newVal = "0" + newVal; }			
	if (newVal.charAt(1) == 'x') {	newVal = newVal.slice(2, 8); }
	newVal = "#" + newVal;
	return newVal; 
}


public function setCSS(whichStyle:String, whatValue:Number, whatType:String):void {


	if (whatType == 'color') { 	this["css" + whichStyle] = "   " + whichStyle + ": " + rgbToHex(whatValue) + ";\n";	} 
	else if (whatType == 'number' ){ this["css" + whichStyle] = "   " + whichStyle + ": " + whatValue + ";\n"; } 
	else {	this["css" + whichStyle] = "   " + whichStyle + ": " + whatType + ";\n";}


	updateCSS();
	
	
		
}


public function updateCSS():void {

myCSS.text = 'TextArea { \n'

		 +cssfontFamily
		 +cssfontSize
		 +csscolor
		 +cssfontWeight
		 +cssfontStyle
		 +csstextDecoration
		 +csstextAlign
		 +csspaddingLeft
		 +csspaddingRight
		 +cssleading
		 +csstextIndent

		+ "}"
		; 
		
}




public function restoreDefaults():void { 

	 myTextArea.clearStyle('fontFamily');
	 myTextArea.clearStyle('fontSize');
	 myTextArea.clearStyle('color');
	 myTextArea.clearStyle('fontWeight');
	 myTextArea.clearStyle('fontStyle');
	 myTextArea.clearStyle('textDecoration');
	 myTextArea.clearStyle('textAlign');
	 myTextArea.clearStyle('paddingLeft');
	 myTextArea.clearStyle('paddingRight');
	 myTextArea.clearStyle('leading');
	 myTextArea.clearStyle('textIndent');

	 
 	 myFontFamily.selectedIndex = 11;
	 myFontSize.selectedIndex = 11;
	 myColor.selectedColor = myTextArea.getStyle('color');
	 boldButton.clearStyle('fillColors');
	 italicButton.clearStyle('fillColors');
	 underlineButton.clearStyle('fillColors');
	 leftButton.clearStyle('fillColors');
	 centerButton.clearStyle('fillColors');
	 rightButton.clearStyle('fillColors');
	 myPaddingLeft.value = myTextArea.getStyle('paddingLeft');
	 myPaddingRight.value = myTextArea.getStyle('paddingRight');
	 myLeading.value = myTextArea.getStyle('leading');
	 myTextIndent.value = myTextArea.getStyle('textIndent');
 
 
	  cssfontFamily= "";
	  cssfontSize= "";
	  csscolor= "";
	  cssfontWeight= "";
	  cssfontStyle= "";
	  csstextDecoration= "";
	  csstextAlign= "";
	  csspaddingLeft= "";
	  csspaddingRight= "";
	  cssleading= "";
	  csstextIndent= "";
	  
	  updateCSS();
}



public function setAlign(myAlign:String):void {
			myTextArea.setStyle('textAlign', myAlign); 
			setCSS('textAlign', 0, myAlign)
			if (myAlign == "left") {
				leftButton.setStyle('fillColors', [0x666666, 0x666666]);
				centerButton.clearStyle('fillColors');
				rightButton.clearStyle('fillColors');
			}
			if (myAlign == "center") {
				centerButton.setStyle('fillColors', [0x666666, 0x666666]);
				leftButton.clearStyle('fillColors');
				rightButton.clearStyle('fillColors');
			}
			if (myAlign == "right") {
				rightButton.setStyle('fillColors', [0x666666, 0x666666]);
				leftButton.clearStyle('fillColors');
				centerButton.clearStyle('fillColors');
			}
		}