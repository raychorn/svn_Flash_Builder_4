


public var csscornerRadius:String = "";
public var cssborderColor:String = "";
public var csshighlightAlphas:String  = "";
public var cssfillAlphas:String  = "";
public var cssfillColors:String  = "";
public var cssthemeColor:String  = "";
public var csstrackColors:String  = "";


public function setValue(whichStyle:String, whatValue:Number, whatType:String):void {
	myScrollBar.setStyle(whichStyle, whatValue);
	myHScrollBar.setStyle(whichStyle, whatValue);
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

	
	myCSS.text = 'VScrollBar { \n'
		 + csscornerRadius
		 + cssborderColor
		 + csshighlightAlphas
		 + cssfillAlphas
		 + cssfillColors
		 + cssthemeColor
		 + csstrackColors
		
		 + '}\nHScrollBar { \n'
		  + csscornerRadius
		 + cssborderColor
		 + csshighlightAlphas
		 + cssfillAlphas
		 + cssfillColors
		 + cssthemeColor
		 + csstrackColors
		 + "}" ; 
		 
}

public function restoreDefaults():void {

	myScrollBar.clearStyle('cornerRadius');
	myScrollBar.clearStyle('borderColor');
	myScrollBar.clearStyle('highlightAlphas');
	myScrollBar.clearStyle('fillAlphas');
	myScrollBar.clearStyle('fillColors');
	myScrollBar.clearStyle('themeColor');
	myScrollBar.clearStyle('trackColors');
	
	myHScrollBar.clearStyle('cornerRadius');
	myHScrollBar.clearStyle('borderColor');
	myHScrollBar.clearStyle('highlightAlphas');
	myHScrollBar.clearStyle('fillAlphas');
	myHScrollBar.clearStyle('fillColors');
	myHScrollBar.clearStyle('themeColor');
	myHScrollBar.clearStyle('trackColors');
	
	
	myCornerRadius.value = myScrollBar.getStyle('cornerRadius');
	myBorderColor.selectedColor = myScrollBar.getStyle('borderColor');
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
	myThemeColor.selectedColor = myScrollBar.getStyle('themeColor');
	track1.selectedColor = 0x94999B;
	track2.selectedColor = 0xE7E7E7;
	
	

	csscornerRadius = "";
	cssborderColor = "";
	csshighlightAlphas = "";
	cssfillAlphas = "";
	cssfillColors = "";
	cssthemeColor = "";
	csstrackColors = "";


	myCSS.text = ""; 
}





