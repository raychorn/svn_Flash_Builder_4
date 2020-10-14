public var csstabHeighttabNavigator:String = "";
public var csstabWidthtabNavigator:String = "";
public var csscornerRadiustabNavigator:String = "";
public var csshorizontalGaptabNavigator:String = "";
public var csspaddingLefttabNavigator:String = "";
public var csspaddingRighttabNavigator:String = "";
public var csshorizontalAligntabNavigator:String = "";
public var csstextAligntabNavigator:String = "";
public var csstextIndenttabNavigator:String = "";
public var cssbackgroundAlphatabNavigator:String = "";
public var cssbackgroundColortabNavigator:String = "";
public var cssborderStyletabNavigator:String = "";
public var cssborderColortabNavigator:String = "";
public var cssborderThicknesstabNavigator:String = "";
public var csscolortabNavigator:String = "";
public var cssdropShadowEnabledtabNavigator:String = "";
public var cssshadowDirectiontabNavigator:String = "";
public var cssshadowDistancetabNavigator:String = "";
public var cssdropShadowColortabNavigator:String = "";


public var csscornerRadiustab:String = "";
public var csshighlightAlphastab:String = "";
public var cssfillAlphastab:String = "";
public var cssfillColorstab:String = "";
public var cssbackgroundColortab:String = "";
public var cssborderColortab:String = "";
public var csscolortab:String = "";
public var csstextRollOverColortab:String = "";
public var cssthemeColortab:String = "";
public var cssbackgroundAlphatab:String = "";

public function setValue(whichStyle:String, whatValue:Number, whatType:String, whichItem:String):void {
	if (whichItem == "tabNavigator") { myTabNavigator.setStyle(whichStyle, whatValue); }
	else { 
		StyleManager.getStyleDeclaration("Tab").setStyle(whichStyle, whatValue);}
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



myCSS.text = 'TabNavigator { \n'
		+ csstabHeighttabNavigator
		+ csstabWidthtabNavigator
		+ csscornerRadiustabNavigator
		+ csshorizontalGaptabNavigator
		+ csshorizontalAligntabNavigator
		+ csspaddingLefttabNavigator
		+ csspaddingRighttabNavigator
		+ csstextAligntabNavigator
		+ csstextIndenttabNavigator
		+ cssbackgroundAlphatabNavigator
		+ cssbackgroundColortabNavigator
		+ cssborderStyletabNavigator
		+ cssborderColortabNavigator
		+ cssborderThicknesstabNavigator
		+ csscolortabNavigator
		+ cssdropShadowEnabledtabNavigator
		+ cssshadowDirectiontabNavigator
		+ cssshadowDistancetabNavigator
		+ cssdropShadowColortabNavigator
		+ '   tabStyleName="myTabs";\n'
		+ "}\n\n.myTabs {\n"
	   + csscornerRadiustab
	   + csshighlightAlphastab
	   + cssfillAlphastab
	   + cssfillColorstab
	   + cssbackgroundColortab
	   + cssbackgroundAlphatab
	   + cssborderColortab
	   + csscolortab
	   + csstextRollOverColortab
	   + cssthemeColortab
	   + "}"
		; 
		
}

public function restoreDefaults():void {

if (controlNavigator.selectedIndex == 0) {
		restoreTabNavigator();
} else {
	restoreTabs();
}

}

public function restoreTabNavigator():void {
	myTabNavigator.setStyle('tabHeight', 20);
	myTabNavigator.clearStyle('tabWidth');
	myTabNavigator.clearStyle('cornerRadius');
	myTabNavigator.clearStyle('horizontalGap');
	myTabNavigator.clearStyle('paddingLeft');
	myTabNavigator.clearStyle('horizontalAlign');
	myTabNavigator.clearStyle('paddingRight');
	myTabNavigator.clearStyle('textAlign');
	myTabNavigator.clearStyle('textIndent');
	myTabNavigator.clearStyle('backgroundAlpha');
	myTabNavigator.clearStyle('backgroundColor');
	myTabNavigator.clearStyle('borderStyle');
	myTabNavigator.clearStyle('borderColor');
	myTabNavigator.clearStyle('borderThickness');
	myTabNavigator.clearStyle('color');
	myTabNavigator.clearStyle('dropShadowColor');
	myTabNavigator.clearStyle('dropShadowEnabled');
	myTabNavigator.clearStyle('shadowDirection');
	myTabNavigator.clearStyle('shadowDistance');

	myTabHeightTabNavigator.value = myTabNavigator.getStyle('tabHeight');
	myTabWidthTabNavigator.value = 79;
	myCornerRadiusTabNavigator.value = myTabNavigator.getStyle('cornerRadius');
	myHorizontalGapTabNavigator.value = myTabNavigator.getStyle('horizontalGap');
	myPaddingLeftTabNavigator.value = myTabNavigator.getStyle('paddingLeft');
	myPaddingRightTabNavigator.value = myTabNavigator.getStyle('paddingRight');
	myHorizontalAligntabNavigator.selected = true;
	myTextAligntabNavigator.selected = true;
	myTextIndentTabNavigator.value = myTabNavigator.getStyle('textIndent');
	myBackgroundAlphatabNavigator.value = myTabNavigator.getStyle('backgroundAlpha');
	myBackgroundColortabNavigator.selectedColor = myTabNavigator.getStyle('backgroundColor');
	myBorderStyletabNavigator.selected = true;
	myBorderColortabNavigator.selectedColor = myTabNavigator.getStyle('borderColor');
	myBorderThicknesstabNavigator.value = myTabNavigator.getStyle('borderThickness');
	myColortabNavigator.selectedColor = myTabNavigator.getStyle('color');
	myDropShadowEnabledtabNavigator.selected = true;
	myShadowDirectiontabNavigator.selected = true;
	myShadowDistancetabNavigator.value = myTabNavigator.getStyle('shadowDistance');
	myShadowDistancetabNavigator.enabled = false;
	myShadowDirectiontabNavigator.enabled = false;
	myShadowDirection2tabNavigator.enabled = false;
	myShadowDirection3tabNavigator.enabled = false;
	myDropShadowColortabNavigator.selectedColor = myTabNavigator.getStyle('dropShadowColor');
	myShadowDistancetabNavigator.enabled = false;
	myShadowDirectiontabNavigator.enabled = false;
	myShadowDirection2tabNavigator.enabled = false;
	myShadowDirection3tabNavigator.enabled = false;
	myDropShadowColortabNavigator.enabled = false;
	
	csstabHeighttabNavigator= "";
	csstabWidthtabNavigator= "";
	csscornerRadiustabNavigator= "";
	csshorizontalGaptabNavigator= "";
	csspaddingLefttabNavigator= "";
	csspaddingRighttabNavigator= "";
	csshorizontalAligntabNavigator = "";
  	csstextAligntabNavigator= "";
	csstextIndenttabNavigator= "";
	cssbackgroundAlphatabNavigator= "";
	cssbackgroundColortabNavigator= "";
	cssborderStyletabNavigator= "";
	cssborderColortabNavigator= "";
	cssborderThicknesstabNavigator= "";
	csscolortabNavigator= "";
	cssdropShadowEnabledtabNavigator= "";
	cssshadowDirectiontabNavigator= "";
	cssshadowDistancetabNavigator= "";
	cssdropShadowColortabNavigator = "";
	 
	 
	 

	myCSS.text = ""; 
}

public function restoreTabs():void {
	StyleManager.getStyleDeclaration("Tab").setStyle('cornerRadius', 6);
	StyleManager.getStyleDeclaration("Tab").clearStyle('highlightAlphas');
	StyleManager.getStyleDeclaration("Tab").clearStyle('fillAlphas');
	StyleManager.getStyleDeclaration("Tab").clearStyle('fillColors');
	StyleManager.getStyleDeclaration("Tab").clearStyle('backgroundColor');
	StyleManager.getStyleDeclaration("Tab").clearStyle('borderColor');
	StyleManager.getStyleDeclaration("Tab").clearStyle('color');
	StyleManager.getStyleDeclaration("Tab").clearStyle('textRollOverColor');
	StyleManager.getStyleDeclaration("Tab").clearStyle('themeColor');
	StyleManager.getStyleDeclaration("Tab").clearStyle('backgroundAlpha');

	
	myCornerRadiustab.value = 4;
	highlightAlpha1tab.value = .3;
	highlightAlpha2tab.value = 0;
	myFillAlpha1tab.value = .6;
	myFillAlpha2tab.value = .4;
	fill1tab.selectedColor = 0xFFFFFF;
	fill2tab.selectedColor = 0xCCCCCC;
	myBackgroundAlphatab.value = 1;
	
	myBackgroundColortab.selectedColor = 0xFFFFFF;
	myBorderColortab.selectedColor = 0xB9BCBE;
	myColortab.selectedColor = 0x0B333C;
	myTextRollOverColortab.selectedColor = 0x0B333C;
	myThemeColortab.selectedColor = 0x009DFF;

 csscornerRadiustab= "";
	 csshighlightAlphastab= "";
	 cssfillAlphastab= "";
	 cssfillColorstab= "";
	 cssbackgroundColortab= "";
	 cssborderColortab= "";
	 csscolortab= "";
	 csstextRollOverColortab= "";
	 cssthemeColortab= "";
	 cssbackgroundAlphatab = "";



	myCSS.text = ""; 
}

	


public function enableShadowItemsTabNavigator():void {
	if (myDropShadowEnabledtabNavigator.selected == false ) {
		myShadowDistancetabNavigator.enabled = true;
		myShadowDirectiontabNavigator.enabled = true;
		myShadowDirection2tabNavigator.enabled = true;
		myShadowDirection3tabNavigator.enabled = true;
		myDropShadowColortabNavigator.enabled = true;
	} else {
		myShadowDistancetabNavigator.enabled = false;
		myShadowDirectiontabNavigator.enabled = false;
		myShadowDirection2tabNavigator.enabled = false;
		myShadowDirection3tabNavigator.enabled = false;
		myDropShadowColortabNavigator.enabled = false;
	}
}

