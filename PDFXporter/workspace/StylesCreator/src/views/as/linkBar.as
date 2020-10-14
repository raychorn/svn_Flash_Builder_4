

public var csshorizontalGaplinkBar:String = "";
public var cssseparatorWidthlinkBar:String = "";
public var cssborderStylelinkBar:String = "";
public var csscornerRadiuslinkBar:String = "";
public var cssborderThicknesslinkBar:String = "";
public var cssdropShadowEnabledlinkBar:String = "";
public var cssshadowDistancelinkBar:String = "";
public var cssshadowDirectionlinkBar:String = "";
public var cssbackgroundColorlinkBar:String = "";
public var cssbackgroundAlphalinkBar:String = "";
public var cssborderColorlinkBar:String = "";
public var cssseparatorColorlinkBar:String = "";
public var cssrollOverColorlinkBar:String = "";
public var cssselectionColorlinkBar:String = "";
public var csscolorlinkBar:String = "";
public var csstextRollOverColorlinkBar:String = "";
public var csstextSelectedColorlinkBar:String = "";
public var cssdropShadowColorlinkBar:String = "";
public var cssdisabledColorlinkBar:String = "";

public var csscornerRadiusapplicationControlBar:String = "";
public var cssdropShadowEnabledapplicationControlBar:String = "";
public var cssshadowDistanceapplicationControlBar:String = "";
public var cssshadowDirectionapplicationControlBar:String = "";
public var cssborderStyleapplicationControlBar:String = "";
public var cssborderThicknessapplicationControlBar:String = "";
public var cssbackgroundColorapplicationControlBar:String = "";
public var csshighlightAlphasapplicationControlBar:String = "";
public var cssfillAlphasapplicationControlBar:String = "";
public var cssfillColorsapplicationControlBar:String = "";
public var cssbackgroundAlphaapplicationControlBar:String = "";
public var cssborderColorapplicationControlBar:String = "";
public var cssdropShadowColorapplicationControlBar:String = "";


public function setValue(whichStyle:String, whatValue:Number, whatType:String, whichItem:String):void {
	if (whichItem == 'linkBar') { myLinkBar.setStyle(whichStyle, whatValue); }
	else  {myApplicationControlBar.setStyle(whichStyle, whatValue) ;}
	
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

myCSS.text = 'LinkBar { \n'
		+  csshorizontalGaplinkBar
		+  cssseparatorWidthlinkBar
		+  cssborderStylelinkBar
		+  csscornerRadiuslinkBar
		+  cssborderThicknesslinkBar
		+  cssdropShadowEnabledlinkBar
		+  cssshadowDistancelinkBar
		+  cssshadowDirectionlinkBar
		+  cssdropShadowColorlinkBar
		+  cssbackgroundColorlinkBar
		+  cssbackgroundAlphalinkBar
		+  cssborderColorlinkBar
		+  cssseparatorColorlinkBar
		+  cssrollOverColorlinkBar
		+  cssselectionColorlinkBar
		+  csscolorlinkBar
		+  csstextRollOverColorlinkBar
		+  csstextSelectedColorlinkBar
		+  cssdisabledColorlinkBar
		+ "}\n\nApplicationControlBar {\n"
        +  csscornerRadiusapplicationControlBar
        +  cssdropShadowEnabledapplicationControlBar
        +  cssshadowDistanceapplicationControlBar
        +  cssshadowDirectionapplicationControlBar
        +  cssdropShadowColorapplicationControlBar
        +  cssborderStyleapplicationControlBar
        +  cssborderThicknessapplicationControlBar
        +  cssbackgroundColorapplicationControlBar
        +  csshighlightAlphasapplicationControlBar
        +  cssfillAlphasapplicationControlBar
        +  cssfillColorsapplicationControlBar
        +  cssbackgroundAlphaapplicationControlBar
        +  cssborderColorapplicationControlBar
		+ "}"
		; 
}

public function restoreDefaults():void {

	if (controlNavigator.selectedIndex == 0) {
		restoreLinkBar();
	} else {
		restoreApplicationControlBar();
	}

	updateCSS();
	
}

public function restoreLinkBar():void {

myLinkBar.clearStyle('horizontalGap');
myLinkBar.clearStyle('separatorWidth');
myLinkBar.clearStyle('borderStyle');
myLinkBar.clearStyle('cornerRadius');
myLinkBar.clearStyle('borderThickness');
myLinkBar.clearStyle('dropShadowEnabled');
myLinkBar.clearStyle('shadowDistance');
myLinkBar.clearStyle('shadowDirection');
myLinkBar.clearStyle('backgroundColor');
myLinkBar.clearStyle('backgroundAlpha');
myLinkBar.clearStyle('borderColor');
myLinkBar.clearStyle('separatorColor');
myLinkBar.clearStyle('rollOverColor');
myLinkBar.clearStyle('selectionColor');
myLinkBar.clearStyle('color');
myLinkBar.clearStyle('textRollOverColor');
myLinkBar.clearStyle('textSelectedColor');
myLinkBar.clearStyle('dropShadowColor');
myLinkBar.clearStyle('disabledColor');

myHorizontalGaplinkBar.value = myLinkBar.getStyle('horizontalGap') ;
mySeparatorWidthlinkBar.value = myLinkBar.getStyle('separatorWidth');
myCornerRadiuslinkBar.value = myLinkBar.getStyle('cornerRadius');
myBorderThicknesslinkBar.value = myLinkBar.getStyle('borderThickness');
myBackgroundAlphalinkBar.value = myLinkBar.getStyle('backgroundAlpha') ;
myShadowDistancelinkBar.value = myLinkBar.getStyle('shadowDistance');
myDropShadowColorlinkBar.selectedColor = 0x000000;
myBackgroundColorlinkBar.selectedColor = 0xFFFFFF;
myBorderColorlinkBar.selectedColor = myLinkBar.getStyle('borderColor');
mySeparatorColorlinkBar.selectedColor = myLinkBar.getStyle('separatorColor');
myRollOverColorlinkBar.selectedColor = myLinkBar.getStyle('rollOverColor');
mySelectionColorlinkBar.selectedColor = myLinkBar.getStyle('selectionColor');
myColorlinkBar.selectedColor = myLinkBar.getStyle('color');
myTextRollOverColorlinkBar.selectedColor = myLinkBar.getStyle('textRollOverColor');
myTextSelectedColorlinkBar.selectedColor = myLinkBar.getStyle('textSelectedColor');
myDisabledColorlinkBar.selectedColor = myLinkBar.getStyle('disabledColor');
myBorderStylelinkBar.selected = true;
myDropShadowEnabledlinkBar.selected = true;
myShadowDirectionlinkBar.selected = true;
myShadowDistancelinkBar.enabled = false;
myShadowDirectionlinkBar.enabled = false;
myShadowDirection2linkBar.enabled = false;
myShadowDirection3linkBar.enabled = false;
myDropShadowColorlinkBar.enabled = false;

csshorizontalGaplinkBar = "";
cssseparatorWidthlinkBar = "";
cssborderStylelinkBar = "";
csscornerRadiuslinkBar = "";
cssborderThicknesslinkBar = "";
cssdropShadowEnabledlinkBar = "";
cssshadowDistancelinkBar = "";
cssshadowDirectionlinkBar = "";
cssbackgroundColorlinkBar = "";
cssbackgroundAlphalinkBar = "";
cssborderColorlinkBar = "";
cssseparatorColorlinkBar = "";
cssrollOverColorlinkBar = "";
cssselectionColorlinkBar = "";
csscolorlinkBar = "";
csstextRollOverColorlinkBar = "";
csstextSelectedColorlinkBar = "";
cssdropShadowColorlinkBar = "";
cssdisabledColorlinkBar = "";


}



public function restoreApplicationControlBar():void {


	myApplicationControlBar.clearStyle('cornerRadius');
	myApplicationControlBar.clearStyle('dropShadowEnabled');
	myApplicationControlBar.clearStyle('shadowDistance');
	myApplicationControlBar.clearStyle('shadowDirection');
	myApplicationControlBar.clearStyle('borderStyle');
	myApplicationControlBar.clearStyle('borderThickness');
	myApplicationControlBar.clearStyle('backgroundColor');
	myApplicationControlBar.clearStyle('highlightAlphas');
	myApplicationControlBar.clearStyle('fillAlphas');
	myApplicationControlBar.clearStyle('fillColors');
	myApplicationControlBar.clearStyle('backgroundAlpha');
	myApplicationControlBar.clearStyle('borderColor');
	myApplicationControlBar.clearStyle('dropShadowColor');
	
	myCornerRadiusapplicationControlBar.value = myApplicationControlBar.getStyle('cornerRadius');
	myDropShadowEnabledApplicationControlBar.selected = true;
	enableShadowItemsApplicationControlBar();
	myShadowDistanceapplicationControlBar.value = myApplicationControlBar.getStyle('shadowDistance');
	myShadowDirectionapplicationControlBar.selected = true;
	myBorderStyleapplicationControlBar.selected = true;
	myBorderThicknessapplicationControlBar.value = myApplicationControlBar.getStyle('borderThickness');
	myBackgroundColorapplicationControlBar.selectedColor = 0xFFFFFF;
	myDropShadowColorapplicationControlBar.selectedColor = 0x000000;
	myShadowDistanceapplicationControlBar.enabled = true;
	myShadowDirectionapplicationControlBar.enabled = true;
	myShadowDirection2applicationControlBar.enabled = true;
	myShadowDirection3applicationControlBar.enabled = true;
	myDropShadowColorapplicationControlBar.enabled = true;
	myBorderColorapplicationControlBar.enabled = false;
	myBorderThicknessapplicationControlBar.enabled = false;
	highlightAlpha1.value = .30;
	highlightAlpha2.value = 0;
	fillAlpha1.value = 0;
	fillAlpha2.value = 0;
	Fill1.selectedColor = 0xFFFFFF;
	Fill2.selectedColor = 0xFFFFFF;
	myBorderColorapplicationControlBar.selectedColor =0xFFFFFF;
	myBackgroundAlphaapplicationControlBar.value = myApplicationControlBar.getStyle('backgroundAlpha');
	
	csscornerRadiusapplicationControlBar = "";
    cssdropShadowEnabledapplicationControlBar = "";
	cssshadowDistanceapplicationControlBar = "";
	cssshadowDirectionapplicationControlBar = "";
	cssborderStyleapplicationControlBar = "";
	cssborderThicknessapplicationControlBar = "";
	cssbackgroundColorapplicationControlBar = "";
	csshighlightAlphasapplicationControlBar = "";
	cssfillAlphasapplicationControlBar = "";
	cssfillColorsapplicationControlBar = "";
	cssbackgroundAlphaapplicationControlBar = "";
	cssborderColorapplicationControlBar = "";
	cssdropShadowColorapplicationControlBar = "";
	
	
	
	
	
}


public function enableShadowItemsLinkBar():void {
	if (myDropShadowEnabledlinkBar.selected == false ) {
		myShadowDistancelinkBar.enabled = true;
		myShadowDirectionlinkBar.enabled = true;
		myShadowDirection2linkBar.enabled = true;
		myShadowDirection3linkBar.enabled = true;
		myDropShadowColorlinkBar.enabled = true;
	} else {
		myShadowDistancelinkBar.enabled = false;
		myShadowDirectionlinkBar.enabled = false;
		myShadowDirection2linkBar.enabled = false;
		myShadowDirection3linkBar.enabled = false;
		myDropShadowColorlinkBar.enabled = false;
	}
}

public function enableShadowItemsApplicationControlBar():void {
	if (myDropShadowEnabledApplicationControlBar.selected == false ) {
		myShadowDistanceapplicationControlBar.enabled = false;
		myShadowDirectionapplicationControlBar.enabled = false;
		myShadowDirection2applicationControlBar.enabled = false;
		myShadowDirection3applicationControlBar.enabled = false;
		myDropShadowColorapplicationControlBar.enabled = false;
	} else {
		myShadowDistanceapplicationControlBar.enabled = true;
		myShadowDirectionapplicationControlBar.enabled = true;
		myShadowDirection2applicationControlBar.enabled = true;
		myShadowDirection3applicationControlBar.enabled = true;
		myDropShadowColorapplicationControlBar.enabled = true;
	}
}

public function enableBorderItemsApplicationControlBar():void {
	if (myBorderStyle3applicationControlBar.selected == false ) {
		myBorderColorapplicationControlBar.enabled = false;
		myBorderThicknessapplicationControlBar.enabled = false;
	} else {
		myBorderColorapplicationControlBar.enabled = true;
		myBorderThicknessapplicationControlBar.enabled = true;
	}
}






