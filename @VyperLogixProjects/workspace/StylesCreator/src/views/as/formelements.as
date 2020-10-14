public var cssbackgroundAlphatextInput:String = "";
public var cssbackgroundColortextInput:String = "";
public var csscolortextInput:String = "";
public var cssborderStyletextInput:String = "";
public var cssborderColortextInput:String = "";
public var cssborderThicknesstextInput:String = "";
public var csscornerRadiustextInput:String = "";
public var csstextIndenttextInput:String = "";
public var cssdropShadowEnabledtextInput:String = "";
public var cssshadowDirectiontextInput:String = "";
public var cssshadowDistancetextInput:String = "";
public var cssdropShadowColortextInput:String = "";

public var cssbackgroundAlphanumericStepper:String = "";
public var cssbackgroundColornumericStepper:String = "";
public var csscolornumericStepper:String = "";
public var cssborderStylenumericStepper:String = "";
public var cssborderColornumericStepper:String = "";
public var cssborderThicknessnumericStepper:String = "";
public var csscornerRadiusnumericStepper:String = "";
public var csshighlightAlphasnumericStepper:String = "";
public var cssfillAlphasnumericStepper:String = "";
public var cssfillColorsnumericStepper:String = "";
public var cssthemeColornumericStepper:String = "";
public var cssdropShadowEnablednumericStepper:String = "";
public var cssshadowDirectionnumericStepper:String = "";
public var cssshadowDistancenumericStepper:String = "";
public var cssdropShadowColornumericStepper:String = "";

public var cssbackgroundAlphacomboBox:String = "";
public var csscolorcomboBox:String = "";
public var cssborderColorcomboBox:String = "";
public var csscornerRadiuscomboBox:String = "";
public var csshighlightAlphascomboBox:String = "";
public var cssfillAlphascomboBox:String = "";
public var cssfillColorscomboBox:String = "";
public var cssselectionColorcomboBox:String = "";
public var csstextSelectedColorcomboBox:String = "";
public var cssrollOverColorcomboBox:String = "";
public var csstextRollOverColorcomboBox:String = "";
public var cssthemeColorcomboBox:String = "";
public var cssalternatingItemColorscomboBox:String = "";
public var cssopenDurationcomboBox:String = "";
public var csscloseDurationcomboBox:String = "";
public var cssuseRollOvercomboBox:String = "";

public var cssborderColorcheckBox:String = "";
public var csshighlightAlphascheckBox:String = "";
public var cssfillAlphascheckBox:String = "";
public var cssfillColorscheckBox:String = "";
public var csscolorcheckBox:String = "";
public var csstextRollOverColorcheckBox:String = "";
public var csstextSelectedColorcheckBox:String = "";
public var cssthemeColorcheckBox:String = "";

public var csslabelOffsethSlider:String = "";
public var cssthumbOffsethSlider:String = "";
public var csstickLengthhSlider:String = "";
public var csstickOffsethSlider:String = "";
public var csstickThicknesshSlider:String = "";
public var csstickColorhSlider:String = "";
public var cssshowTrackHighlighthSlider:String = "";
public var cssborderColorhSlider:String = "";
public var csstrackColorshSlider:String = "";
public var cssthemeColorhSlider:String = "";
public var cssfillAlphashSlider:String = "";
public var cssfillColorshSlider:String = "";
public var csscolorhSlider:String = "";
public var cssdataTipOffsethSlider:String = "";


public function setValue(whichStyle:String, whatValue:Number, whatType:String, whichItem:String):void {
	if (whichItem == 'textInput') { myTextInput.setStyle(whichStyle, whatValue); }
	else if (whichItem == "comboBox") {myComboBox.setStyle(whichStyle, whatValue); }
	else if (whichItem == "hSlider") {mySlider.setStyle(whichStyle, whatValue); }
	else if  (whichItem == "numericStepper") {myNumericStepper.setStyle(whichStyle, whatValue); }
	else {myCheckBox.setStyle(whichStyle, whatValue); myRadioButton.setStyle(whichStyle, whatValue); }

	
	setCSS(whichStyle, whatValue, whatType, whichItem);
}


public function rgbToHex(val:Number):String {
	var newVal:String = val.toString(16);
	while (newVal.length < 6) {	newVal = "0" + newVal; }			
	if (newVal.charAt(1) == 'x') {	newVal = newVal.slice(2, 8); }
	newVal = "#" + newVal;
	return newVal; 
}

public function setArrayCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, isColor:Boolean, whichItem:String):void {
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2); } 
	else { newValue =whatValue1 + ", " + whatValue2; }
	setCSS(whichStyle, 0, newValue, whichItem);
}

public function setArrayFourCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, whatValue3:Number, whatValue4:Number, isColor:Boolean, whichItem:String):void {
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2) + ", " + rgbToHex(whatValue3) + ", " + rgbToHex(whatValue4); } 
	else { newValue =whatValue1 + ", " + whatValue2 + ", " + whatValue3 + ", " + whatValue4; }
	setCSS(whichStyle, 0, newValue, whichItem);
}


public function setCSS(whichStyle:String, whatValue:Number, whatType:String, whichItem:String):void {


	if (whatType == 'color') { 	this["css" + whichStyle + whichItem] = "   " + whichStyle + ": " + rgbToHex(whatValue) + ";\n";	} 
	else if (whatType == 'number' ){ this["css" + whichStyle + whichItem] = "   " + whichStyle + ": " + whatValue + ";\n"; } 
	else {	this["css" + whichStyle + whichItem] = "   " + whichStyle + ": " + whatType + ";\n";}


	updateCSS();
	
	
		
}

public function updateCSS():void {

myCSS.text = 'TextInput { \n'
	   + cssbackgroundAlphatextInput
   + cssbackgroundColortextInput
   + csscolortextInput
   + cssborderStyletextInput
   + cssborderColortextInput
   + cssborderThicknesstextInput
   + csscornerRadiustextInput
   + csstextIndenttextInput
   + cssdropShadowEnabledtextInput
   + cssshadowDirectiontextInput
   + cssshadowDistancetextInput
   + cssdropShadowColortextInput

		+ "}\n\nNumericStepper {\n"
     + cssbackgroundAlphanumericStepper
   + cssbackgroundColornumericStepper
   + csscolornumericStepper
   + cssborderStylenumericStepper
   + cssborderColornumericStepper
   + cssborderThicknessnumericStepper
   + csscornerRadiusnumericStepper
   + csshighlightAlphasnumericStepper
   + cssfillAlphasnumericStepper
   + cssfillColorsnumericStepper
   + cssthemeColornumericStepper
   + cssdropShadowEnablednumericStepper
   + cssshadowDirectionnumericStepper
   + cssshadowDistancenumericStepper
   + cssdropShadowColornumericStepper
			+ "}\n\nComboBox {\n"
		
		   + cssbackgroundAlphacomboBox
   + csscolorcomboBox
   + cssborderColorcomboBox
   + csscornerRadiuscomboBox
   + csshighlightAlphascomboBox
   + cssfillAlphascomboBox
   + cssfillColorscomboBox
   + cssselectionColorcomboBox
   + csstextSelectedColorcomboBox
   + cssuseRollOvercomboBox
   + cssrollOverColorcomboBox
   + csstextRollOverColorcomboBox
   + cssthemeColorcomboBox
   + cssalternatingItemColorscomboBox
   + cssopenDurationcomboBox
   + csscloseDurationcomboBox
		+ "}\n\nCheckBox {\n"

   + cssborderColorcheckBox
   + csshighlightAlphascheckBox
   + cssfillAlphascheckBox
   + cssfillColorscheckBox
   + csscolorcheckBox
   + csstextRollOverColorcheckBox
   + csstextSelectedColorcheckBox
   + cssthemeColorcheckBox

+ "}\n\nRadioButton {\n"

   + cssborderColorcheckBox
   + csshighlightAlphascheckBox
   + cssfillAlphascheckBox
   + cssfillColorscheckBox
   + csscolorcheckBox
   + csstextRollOverColorcheckBox
   + csstextSelectedColorcheckBox
   + cssthemeColorcheckBox

+ "}\n\nHSlider {\n"

     + csslabelOffsethSlider
   + cssthumbOffsethSlider
   + cssdataTipOffsethSlider
   + csstickLengthhSlider
   + csstickOffsethSlider
   + csstickThicknesshSlider
   + csstickColorhSlider
   + cssshowTrackHighlighthSlider
   + cssborderColorhSlider
   + csstrackColorshSlider
   + csscolorhSlider
   + cssthemeColorhSlider
   + cssfillAlphashSlider
   + cssfillColorshSlider


		+ "}"
		; 
		
}

public function restoreDefaults():void {

	if (controlNavigator.selectedIndex == 0) {
		restoreTextInput();
	} else if (controlNavigator.selectedIndex == 1) {
		restoreNumericStepper();
	} else if (controlNavigator.selectedIndex == 2) {
		restoreComboBox();
	} else if (controlNavigator.selectedIndex == 3) {
		restoreCheckBox();
	} else {
		restoreSliders();
	}

	updateCSS();
	
}

public function restoreTextInput():void {

 	myTextInput.clearStyle('backgroundAlpha');
     myTextInput.clearStyle('backgroundColor');
     myTextInput.clearStyle('color');
     myTextInput.clearStyle('borderStyle');
     myTextInput.clearStyle('borderColor');
     myTextInput.clearStyle('borderThickness');
     myTextInput.clearStyle('cornerRadius');
     myTextInput.clearStyle('textIndent');
     myTextInput.clearStyle('dropShadowEnabled');
     myTextInput.clearStyle('shadowDirection');
     myTextInput.clearStyle('shadowDistance');
     myTextInput.clearStyle('dropShadowColor');
     
     myBackgroundAlphatextInput.value = myTextInput.getStyle('backgroundAlpha');
     myBackgroundColortextInput.selectedColor = myTextInput.getStyle('backgroundColor');
     myColortextInput.selectedColor = myTextInput.getStyle('color');
     myBorderStyletextInput.selected = true;
     myBorderColortextInput.selectedColor = myTextInput.getStyle('borderColor');
     myBorderThicknesstextInput.value = myTextInput.getStyle('borderThickness');
     myCornerRadiustextInput.value = myTextInput.getStyle('cornerRadius');
     myDropShadowEnabledtextInput.selected = true;
     myShadowDistancetextInput.value = myTextInput.getStyle('shadowDistance');
     myShadowDirectiontextInput.selected = true;
     myTextIndenttextInput.value = myTextInput.getStyle('textIndent');
     myDropShadowColortextInput.selectedColor = 0x000000;
     myShadowDistancetextInput.enabled = false;
	 myShadowDirectiontextInput.enabled = false;
	 myShadowDirection2textInput.enabled = false;
	 myShadowDirection3textInput.enabled = false;
	 myDropShadowColortextInput.enabled = false;
     
 	cssbackgroundAlphatextInput = "";
     cssbackgroundColortextInput = "";
     csscolortextInput = "";
     cssborderStyletextInput = "";
     cssborderColortextInput = "";
     cssborderThicknesstextInput = "";
     csscornerRadiustextInput = "";
     csstextIndenttextInput = "";
     cssdropShadowEnabledtextInput = "";
     cssshadowDirectiontextInput = "";
     cssshadowDistancetextInput = "";
     cssdropShadowColortextInput = "";
 
}

public function restoreNumericStepper():void {


     myNumericStepper.clearStyle('backgroundAlpha');
     myNumericStepper.clearStyle('backgroundColor');
     myNumericStepper.clearStyle('color');
     myNumericStepper.clearStyle('borderStyle');
     myNumericStepper.clearStyle('borderColor');
     myNumericStepper.clearStyle('borderThickness');
     myNumericStepper.clearStyle('cornerRadius');
     myNumericStepper.clearStyle('highlightAlphas');
     myNumericStepper.clearStyle('fillAlphas');
     myNumericStepper.clearStyle('fillColors');
     myNumericStepper.clearStyle('themeColor');
     myNumericStepper.clearStyle('dropShadowEnabled');
     myNumericStepper.clearStyle('shadowDirection');
     myNumericStepper.clearStyle('shadowDistance');
     myNumericStepper.clearStyle('dropShadowColor');
     
     
     
    myBackgroundAlphanumericStepper.value = myNumericStepper.getStyle('backgroundAlpha');
    myBackgroundColornumericStepper.selectedColor = 0xFFFFFF;
    myColornumericStepper.selectedColor = myNumericStepper.getStyle('color');
    myBorderColornumericStepper.selectedColor = myNumericStepper.getStyle('borderColor');
    myBorderThicknessnumericStepper.value = myNumericStepper.getStyle('borderThickness');
    myCornerRadiusnumericStepper.value = myNumericStepper.getStyle('cornerRadius');
    myThemeColornumericStepper.selectedColor = myNumericStepper.getStyle('themeColor');
    myShadowDistancenumericStepper.value = myNumericStepper.getStyle('shadowDistance');
    myBorderStylenumericStepper.selected = true;
    myDropShadowColornumericStepper.selectedColor = 0x000000;
    myDropShadowEnablednumericStepper.selected = true;
    myShadowDirectionnumericStepper.selected = true;
    highlightAlpha1numericStepper.value = .30;
	highlightAlpha2numericStepper.value = 0;
	myFillAlpha1numericStepper.value = .60;
	myFillAlpha2numericStepper.value = .40;
	myFillAlpha3numericStepper.value = .75;
	myFillAlpha4numericStepper.value = .65;
	fill1numericStepper.selectedColor = 0xFFFFFF;
	fill2numericStepper.selectedColor = 0xCCCCCC;
	fill3numericStepper.selectedColor = 0xFFFFFF;
	fill4numericStepper.selectedColor = 0xEEEEEE;
	myBorderThicknessnumericStepper.enabled = false;
	myShadowDistancenumericStepper.enabled = false;
	myShadowDirectionnumericStepper.enabled = false;
	myShadowDirection2numericStepper.enabled = false;
	myShadowDirection3numericStepper.enabled = false;
	myDropShadowColornumericStepper.enabled = false;
	 
     
     cssbackgroundAlphanumericStepper = "";
     cssbackgroundColornumericStepper = "";
     csscolornumericStepper = "";
     cssborderStylenumericStepper = "";
     cssborderColornumericStepper = "";
     cssborderThicknessnumericStepper = "";
     csscornerRadiusnumericStepper = "";
     csshighlightAlphasnumericStepper = "";
     cssfillAlphasnumericStepper = "";
     cssfillColorsnumericStepper = "";
     cssthemeColornumericStepper = "";
     cssdropShadowEnablednumericStepper = "";
     cssshadowDirectionnumericStepper = "";
     cssshadowDistancenumericStepper = "";
     cssdropShadowColornumericStepper = "";

}

public function restoreComboBox():void {
    myComboBox.clearStyle('backgroundAlpha');
    myComboBox.clearStyle('color');
    myComboBox.clearStyle('borderColor');
   myComboBox.clearStyle('cornerRadius');
    myComboBox.clearStyle('highlightAlphas');
    myComboBox.clearStyle('fillAlphas');
    myComboBox.clearStyle('fillColors');
    myComboBox.setStyle('selectionColor', 0x7FCDFE);
    myComboBox.clearStyle('textSelectedColor');
    myComboBox.setStyle('rollOverColor', 0xAADEFF);
   myComboBox.clearStyle('textRollOverColor');
  myComboBox.setStyle('themeColor', 0x009DFF);
   myComboBox.clearStyle('alternatingItemColors');
    myComboBox.clearStyle('openDuration');
   myComboBox.clearStyle('closeDuration');
   myComboBox.clearStyle('useRollOver');
   
   
     myBackgroundAlphacomboBox.value = myComboBox.getStyle('backgroundAlpha');
     myColorcomboBox.selectedColor = myComboBox.getStyle('color');
     myBorderColorcomboBox.selectedColor = myComboBox.getStyle('borderColor');
     myCornerRadiuscomboBox.value = myComboBox.getStyle('cornerRadius');
     highlightAlpha1comboBox.value = .30;
	 highlightAlpha2comboBox.value = 0;
	 myFillAlpha1comboBox.value = .60;
	 myFillAlpha2comboBox.value = .40;
	myFillAlpha3comboBox.value = .75;
	myFillAlpha4comboBox.value = .65;
	fill1comboBox.selectedColor = 0xFFFFFF;
	fill2comboBox.selectedColor = 0xCCCCCC;
	fill3comboBox.selectedColor = 0xFFFFFF;
	fill4comboBox.selectedColor = 0xEEEEEE;
    mySelectionColorcomboBox.selectedColor = 0x7FCDFE;
    myTextSelectedColorcomboBox.selectedColor = myComboBox.getStyle('textSelectedColor');
    myRollOverColorcomboBox.selectedColor = 0xAADEFF;
   myTextRollOverColorcomboBox.selectedColor = myComboBox.getStyle('textRollOverColor');
    myThemeColorcomboBox.selectedColor = myComboBox.getStyle('themeColor');
    alternate1comboBox.selectedColor = 0xFFFFFF;
	alternate2comboBox.selectedColor = 0xFFFFFF;
	 myOpenDurationcomboBox.value = myComboBox.getStyle('openDuration');
     myCloseDurationcomboBox.value = myComboBox.getStyle('closeDuration');
     myUseRollOvercomboBox.selected = true;
     myRollOverColorcomboBox.enabled = true;
	 myTextRollOverColorcomboBox.enabled = true;
    
   
   
     cssbackgroundAlphacomboBox = "";
    csscolorcomboBox = "";
    cssborderColorcomboBox = "";
   csscornerRadiuscomboBox = "";
    csshighlightAlphascomboBox = "";
    cssfillAlphascomboBox = "";
    cssfillColorscomboBox = "";
    cssselectionColorcomboBox = "";
    csstextSelectedColorcomboBox = "";
    cssrollOverColorcomboBox = "";
   csstextRollOverColorcomboBox = "";
  cssthemeColorcomboBox = "";
   cssalternatingItemColorscomboBox = "";
    cssopenDurationcomboBox = "";
    cssuseRollOvercomboBox = "";
   csscloseDurationcomboBox = "";
}

public function restoreCheckBox():void {


 myCheckBox.clearStyle('borderColor');
    myCheckBox.clearStyle('highlightAlphas');
    myCheckBox.clearStyle('fillAlphas');
    myCheckBox.clearStyle('fillColors');
    myCheckBox.clearStyle('color');
    myCheckBox.clearStyle('textRollOverColor');
    myCheckBox.clearStyle('textSelectedColor');
    myCheckBox.clearStyle('themeColor');
   
    
    myRadioButton.clearStyle('borderColor');
    myRadioButton.clearStyle('highlightAlphas');
    myRadioButton.clearStyle('fillAlphas');
    myRadioButton.clearStyle('fillColors');
    myRadioButton.clearStyle('color');
    myRadioButton.clearStyle('textRollOverColor');
    myRadioButton.clearStyle('textSelectedColor');
    myRadioButton.clearStyle('themeColor');


   myBorderColorcheckBox.selectedColor = myCheckBox.getStyle('borderColor');
     highlightAlpha1checkBox.value = .30;
	 highlightAlpha2checkBox.value = 0;
	myFillAlpha1checkBox.value = .60;
	 myFillAlpha2checkBox.value = .40;
	myFillAlpha3checkBox.value = .75;
	myFillAlpha4checkBox.value = .65;
	fill1checkBox.selectedColor = 0xFFFFFF;
	fill2checkBox.selectedColor = 0xCCCCCC;
	fill3checkBox.selectedColor = 0xFFFFFF;
	fill4checkBox.selectedColor = 0xEEEEEE;
     myColorcheckBox.selectedColor = myCheckBox.getStyle('color');
   myTextRollOverColorcheckBox.selectedColor = myCheckBox.getStyle('textRollOverColor');
    myTextSelectedColorcheckBox.selectedColor = myCheckBox.getStyle('textSelectedColor');
    myThemeColorcheckBox.selectedColor = myCheckBox.getStyle('themeColor');
   


    cssborderColorcheckBox = "";
    csshighlightAlphascheckBox = "";
    cssfillAlphascheckBox = "";
    cssfillColorscheckBox = "";
    csscolorcheckBox = "";
    csstextRollOverColorcheckBox = "";
    csstextSelectedColorcheckBox = "";
    cssthemeColorcheckBox = "";



}

public function restoreSliders():void {


 mySlider.clearStyle('labelOffset');
    mySlider.clearStyle('thumbOffset');
    mySlider.clearStyle('tickLength');
    mySlider.clearStyle('tickOffset');
    mySlider.clearStyle('tickThickness');
    mySlider.clearStyle('tickColor');
    mySlider.setStyle('showTrackHighlight', false);
    mySlider.clearStyle('borderColor');
    mySlider.clearStyle('trackColors');
    mySlider.clearStyle('themeColor');
    mySlider.clearStyle('fillAlphas');
    mySlider.clearStyle('fillColors');
    mySlider.clearStyle('color');
    mySlider.clearStyle('dataTipOffset');
  
  myDataTipOffsethSlider.value = mySlider.getStyle('dataTipOffset');
   myLabelOffsethSlider.value = mySlider.getStyle('labelOffset');
   myThumbOffsethSlider.value = mySlider.getStyle('thumbOffset');
   myTickLengthhSlider.value = mySlider.getStyle('tickLength');
   myTickOffsethSlider.value = mySlider.getStyle('tickOffset');
   myTickThicknesshSlider.value = mySlider.getStyle('tickThickness');
   myTickColorhSlider.selectedColor = mySlider.getStyle('tickColor');
   myColorhSlider.selectedColor = mySlider.getStyle('color');
   myTrackHighlighthSlider.selected = true;
    myBorderColorhSlider.selectedColor = mySlider.getStyle('borderColor');
   track1hSlider.selectedColor = 0xFFFFFF;
  track1hSlider.selectedColor = 0xFFFFFF;
  myThemeColorhSlider.selectedColor = mySlider.getStyle('themeColor');
     myFillAlpha1hSlider.value = .60;
	 myFillAlpha2hSlider.value = .40;
	myFillAlpha3hSlider.value = .75;
	myFillAlpha4hSlider.value = .65;
	fill1hSlider.selectedColor = 0xFFFFFF;
	fill2hSlider.selectedColor = 0xCCCCCC;
	fill3hSlider.selectedColor = 0xFFFFFF;
	fill4hSlider.selectedColor = 0xEEEEEE;
  
  
    cssdataTipOffsethSlider = "";
	 csslabelOffsethSlider = "";
    cssthumbOffsethSlider = "";
    csstickLengthhSlider = "";
    csstickOffsethSlider = "";
    csstickThicknesshSlider = "";
    csstickColorhSlider = "";
    cssshowTrackHighlighthSlider = "";
    cssborderColorhSlider = "";
    csstrackColorshSlider = "";
    cssthemeColorhSlider = "";
    cssfillAlphashSlider = "";
    cssfillColorshSlider = "";
    csscolorhSlider = "";
	
	
	
	
	
}


public function enableBorderItemsnumericStepper():void {
	if (myBorderStylenumericStepper2.selected == true) {
		myBorderThicknessnumericStepper.enabled = true;
	} else {
		myBorderThicknessnumericStepper.enabled = false;
	}
}

public function enableShadowItemsTextInput():void {
	if (myDropShadowEnabledtextInput.selected == false ) {
		myShadowDistancetextInput.enabled = true;
		myShadowDirectiontextInput.enabled = true;
		myShadowDirection2textInput.enabled = true;
		myShadowDirection3textInput.enabled = true;
		myDropShadowColortextInput.enabled = true;
	} else {
		myShadowDistancetextInput.enabled = false;
		myShadowDirectiontextInput.enabled = false;
		myShadowDirection2textInput.enabled = false;
		myShadowDirection3textInput.enabled = false;
		myDropShadowColortextInput.enabled = false;
	}
}




public function enableShadowItemsNumericStepper():void {
	if (myDropShadowEnablednumericStepper.selected == false ) {
		myShadowDistancenumericStepper.enabled = true;
		myShadowDirectionnumericStepper.enabled = true;
		myShadowDirection2numericStepper.enabled = true;
		myShadowDirection3numericStepper.enabled = true;
		myDropShadowColornumericStepper.enabled = true;
	} else {
		myShadowDistancenumericStepper.enabled = false;
		myShadowDirectionnumericStepper.enabled = false;
		myShadowDirection2numericStepper.enabled = false;
		myShadowDirection3numericStepper.enabled = false;
		myDropShadowColornumericStepper.enabled = false;
	}
}


public function enableRollOverItemsComboBox():void {
	if (myUseRollOvercomboBox.selected == true ) {
		myRollOverColorcomboBox.enabled = true;
		myTextRollOverColorcomboBox.enabled = true;
	} else {
		myRollOverColorcomboBox.enabled = false;
		myTextRollOverColorcomboBox.enabled = false;
	}
}


