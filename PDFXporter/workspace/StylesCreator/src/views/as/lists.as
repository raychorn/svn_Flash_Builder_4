
public var cssbackgroundAlphalist:String = "";
public var cssbackgroundColorlist:String = "";
public var cssalternatingItemColorslist:String = "";
public var cssuseRollOverlist:String = "";
public var cssrollOverColorlist:String  = "";
public var csstextRollOverColorlist:String  = "";
public var cssborderStylelist:String = "";
public var cssborderThicknesslist:String  = "";
public var cssborderColorlist:String  = "";
public var cssselectionColorlist:String  = "";
public var csscolorlist:String  = "";
public var csstextSelectedColorlist:String  = "";
public var csstextIndentlist:String  = "";
public var cssselectionDurationlist:String  = "";
public var cssdropShadowEnabledlist:String  = "";
public var cssshadowDistancelist:String  = "";
public var cssshadowDirectionlist:String  = "";
public var cssdropShadowColorlist:String  = "";

 public var cssbackgroundAlphagrid:String  = "";
 public var cssbackgroundColorgrid:String  = "";
public  var cssalternatingItemColorsgrid:String  = "";
 public var cssheaderColorsgrid:String  = "";
 public var csshorizontalGridLinesgrid:String  = "";
public var csshorizontalGridLineColorgrid:String  = "";
public var cssverticalGridLinesgrid:String  = "";
public var cssverticalGridLineColorgrid:String  = "";
public var cssuseRollOvergrid:String  = "";
public var cssrollOverColorgrid:String  = "";
public var csstextRollOverColorgrid:String  = "";
public var cssborderThicknessgrid:String  = "";
public var cssborderColorgrid:String  = "";
public var cssselectionColorgrid:String  = "";
public var csscolorgrid:String  = "";
public var csstextSelectedColorgrid:String  = "";
public var csstextIndentgrid:String  = "";

public var cssbackgroundAlphatree:String = "";
public var cssbackgroundColortree:String = "";
public var cssalternatingItemColorstree:String = "";
public var cssuseRollOvertree:String = "";
public var cssrollOverColortree:String = "";
public var csstextRollOverColortree:String = "";
public var cssborderThicknesstree:String = "";
public var cssborderColortree:String = "";
public var cssselectionColortree:String = "";
public var csscolortree:String = "";
public var csstextSelectedColortree:String = "";
public var csstextIndenttree:String = "";
public var cssindentationtree:String = "";
public var cssopenDurationtree:String = "";
public var cssselectionDurationtree:String = "";
public var cssdepthColorstree:String = "";


public function setValue(whichStyle:String, whatValue:Number, whatType:String, whichItem:String):void {
	if (whichItem == 'list') { myList.setStyle(whichStyle, whatValue); }
	else if (whichItem == 'grid') {myGrid.setStyle(whichStyle, whatValue) ;}
	else {sbTree.setStyle(whichStyle, whatValue); }
	
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
myCSS.text = 'List { \n'
		+ cssbackgroundAlphalist
		+ cssbackgroundColorlist
		+ cssalternatingItemColorslist
		+ cssuseRollOverlist
		+ cssrollOverColorlist
		+ csstextRollOverColorlist
		+ cssborderStylelist
		+ cssborderThicknesslist
		+ cssborderColorlist
		+ cssselectionColorlist
		+ csscolorlist
		+ csstextSelectedColorlist
		+ csstextIndentlist
		+ cssselectionDurationlist
		+ cssdropShadowEnabledlist
		+ cssshadowDistancelist
		+ cssshadowDirectionlist
		+ cssdropShadowColorlist
		+ "}\n\nDataGrid {\n"
		+ cssbackgroundAlphagrid
		+ cssbackgroundColorgrid
		+ cssalternatingItemColorsgrid
		+ cssheaderColorsgrid
		+ csshorizontalGridLinesgrid
		+ csshorizontalGridLineColorgrid
		+ cssverticalGridLinesgrid
		+ cssverticalGridLineColorgrid
		+ cssuseRollOvergrid
		+ cssrollOverColorgrid
		+ csstextRollOverColorgrid
		+ cssborderThicknessgrid
		+ cssborderColorgrid
		+ cssselectionColorgrid
		+ csscolorgrid
		+ csstextSelectedColorgrid
		+ csstextIndentgrid
		+ "}\n\nTree {\n"
		+ cssbackgroundAlphatree
		+ cssbackgroundColortree
		+ cssalternatingItemColorstree
		+ cssdepthColorstree
		+ cssuseRollOvertree
		+ cssrollOverColortree
		+ csstextRollOverColortree
		+ cssborderThicknesstree
		+ cssborderColortree
		+ cssselectionColortree
		+ csscolortree
		+ csstextSelectedColortree
		+ csstextIndenttree
		+ cssindentationtree
		+ cssopenDurationtree
		+ cssselectionDurationtree
		+ "}"
		; 
}

public function restoreDefaults():void {
	
	if (controlNavigator.selectedIndex == 0) {
		restoreList();
	} else if (controlNavigator.selectedIndex == 1) {
		restoreGrid();
	} else {
		restoreTree();
	}

	updateCSS();
	
}

public function restoreTree():void {

sbTree.clearStyle('backgroundAlpha');
sbTree.clearStyle('backgroundColor');
sbTree.clearStyle('alternatingItemColors');
sbTree.clearStyle('useRollOver');
sbTree.clearStyle('rollOverColor');
sbTree.clearStyle('textRollOverColor');
sbTree.clearStyle('borderThickness');
sbTree.clearStyle('borderColor');
sbTree.clearStyle('selectionColor');
sbTree.clearStyle('color');
sbTree.clearStyle('textSelectedColor');
sbTree.clearStyle('textIndent');
sbTree.clearStyle('indentation');
sbTree.clearStyle('openDuration');
sbTree.clearStyle('selectionDuration');
sbTree.clearStyle('depthColors');

myBackgroundAlphatree.value = sbTree.getStyle('backgroundAlpha') ;
myBackgroundColortree.selectedColor = sbTree.getStyle('backgroundColor');
alternateTree1.selectedColor = 0xFFFFFF;
alternateTree2.selectedColor = 0xEFF1F2;
myUseRollOvertree.selected = true;
myRollOverColortree.selectedColor = sbTree.getStyle('rollOverColor');
myTextRollOverColortree.selectedColor = sbTree.getStyle('textRollOverColor');
myBorderThicknesstree.value = sbTree.getStyle('borderThickness');
myBorderColortree.selectedColor = sbTree.getStyle('borderColor');
mySelectionColortree.selectedColor = sbTree.getStyle('selectionColor');
myColortree.selectedColor = sbTree.getStyle('color');
myTextSelectedColortree.selectedColor = sbTree.getStyle('textSelectedColor');
myTextIndenttree.value = sbTree.getStyle('textIndent');
myIndentationtree.value = sbTree.getStyle('indentation');
myOpenDurationtree.value = sbTree.getStyle('openDuration');
mySelectionDurationtree.value = sbTree.getStyle('selectionDuration');
depthTree1.selectedColor = 0xFFFFFF;
depthTree2.selectedColor = 0xFFFFFF;
depthTree3.selectedColor = 0xFFFFFF;
depthTree4.selectedColor = 0xFFFFFF;

cssbackgroundAlphatree = "";
cssbackgroundColortree = "";
cssalternatingItemColorstree = "";
cssuseRollOvertree = "";
cssrollOverColortree = "";
csstextRollOverColortree = "";
cssborderThicknesstree = "";
cssborderColortree = "";
cssselectionColortree = "";
csscolortree = "";
csstextSelectedColortree = "";
csstextIndenttree = "";
cssindentationtree = "";
cssopenDurationtree = "";
cssselectionDurationtree = "";
cssdepthColorstree = "";

}



public function restoreList():void {
	
	myList.clearStyle('backgroundAlpha');
	myList.clearStyle('backgroundColor');
	myList.clearStyle('alternatingItemColors');
	myList.clearStyle('useRollOver');
	myList.clearStyle('rollOverColor');
	myList.clearStyle('textRollOverColor');
	myList.clearStyle('borderStyle');
	myList.clearStyle('borderThickness');
	myList.clearStyle('borderColor');
	myList.clearStyle('selectionColor');
	myList.clearStyle('color');	
	myList.clearStyle('textSelectedColor');
	myList.clearStyle('textIndent');
	myList.clearStyle('selectionDuration');
	myList.clearStyle('dropShadowEnabled');
	myList.clearStyle('shadowDistance');
	myList.clearStyle('shadowDirection');
	myList.clearStyle('dropShadowColor');
	
	myBackgroundAlphalist.value = myList.getStyle('backgroundAlpha') ;
	myBackgroundColorlist.selectedColor = myList.getStyle('backgroundColor');
	alternateList1.selectedColor = 0xFFFFFF;
	alternateList2.selectedColor = 0xFFFFFF;
	myDropShadowColorlist.selectedColor = 0x000000;
	myUseRollOverList.selected = true;
	myRollOverColorlist.selectedColor = myList.getStyle('rollOverColor');
	myTextRollOverColorlist.selectedColor = myList.getStyle('textRollOverColor');
	myBorderStylelist.selected = true;
	myBorderThicknesslist.value = myList.getStyle('borderThickness');
	myBorderColorlist.selectedColor = myList.getStyle('borderColor');
	mySelectionColorlist.selectedColor = myList.getStyle('selectionColor');
	myColorlist.selectedColor = myList.getStyle('color');
	myTextSelectedColorlist.selectedColor = myList.getStyle('textSelectedColor');
	myTextIndentlist.value = myList.getStyle('textIndent');
	mySelectionDurationlist.value = myList.getStyle('selectionDuration');
	myDropShadowEnabledlist.selected = true;
	myShadowDistancelist.value = myList.getStyle('shadowDistance');
	myShadowDirectionlist.selected = true;
	myRollOverColorlist.enabled = true;
	myTextRollOverColorlist.enabled = true;
	myBorderThicknesslist.enabled = true;
	myBorderColorlist.enabled = true;
	myShadowDistancelist.enabled = false;
	myShadowDirectionlist.enabled = false;
	myShadowDirection2list.enabled = false;
	myShadowDirection3list.enabled = false;
	myDropShadowColorlist.enabled = false;
	
	cssbackgroundAlphalist = "";
	cssbackgroundColorlist = "";
	cssalternatingItemColorslist = "";
	cssuseRollOverlist = "";
	cssrollOverColorlist = "";
	csstextRollOverColorlist = "";
	cssborderStylelist = "";
	cssborderThicknesslist = "";
	cssborderColorlist = "";
	cssselectionColorlist = "";
	csscolorlist = "";
	csstextSelectedColorlist  = "";
	csstextIndentlist = "";
	cssselectionDurationlist  = "";
	cssdropShadowEnabledlist = "";
	cssshadowDistancelist = "";
	cssshadowDirectionlist = "";
	cssdropShadowColorlist = "";
	
}

public function restoreGrid():void {
	
	myGrid.clearStyle('backgroundAlpha');
	myGrid.clearStyle('backgroundColor');
	myGrid.clearStyle('alternatingItemColors');
	myGrid.clearStyle('headerColors');
	myGrid.clearStyle('horizontalGridLines');
	myGrid.clearStyle('horizontalGridLineColor');
	myGrid.clearStyle('verticalGridLines');
	myGrid.clearStyle('verticalGridLineColor');
	myGrid.clearStyle('useRollOver');
	myGrid.clearStyle('rollOverColor');
	myGrid.clearStyle('textRollOverColor');
	myGrid.clearStyle('borderThickness');
	myGrid.clearStyle('borderColor');
	myGrid.clearStyle('selectionColor');
	myGrid.clearStyle('color');
	myGrid.clearStyle('textSelectedColor');
	myGrid.clearStyle('textIndent');
	
	myBackgroundColorgrid.selectedColor = myGrid.getStyle('backgroundColor');
	myBackgroundAlphagrid.value = myGrid.getStyle('backgroundAlpha');
	alternateGrid1.selectedColor = 0xFFFFFF;
	alternateGrid2.selectedColor = 0xEFF1F2;
	headerGrid1.selectedColor = 0xE6EEEE;
	headerGrid2.selectedColor = 0xFFFFFF;
	myHGridLinesgrid.selected = true;
	myVGridLinesgrid.selected = true;
	myHGridLineColorgrid.selectedColor = myGrid.getStyle('horizontalGridLineColor');
	myVGridLineColorgrid.selectedColor = myGrid.getStyle('verticalGridLineColor');
	myUseRollOvergrid.selected = true;
	myRollOverColorgrid.selectedColor = myGrid.getStyle('rollOverColor');
	myTextRollOverColorgrid.selectedColor = myGrid.getStyle('textRollOverColor');
	myRollOverColorgrid.enabled = true;
	myTextRollOverColorgrid.enabled = true;
	myBorderThicknessgrid.value = myGrid.getStyle('borderThickness');
	myBorderColorgrid.selectedColor = myGrid.getStyle('borderColor');
	mySelectionColorgrid.selectedColor = myGrid.getStyle('selectionColor');
	myColorgrid.selectedColor = myGrid.getStyle('color');
	myTextSelectedColorgrid.selectedColor = myGrid.getStyle('textSelectedColor');
	myTextIndentgrid.value = myGrid.getStyle('textIndent');
	myVGridLineColorgrid.enabled = true;
	myHGridLineColorgrid.enabled = false;
	
	cssbackgroundAlphagrid = "";
	cssbackgroundColorgrid = "";
	cssalternatingItemColorsgrid = "";
	cssheaderColorsgrid = "";
	csshorizontalGridLinesgrid = "";
	csshorizontalGridLineColorgrid = "";
	cssverticalGridLinesgrid = "";
	cssverticalGridLineColorgrid = "";
	cssuseRollOvergrid = "";
	cssrollOverColorgrid = "";
	csstextRollOverColorgrid = "";
	cssborderThicknessgrid = "";
	cssborderColorgrid = "";
	cssselectionColorgrid = "";
	csscolorgrid = "";
	csstextSelectedColorgrid = "";
	csstextIndentgrid = "";
	
}


public function enableShadowItemsList():void {
	
	if (myDropShadowEnabledlist.selected == false ) {
		myShadowDistancelist.enabled = true;
		myShadowDirectionlist.enabled = true;
		myShadowDirection2list.enabled = true;
		myShadowDirection3list.enabled = true;
		myDropShadowColorlist.enabled = true;
	} else {
		myShadowDistancelist.enabled = false;
		myShadowDirectionlist.enabled = false;
		myShadowDirection2list.enabled = false;
		myShadowDirection3list.enabled = false;
		myDropShadowColorlist.enabled = false;
	} 
}

public function enableRollOverItemsList():void {
	
	if (myUseRollOverList.selected == true ) {
		myRollOverColorlist.enabled = true;
		myTextRollOverColorlist.enabled = true;
	
	} else {
		myRollOverColorlist.enabled = false;
		myTextRollOverColorlist.enabled = false;
	} 
}

public function enableBorderItemsList():void {
	if (myBorderStylelist.selected == true ) {
		myBorderThicknesslist.enabled = true;
		myBorderColorlist.enabled = true;
	} else {
		myBorderThicknesslist.enabled = false;
		myBorderColorlist.enabled = false;
	} 
}

public function enableRollOverItemsGrid():void {
	
	if (myUseRollOvergrid.selected == true ) {
		myRollOverColorgrid.enabled = true;
		myTextRollOverColorgrid.enabled = true;
	
	} else {
		myRollOverColorgrid.enabled = false;
		myTextRollOverColorgrid.enabled = false;
	} 
}

public function enabledHGridItems():void {
	
	if (myHGridLinesgrid.selected == false ) {
		myHGridLineColorgrid.enabled = true;
	
	} else {
		myHGridLineColorgrid.enabled = false;
	} 
}

public function enabledVGridItems():void {
	
	if (myHGridLinesgrid.selected == true ) {
		myVGridLineColorgrid.enabled = true;
	
	} else {
		myVGridLineColorgrid.enabled = false;
	} 
}

public function enableRollOverItemsTree():void {
	
	if (myUseRollOvertree.selected == true ) {
		myRollOverColortree.enabled = true;
		myTextRollOverColortree.enabled = true;
	
	} else {
		myRollOverColortree.enabled = false;
		myTextRollOverColortree.enabled = false;
	} 
}

public function openTree():void {
		sbTree.expandChildrenOf(sbTree.firstVisibleItem, true);
	}