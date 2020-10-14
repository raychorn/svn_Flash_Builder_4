package controls {
	import mx.core.UITextField;
	import flash.text.TextFieldAutoSize;
	import mx.controls.Label;
	import flash.display.DisplayObject;
	
	public class MultiLineLabel extends Label {
		
		override protected function createChildren() : void {
			if (!textField) {
				textField = new UITextField();
				textField.styleName = this;
				addChild(DisplayObject(textField));
			}
			super.createChildren();
			textField.multiline = true;
			textField.wordWrap = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
		}
	}
}
