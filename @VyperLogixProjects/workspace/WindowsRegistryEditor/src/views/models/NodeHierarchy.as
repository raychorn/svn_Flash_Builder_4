package views.models {
	import com.ArrayUtils;
	import com.Generator;
	import com.ObjectUtils;

	public class NodeHierarchy {
		private var _hierarchy:Object;
		
		private var _is_busy:Boolean = false;
		
		public static const root_symbol:String = 'root';
		
		public function NodeHierarchy() {
			this._hierarchy = {'label':NodeHierarchy.root_symbol,'children':[]};
		}
		
		public function get hierarchy():Object {
			return this._hierarchy;
		}

		public function add_node(parent:String,child:String,item:Object):void {
			var rootNode:Object = null;
			var parentNode:Object = null;
			if (!this._is_busy) {
				if ( (parent.toLowerCase() == 'alertpopup') || (child.toLowerCase() == 'alertpopup') ) {
					var ii:int = -1;
				}
				this.rescan_hierarchy();
				this._is_busy = true;
				var gen:Generator = new Generator(this._hierarchy,
					function (g:Generator,n:Object):void {
						if ( (parentNode == null) && (n.label == parent) ) {
							parentNode = n;
						} else if ( (rootNode == null) && (n.label == NodeHierarchy.root_symbol) ) {
							rootNode = n;
						}
					}
				);
				if (rootNode) {
					if (parentNode == null) {
						parentNode = {'label':parent,'tooltip':item.tooltip,'item':item,'children':[]};
						rootNode.children.push(parentNode);
						rootNode = parentNode;
						parentNode = {'label':child,'tooltip':item.tooltip,'item':item,'children':[]};
					} else {
						rootNode = parentNode;
						parentNode = {'label':child,'tooltip':item.tooltip,'item':item,'children':[]};
					}
					rootNode.children.push(parentNode);
				}
				this._is_busy = false;
			}
		}
		
		public function rescan_hierarchy():void {
			if (!this._is_busy) {
				this._is_busy = true;
				var stack:Array = [];
				var aNode:Object = null;
				var rootNodes:Array = this._hierarchy.children;
				try {
					var parentNode:Object;
					for (var i:String in rootNodes) {
						aNode = rootNodes[i];
						parentNode = null;
						var gen:Generator = new Generator(this._hierarchy,
							function (g:Generator,n:Object):void {
								if ( (parentNode == null) && (n != aNode) && (n.label == aNode.label) ) {
									parentNode = n;
								}
							}
						);
						if (parentNode) {
							ArrayUtils.addAllInto(parentNode.children,aNode.children);
							stack.push(aNode);
						}
					}
				} catch (err:Error) {trace('NodeHierarchy.Error.1 '+err.toString()+err.getStackTrace().substr(0,512));}
				try {
					var n:int;
					while (stack.length > 0) {
						aNode = stack.pop();
						n = rootNodes.indexOf(aNode);
						if (n > -1) {
							rootNodes.splice(n,1);
						}
					}
				} catch (err:Error) {trace('NodeHierarchy.Error.2 '+err.toString()+err.getStackTrace().substr(0,512));}
				this._is_busy = false;
			}
		}

		public function search_hierarchy_for(label:String):Object {
			if (!this._is_busy) {
				this._is_busy = true;
				var rootNodes:Array = this._hierarchy.children;
				try {
					var parentNode:Object;
					for (var i:String in rootNodes) {
						parentNode = null;
						var gen:Generator = new Generator(this._hierarchy,
							function (g:Generator,n:Object):void {
								if ( (parentNode == null) && (n.label.toLowerCase() == label.toLowerCase()) ) {
									parentNode = n;
								}
							}
						);
						if (parentNode) {
							this._is_busy = false;
							return parentNode;
						}
					}
				} catch (err:Error) {trace('NodeHierarchy.Error.1 '+err.toString()+err.getStackTrace().substr(0,512));}
				this._is_busy = false;
			}
			return null;
		}

		public function search_hierarchy_children_for(label:String):Object {
			if (!this._is_busy) {
				this._is_busy = true;
				var rootNodes:Array = this._hierarchy.children;
				try {
					var parentNode:Object;
					for (var i:String in rootNodes) {
						parentNode = null;
						var gen:Generator = new Generator(this._hierarchy,
							function (g:Generator,n:Object):void {
								if ( (parentNode == null) && (n.children) && (n.children.length > 0) ) {
									var aChild:Object;
									for (var j:String in n.children) {
										aChild = n.children[j];
										if (aChild.label.toLowerCase() == label.toLowerCase()) {
											parentNode = n;
											break;
										}
									}
								}
							}
						);
						if (parentNode) {
							this._is_busy = false;
							return parentNode;
						}
					}
				} catch (err:Error) {trace('NodeHierarchy.Error.1 '+err.toString()+err.getStackTrace().substr(0,512));}
				this._is_busy = false;
			}
			return null;
		}

		public function sort_hierarchy_by_level():void {
			if (!this._is_busy) {
				this._is_busy = true;
				var rootNodes:Array = this._hierarchy.children;
				try {
					for (var i:String in rootNodes) {
						var gen:Generator = new Generator(this._hierarchy,
							function (g:Generator,ar:*):void {
								if (ar is Array) {
									ar.sort(function (a:*,b:*):int {
										try {
											if (a.label < b.label) {
												return -1;
											}
											if (a.label > b.label) {
												return 1;
											}
										} catch (err:Error) {}
										return 0;
									});
								}
							}, false
						);
					}
				} catch (err:Error) {trace('NodeHierarchy.Error.1 '+err.toString()+err.getStackTrace().substr(0,512));}
				this._is_busy = false;
			}
		}
		// END...		
	}
}