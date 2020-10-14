

public var cssheaderHeight:String = "";
public var cssdropShadowEnabled:String = "";
public var cssshadowDistance:String  = "";
public var cssshadowDirection:String  = "";
public var cssborderStyle:String  = "";
public var cssborderThickness:String  = "";
public var cssbackgroundAlpha:String  = "";
public var cssfillAlphas:String  = "";
public var cssfillColors:String  = "";
public var cssselectedFillColors:String  = "";
public var cssbackgroundColor:String  = "";
public var cssborderColor:String  = "";
public var csscolor:String  = "";
public var csstextRollOverColor:String  = "";
public var csstextSelectedColor:String  = "";
public var csstextIndent:String  = "";
public var cssopenDuration:String  = "";
public var csshighlightAlphas:String  = "";
public var cssdropShadowColor:String = "";
public var cssthemeColor:String = "";

public function setValue(whichStyle:String, whatValue:Number, whatType:String):void {
	myAccordion.setStyle(whichStyle, whatValue);
	setCSS(whichStyle, whatValue, whatType);
}


public function rgbToHex(val:Number):String {
	var newVal:String = val.toString(16);
	while (newVal.length < 6) {	newVal = "0" + newVal; }			
	if (newVal.charAt(1) == 'x') {	newVal = newVal.slice(2, 8); }
	newVal = "#" + newVal;
	return newVal; 
}

public function setArrayCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, isColor:Boolean):void {
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2); } 
	else { newValue =whatValue1 + ", " + whatValue2; }
	setCSS(whichStyle, 0, newValue);
}

public function setArrayFourCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, whatValue3:Number, whatValue4:Number, isColor:Boolean):void {
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2) + ", " + rgbToHex(whatValue3) + ", " + rgbToHex(whatValue4); } 
	else { newValue =whatValue1 + ", " + whatValue2 + ", " + whatValue3 + ", " + whatValue4; }
	setCSS(whichStyle, 0, newValue);
}

public function enableShadowItems():void {
	if (myDropShadowEnabled.selected == false ) {
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

public function setCSS(whichStyle:String, whatValue:Number, whatType:String):void {
	if (whatType == 'color') { 	this["css" + whichStyle] = "   " + whichStyle + ": " + rgbToHex(whatValue) + ";\n";	} 
	else if (whatType == 'number' ){ this["css" + whichStyle] = "   " + whichStyle + ": " + whatValue + ";\n"; } 
	else {	this["css" + whichStyle] = "   " + whichStyle + ": " + whatType + ";\n";}

	
	myCSS.text = 'Accordion { \n'
		 + cssheaderHeight
		 + cssdropShadowEnabled
		 + cssshadowDistance
		 + cssshadowDirection
		 + cssdropShadowColor
		 + cssborderStyle
		 + cssborderThickness
		 + cssbackgroundAlpha
		 + csshighlightAlphas
		 + cssfillAlphas
		 + cssfillColors
		 + cssselectedFillColors
		 + cssthemeColor
		 + cssbackgroundColor
		 + cssborderColor
		 + csscolor
		 + csstextRollOverColor
		 + csstextSelectedColor
		 + csstextIndent
		 + cssopenDuration
		 + '}'; 
		  
}

public function restoreDefaults():void {

	myAccordion.clearStyle('headerHeight');
	myAccordion.clearStyle('dropShadowEnabled');
	myAccordion.clearStyle('shadowDistance');
	myAccordion.clearStyle('shadowDirection');
	myAccordion.clearStyle('borderStyle');
	myAccordion.clearStyle('borderThickness');
	myAccordion.clearStyle('backgroundAlpha');
	myAccordion.clearStyle('fillAlphas');
	myAccordion.clearStyle('fillColors');
	myAccordion.clearStyle('selectedFillColors');
	myAccordion.clearStyle('backgroundColor');
	myAccordion.clearStyle('borderColor');
	myAccordion.clearStyle('color');
	myAccordion.clearStyle('textRollOverColor');
	myAccordion.clearStyle('textSelectedColor');
	myAccordion.clearStyle('textIndent');
	myAccordion.clearStyle('openDuration');
	myAccordion.clearStyle('highlightAlphas');
	myAccordion.clearStyle('dropShadowColor');
	myAccordion.clearStyle('themeColor');
	
	
	myHeaderHeight.value = 22;
	myDropShadowEnabled.selected = true;
	myShadowDistance.value = myAccordion.getStyle('shadowDistance');
	myShadowDirection.selected = true;
	myBorderStyle.selected = true;
	myBorderThickness.value = myAccordion.getStyle('borderThickness');
	myBackgroundAlpha.value = myAccordion.getStyle('backgroundAlpha');
	highlightAlpha1.value = .30;
	highlightAlpha2.value = 0;
	myFillAlpha1.value = .60;
	myFillAlpha2.value = .40;
	myFillAlpha3.value = .75;
	myFillAlpha4.value = .65;
	fill1.selectedColor = 0xFFFFFF;
	fill2.selectedColor = 0xCCCCCC;
	fill3.selectedColor = 0xFFFFFF;
	fill4.selectedColor = 0xEEEEEE;
	selectFill1.selectedColor = 0xFFFFFF;
	selectFill2.selectedColor = 0xCCCCCC;
	myBackgroundColor.selectedColor = myAccordion.getStyle('backgroundColor');
	myBorderColor.selectedColor = myAccordion.getStyle('borderColor');
	myColor.selectedColor = myAccordion.getStyle('color');
	myTextRollOverColor.selectedColor = myAccordion.getStyle('textRollOverColor');
	myTextSelectedColor.selectedColor = myAccordion.getStyle('textSelectedColor');
	myTextIndent.value = myAccordion.getStyle('textIndent');
	myOpenDuration.value = myAccordion.getStyle('openDuration');
	myDropShadowColor.selectedColor = myAccordion.getStyle('dropShadowColor');
	myShadowDistance.enabled = false;
	myShadowDirection.enabled = false;
	myShadowDirection2.enabled = false;
	myShadowDirection3.enabled = false;
	myDropShadowColor.enabled = false;
	myThemeColor.selectedColor = myAccordion.getStyle('themeColor');
	
	cssheaderHeight = "";
	cssdropShadowEnabled = "";
	cssshadowDistance = "";
	cssshadowDirection = "";
	cssborderStyle = "";
	cssborderThickness = "";
	cssbackgroundAlpha = "";
	cssfillAlphas = "";
	cssfillColors = "";
	cssselectedFillColors = "";
	cssbackgroundColor = "";
	cssborderColor = "";
	csscolor = "";
	csstextRollOverColor = "";
	csstextSelectedColor = "";
	csstextIndent = "";
	cssopenDuration = "";
	csshighlightAlphas = "";
	cssdropShadowColor = "";
	cssthemeColor = "";
	

	myCSS.text = ""; 
}

