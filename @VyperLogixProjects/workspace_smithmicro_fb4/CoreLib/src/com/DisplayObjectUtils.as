package com {
	public class DisplayObjectUtils {
		public static function getChildrenFrom(anObject:*):Array {
			var children:Array = [];
			
			var i:int;
			try {
				for (i = 0; i < anObject.numElements; i++) {
					children.push(anObject.getElementAt(i));
				}
			} catch (err:Error) {}

			try {
				for (i = 0; i < anObject.numElements; i++) {
					children.push(anObject.getChildAt(i));
				}
			} catch (err:Error) {}
			return children;
		}
	}
}