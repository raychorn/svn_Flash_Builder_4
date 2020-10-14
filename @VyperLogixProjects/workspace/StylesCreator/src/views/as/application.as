import mx.core.FlexGlobals;
import mx.styles.IStyleManager2;
import mx.styles.StyleManager;

public var cssbackgroundColor:String = "";
public var cssbackgroundImage:String = "";
public var cssbackgroundSize:String = "";
public var cssthemeColor:String = "";
public var csscolor:String = "";
public var cssbackgroundGradientColors:String = "";
public var cssbackgroundGradientAlphas:String = "";
 
public var isBackgroundOn:Boolean = false;
public var needBackground:Boolean = false;

[Embed(source="/assets/backgrounds.swf#bluestripe")]
public var bluestripe:Class;

[Embed(source="/assets/brushedMetal.jpg")]
public var brushedmetal:Class;

[Embed(source="/assets/backgrounds.swf#greenstripe")]
public var greenstripe:Class;

[Embed(source="/assets/backgrounds.swf#industrial")]
public var industrial:Class;

[Embed(source="/assets/backgrounds.swf#redstripe")]
public var redstripe:Class;

[Embed(source="/assets/backgrounds.swf#retroFifties")]
public var retroFifties:Class;

[Embed(source="/assets/backgrounds.swf#tartan")]
public var tartan:Class;

public function init():void {
	var bgImage:Array = [{label:"None"},
						{label:"bluestripe", data:bluestripe},
						 {label:"redstripe", data:redstripe},
						 {label:"greenstripe", data:greenstripe},
						{label:"brushedmetal", data:brushedmetal},
						{label:"industrial", data:industrial},
						{label:"retroFifties", data:retroFifties},
						{label:"tartan", data:tartan}];
	
	myBackgroundImage.dataProvider = bgImage;
	myBackgroundImage.addEventListener("change", changeBackgroundImage);
	
}

public function changeBackgroundImage(e:Event):void {
	FlexGlobals.topLevelApplication.myBackground.setStyle('backgroundAlpha', 0);
	FlexGlobals.topLevelApplication.myBackgroundImage.setStyle('backgroundAlpha', 1);
	FlexGlobals.topLevelApplication.myBackgroundImage.setStyle('backgroundImage', myBackgroundImage.selectedItem.data);
	if (myBackgroundImage.selectedIndex == 0) {
		cssbackgroundImage = "";
		updateCSS();
	} else if (myBackgroundImage.selectedIndex == 4) {
		setCSS('backgroundImage', 0, 'Embed(source="assets/'+myBackgroundImage.selectedItem.label+'.jpg")')
		setCSS('backgroundSize', 0, '100%');		
	} else	{
		setCSS('backgroundImage', 0, 'Embed(source="assets/backgrounds.swf#'+myBackgroundImage.selectedItem.label+'")')
		setCSS('backgroundSize', 0, '100%');
	}
}


public function setValue(whichStyle:String, whatValue:Number, whatType:String):void {
	myApplication.setStyle(whichStyle, whatValue); 
	icecream.setStyle(whichStyle, whatValue); 
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

myCSS.text = 'Application { \n'
		+ cssbackgroundImage
		+cssbackgroundSize
	 	+cssbackgroundColor
	 	+ cssbackgroundGradientColors
	 	+ cssbackgroundGradientAlphas
		 +cssthemeColor
		 +csscolor
		+ "}"
		; 
		
}

public function setArrayCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, isColor:Boolean):void {
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2); } 
	else { newValue =whatValue1 + ", " + whatValue2; }
	setCSS(whichStyle, 0, newValue);
}

public function restoreDefaults():void {
	var styleMgr:StyleManager = new StyleManager();
	FlexGlobals.topLevelApplication.myBackgroundImage.clearStyle('backgroundImage');
	FlexGlobals.topLevelApplication.myBackgroundImage.setStyle('backgroundAlpha', 0);
	FlexGlobals.topLevelApplication.myBackground.setStyle('backgroundAlpha', 0);
	myApplication.setStyle('themeColor', 0x009DFF);
	icecream.setStyle('themeColor', 0x009DFF);
	myApplication.clearStyle('color');
	IStyleManager2(styleMgr).getStyleDeclaration('Application').clearStyle('backgroundGradientColors');
	IStyleManager2(styleMgr).getStyleDeclaration('Application').setStyle('backgroundGradientAlphas', [1, 1]);
	IStyleManager2(styleMgr).getStyleDeclaration('Application').clearStyle('backgroundColor');

	myBackgroundImage.selectedIndex = 0;
	myBackgroundColor.selectedColor = 0x869CA7;
	myColor.selectedColor = myApplication.getStyle('color');
	myThemeColor.selectedColor = myApplication.getStyle('themeColor');
	fill1.selectedColor = 0x9BAFB9;
	fill2.selectedColor = 0x68808C;
	myFillAlpha1.value = 1;
	myFillAlpha2.value = 1;

	cssbackgroundImage = "";
	cssbackgroundColor= "";
 	cssthemeColor= "";
 	csscolor= "";
 	cssbackgroundSize = "";
	cssbackgroundGradientColors = "";
	cssbackgroundGradientAlphas = "";
	updateCSS();
	
}

