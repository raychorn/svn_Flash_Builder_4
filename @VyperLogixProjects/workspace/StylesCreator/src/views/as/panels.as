public var csscornerRadius:String = "";
public var cssheaderHeight:String = "";
public var cssshadowDistance:String  = "";
public var cssborderThickness:String  = "";
public var cssdropShadowEnabled:String  = "";
public var cssroundedBottomCorners:String  = "";
public var cssshadowDirection:String  = "";
public var cssbackgroundAlpha:String  = "";
public var cssborderAlpha:String  = "";
public var csshighlightAlphas:String  = "";
public var cssborderStyle:String  = "";
public var cssheaderColors:String  = "";
public var cssfooterColors:String  = "";
public var cssbackgroundColor:String  = "";
public var cssborderColor:String  = "";
public var csscolor:String  = "";
public var csstextAlign:String = "";
public var cssdropShadowColor:String = "";


public function setValue(whichStyle:String, whatValue:Number, whatType:String):void {
	myPanel.setStyle(whichStyle, whatValue);
	setCSS(whichStyle, whatValue, whatType);
}


public function setArrayCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, isColor:Boolean):void {
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2); } 
	else { newValue =whatValue1 + ", " + whatValue2; }
	setCSS(whichStyle, 0, newValue);
}

public function setCSS(whichStyle:String, whatValue:Number, whatType:String):void {
	if (whatType == 'color') { 	this["css" + whichStyle] = whichStyle + ": " + rgbToHex(whatValue) + ";\n   ";	} 
	else if (whatType == 'number' ){ this["css" + whichStyle] = whichStyle + ": " + whatValue + ";\n   "; } 
	else {	this["css" + whichStyle] = whichStyle + ": " + whatType + ";\n   ";}

	myCSS.text = 'Panel { \n   '
		 + csscornerRadius
		 + cssheaderHeight
		 + cssborderThickness
		 + cssdropShadowEnabled
		 + cssshadowDistance
		 + cssshadowDirection
		 + cssdropShadowColor
		 + cssroundedBottomCorners
		 + csstextAlign
		 + cssbackgroundAlpha
		 + cssborderAlpha
		 + csshighlightAlphas
		 + cssborderStyle
		 + cssheaderColors
		 + cssfooterColors
		 + cssbackgroundColor
		 + cssborderColor
		 + 'titleStyleName: "myTitleStyle";\n} \n\n.myTitleStyle {\n   '
		 + csscolor + '}';
		  
}


public function restoreDefaults():void {
	myPanel.clearStyle('cornerRadius');
	myPanel.clearStyle('headerHeight');
	myPanel.clearStyle('shadowDistance');
	myPanel.clearStyle('borderThickness');
	myPanel.clearStyle('dropShadowEnabled');
	myPanel.clearStyle('roundedBottomCorners');
	myPanel.clearStyle('shadowDirection');
	myPanel.clearStyle('backgroundAlpha');
	myPanel.clearStyle('borderAlpha');
	myPanel.clearStyle('highlightAlphas');
	myPanel.clearStyle('borderStyle');
	myPanel.clearStyle('headerColors');
	myPanel.clearStyle('footerColors');
	myPanel.clearStyle('backgroundColor');
	myPanel.clearStyle('borderColor');
	myPanel.clearStyle('color');
	myPanel.clearStyle('textAlign');
	myPanel.clearStyle('dropShadowColor');
	
	myCornerRadius.value = myPanel.getStyle('cornerRadius');
	myHeaderHeight.value = 28;
	myShadowDistance.value = myPanel.getStyle('shadowDistance');
	myBorderThickness.value = myPanel.getStyle('borderThickness');
	PanelDropShadowEnabled.selected = true;
	myRoundedBottomCorners.selected = true;
	myShadowDirection.selected = true;
	myBackgroundAlpha.value = myPanel.getStyle('backgroundAlpha');
	myBorderAlpha.value = myPanel.getStyle('borderAlpha');
	highlightAlpha1.value = .30;
	highlightAlpha2.value = 0;
	myBorderStyle.selected = true;
	header1.selectedColor = 0xe7e7e7;
	header2.selectedColor = 0xd9d9d9;
	footer1.selectedColor = 0xe7e7e7;
	footer2.selectedColor = 0xc7c7c7;
	myDropShadowColor.selectedColor = myPanel.getStyle('dropShadowColor');
	myBackgroundColor.selectedColor = myPanel.getStyle('backgroundColor');
	myBorderColor.selectedColor = myPanel.getStyle('borderColor');
	myColor.selectedColor = myPanel.getStyle('color');
	myTextAlign.selected = true;
	myShadowDistance.enabled = true;
	myShadowDirection.enabled = true;
	myShadowDirection2.enabled = true;
	myShadowDirection3.enabled = true;
	myDropShadowColor.enabled = true;
	
	csscornerRadius = "";
	cssheaderHeight  = "";
	cssshadowDistance	 = "";
	cssborderThickness  = "";
	cssdropShadowEnabled  = "";
	cssroundedBottomCorners  = "";
	cssshadowDirection  = "";
	cssbackgroundAlpha  = "";
	cssborderAlpha  = "";
	csshighlightAlphas  = "";
	cssborderStyle  = "";
	cssheaderColors  = "";
	cssfooterColors  = "";
	cssbackgroundColor  = "";
	cssborderColor  = "";
	csscolor  = "";
	csstextAlign = "";
	cssdropShadowColor = "";

	myCSS.text = "";
}



public function rgbToHex(val:Number):String {
	var newVal:String = val.toString(16);
	while (newVal.length < 6) {	newVal = "0" + newVal; }			
	if (newVal.charAt(1) == 'x') {	newVal = newVal.slice(2, 8); }
	newVal = "#" + newVal;
	return newVal; 
}


/* ------ BELOW FUNCTIONS FOR SHOWING AND HIDING CONTROL BAR ----*/


public function showFooter():void {
	if (controlBarChild.visible == false) {			
		controlBarChild.visible = true; 
		controlBarChild.height = 22; 
		footer1.enabled = true;
		footer2.enabled = true;
	
	} else {
		controlBarChild.visible = false; 
		controlBarChild.height = 0; 
		footer1.enabled = false;
		footer2.enabled = false;
	}
}

public function enableShadowItems():void {
	if (PanelDropShadowEnabled.selected == true ) {
		myShadowDistance.enabled = true;
		myShadowDirection.enabled = true;
		myShadowDirection2.enabled = true;
		myShadowDirection3.enabled = true;
		myDropShadowColor.enabled = true;
	} else {
		myShadowDistance.enabled = false;
		myShadowDirection.enabled = false;
		myShadowDirection2.enabled = false;
		myShadowDirection3.enabled = false;
		myDropShadowColor.enabled = false;
	}
}





