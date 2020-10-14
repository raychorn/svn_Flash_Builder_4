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
				var hasChildren:Boolean = false;
				try {
					hasChildren = value.children.length > 0;
				} catch (err:Error) {}
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
				var count:int = 0;
				try {
					count = d.item.children.length;
				} catch (err:Error) {}
				var hasChildren:Boolean = count > 0;
				var description:String = 'sub-class';
				try {
					description = d.item.desc;
				} catch (err:Error) {}
				var plural:String = 'es';
				try {
					plural = d.item.plural;
				} catch (err:Error) {}
				if(hasChildren) {
					super.label.text =  TreeListData(super.listData).label + ((count > 0) ? " (" + count + " " + description + ((count > 1) ? plural : "") + ")" : "");
				}
				var xtra:String = ' @ '+d.item.tooltip;
				if ( (d.item.tooltip is String) && (super.label.text.indexOf(xtra) == -1) ) {
					super.label.text = super.label.text + xtra;
				}
			}
		}
	}
}
