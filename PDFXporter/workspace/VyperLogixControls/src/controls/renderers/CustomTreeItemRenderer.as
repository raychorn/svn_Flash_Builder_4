package controls.renderers {
	import mx.collections.*;
	import mx.controls.treeClasses.*;
	
	public class CustomTreeItemRenderer extends TreeItemRenderer {
		public function CustomTreeItemRenderer() {
			super();
			mouseEnabled = false;			
		}
		
		override public function set data(value:Object):void {
			if(value != null) { 
				super.data = value;
				var hasChildren:Boolean = value.children.length > 0;
				if(hasChildren) {
					this.styleName = 'TreeNodeWithChildren';
				} else {
					this.styleName = 'TreeNodeWithNoChildren';
				}
			}
		}	 
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if (super.data) {
				var d:TreeListData = TreeListData(super.listData);
				var count:int = d.item.children.length;
				var hasChildren:Boolean = count > 0;
				if(hasChildren) {
					super.label.text =  TreeListData(super.listData).label + ((count > 0) ? " (" + count + " sub-classes)" : "");
				}
				var xtra:String = ' @ '+d.item.tooltip;
				if ( (d.item.tooltip is String) && (super.label.text.indexOf(xtra) == -1) ) {
					super.label.text = super.label.text + xtra;
				}
			}
		}
	}
}
