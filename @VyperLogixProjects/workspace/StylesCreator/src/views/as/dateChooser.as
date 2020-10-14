
public var csscornerRadius:String = "";
public var cssheaderColors:String = "";
public var csshighlightAlphas:String = "";
public var cssfillAlphas:String = "";
public var cssfillColors:String  = "";
public var csstodayColor:String  = "";
public var cssrollOverColor:String = "";
public var cssselectionColor:String  = "";
public var csscolor:String  = "";
public var cssborderColor:String  = "";
public var cssthemeColor:String  = "";
public var cssborderThickness:String = "";
public var cssdropShadowEnabled:String = "";
public var cssdropShadowColor:String = "";
public var cssshadowDirection:String  = "";
public var cssshadowDistance:String  = "";
public var cssbackgroundAlpha:String = "";
public var cssbackgroundColor:String = "";


public function setValue(whichStyle:String, whatValue:Number, whatType:String):void {
	myDateChooser.setStyle(whichStyle, whatValue);
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


public function setCSS(whichStyle:String, whatValue:Number, whatType:String):void {
	if (whatType == 'color') { 	this["css" + whichStyle] = "   " + whichStyle + ": " + rgbToHex(whatValue) + ";\n";	} 
	else if (whatType == 'number' ){ this["css" + whichStyle] = "   " + whichStyle + ": " + whatValue + ";\n"; } 
	else {	this["css" + whichStyle] = "   " + whichStyle + ": " + whatType + ";\n";}

	
	myCSS.text = 'DateChooser { \n'
		 + csscornerRadius
		 + cssborderThickness
		 + cssheaderColors
		 + csshighlightAlphas
		 + cssfillAlphas
		 + cssfillColors
		 + csstodayColor
		 + cssrollOverColor
		 + cssselectionColor 
		 + csscolor
		 + cssborderColor
		 + cssbackgroundColor
		 + cssbackgroundAlpha
		 + cssthemeColor
		 + cssdropShadowEnabled
		 + cssshadowDistance
		 + cssshadowDirection
		 + cssdropShadowColor
		 + "}" ; 
		 
}

public function restoreDefaults():void {


	myDateChooser.clearStyle('cornerRadius');
	myDateChooser.clearStyle('headerColors');
	myDateChooser.clearStyle('highlightAlphas');
	myDateChooser.clearStyle('fillAlphas');
	myDateChooser.clearStyle('fillColors');
	myDateChooser.clearStyle('todayColor');
	myDateChooser.setStyle('rollOverColor', 0xAADEFF);
	myDateChooser.setStyle('selectionColor', 0x7FCDFE);
	myDateChooser.clearStyle('color');
	myDateChooser.clearStyle('borderColor');
	myDateChooser.setStyle('themeColor', 0x009DFF);	
	myDateChooser.clearStyle('borderThickness');
	myDateChooser.clearStyle('dropShadowEnabled');
	myDateChooser.clearStyle('shadowDistance');
	myDateChooser.clearStyle('shadowDirection');
	myDateChooser.clearStyle('dropShadowColor');
	myDateChooser.clearStyle('backgroundAlpha');
	myDateChooser.clearStyle('backgroundColor');
	
	
	
	myCornerRadius.value = myDateChooser.getStyle('cornerRadius');
	myBorderThickness.value = myDateChooser.getStyle('borderThickness');
	header1.selectedColor = 0xE1E5EB;
	header2.selectedColor = 0xF4F5F7;
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
	myTodayColor.selectedColor = 0x818181;
	myRollOverColor.selectedColor = myDateChooser.getStyle('rollOverColor');
	mySelectionColor.selectedColor = myDateChooser.getStyle('selectionColor');
	myColor.selectedColor = myDateChooser.getStyle('color');
	myBorderColor.selectedColor = myDateChooser.getStyle('borderColor');
	myThemeColor.selectedColor = myDateChooser.getStyle('themeColor');
	myDropShadowEnabled.selected = true;
	myDropShadowColor.selectedColor = myDateChooser.getStyle('dropShadowColor');
	myShadowDirection.selected = true;
	myShadowDistance.value = myDateChooser.getStyle('shadowDistance');
	myShadowDistance.enabled = false;
	myShadowDirection.enabled = false;
	myShadowDirection2.enabled = false;
	myShadowDirection3.enabled = false;
	myDropShadowColor.enabled = false;
	myBackgroundColor.selectedColor = myDateChooser.getStyle('backgroundColor');
	myBackgroundAlpha.value = myDateChooser.getStyle('backgroundAlpha');
	
	
	csscornerRadius = "";
	cssborderThickness = "";
	cssheaderColors = "";
	csshighlightAlphas = "";
	cssfillAlphas = "";
	cssfillColors = "";
	csstodayColor = "";
	cssrollOverColor = "";
	cssselectionColor  = "";
	csscolor = "";
	cssborderColor = "";
	cssthemeColor = "";
	cssdropShadowEnabled = "";
	cssdropShadowColor = "";
	cssshadowDistance = "";
	cssshadowDirection = "";
	cssbackgroundAlpha = "";
	cssbackgroundColor = "";

	myCSS.text = ""; 
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






