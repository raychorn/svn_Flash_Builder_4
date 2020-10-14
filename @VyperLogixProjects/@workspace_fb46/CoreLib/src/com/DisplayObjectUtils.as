package com {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import spark.components.Button;

	public class DisplayObjectUtils {
		public static function findChild( dispobj:DisplayObjectContainer, childname:String ):DisplayObject {
			if (dispobj == null) {
				return null;
			}
			
			for (var j:int = 0; j < dispobj.numChildren; ++j) { 
				var obj:DisplayObject = dispobj.getChildAt( j ) as DisplayObject;
				if (obj.name == childname) {
					return obj;
				}
				if (obj is DisplayObjectContainer) {
					var doc:DisplayObjectContainer = obj as DisplayObjectContainer;
					if (doc.numChildren > 0) {
						var ret:DisplayObject = findChild( doc, childname );
						if (ret != null) {
							return ret;
						}
					}
				} 
			}
			return null;
		}
		
		public static function display_objects_of_type_within(type:Class,parent:*,btn_pressed:Button):Array {
			var objects:Array = DisplayObjectUtils.getChildrenFrom(parent,null,
				function (obj:*):Boolean {
					return ( (obj is Button) && (obj.id != btn_pressed.id) );
				}
			);
			return objects;
		}
		
		public static function walk_parents_until(obj:*,parent:*,callback:Function=null):Boolean {
			var o:* = obj;
			var __is__:Boolean = false;
			while (o) {
				if (callback is Function) {
					try {
						__is__ = callback(o,parent);
						if (__is__) {
							break;
						}
					} catch (err:Error) {}
				} else if (o.parent == parent) {
					__is__ = true;
					break;
				}
				o = o.parent;
			}
			return __is__;
		}
		
		public static function getChildrenFrom(anObject:*,pattern:String=null,callback:Function=null):Array {
			var children:Array = [];
			
			var i:int;
			var obj:*;
			try {
				for (i = 0; i < anObject.numElements; i++) {
					obj = anObject.getElementAt(i);
					if (pattern == null) {
						if (callback is Function) {
							try {
								if (callback(obj)) {
									if (children.indexOf(obj) == -1) {
										children.push(obj);
									}
								}
							} catch (err:Error) {}
						} else if (obj.id.toString().indexOf(pattern) > -1) {
							if (children.indexOf(obj) == -1) {
								children.push(obj);
							}
						} else {
							if (children.indexOf(obj) == -1) {
								children.push(obj);
							}
						}
					}
				}
			} catch (err:Error) {}

			try {
				for (i = 0; i < anObject.numElements; i++) {
					obj = anObject.getChildAt(i);
					if (pattern == null) {
						if (callback is Function) {
							try {
								if (callback(obj)) {
									if (children.indexOf(obj) == -1) {
										children.push(obj);
									}
								}
							} catch (err:Error) {}
						} else if (obj.id.toString().indexOf(pattern) > -1) {
							if (children.indexOf(obj) == -1) {
								children.push(obj);
							}
						} else {
							if (children.indexOf(obj) == -1) {
								children.push(obj);
							}
						}
					}
				}
			} catch (err:Error) {}
			return children;
		}
	}
}