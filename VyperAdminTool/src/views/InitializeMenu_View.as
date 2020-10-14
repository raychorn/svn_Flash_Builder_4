/* Class InitializeMenu_View
 * @author Ryan C. Knaggs
 * @date 10/15/2009
 * @version 1.0
 * @description: Designed to assemble the menu container
 * with different menu components such as:
 * menuitems, menu separator and menu title text
 */

package views
{
	
	
	import flash.events.*;
	
	import libs.vo.GlobalsVO;
	
	import mx.containers.Canvas;
	import mx.controls.Spacer;
	import mx.events.FlexEvent;
	
	import mxml.*;
	
	
	
	public class InitializeMenu_View extends EventDispatcher
	{
		
		
		/* Current Array of Menuitems, 
		 * this is for the accessibility feature */
		public var menuItemArr:Array;
		
		private var _menu:Menu;
		private var _menuData:Object;
		private var _menuItems:int;
		private var _menuItemsRemaining:int;
		private var _target:Object;
		private var _newMenuObj:Object;
		private var _model:Object;
		
		private const MCR:String = "MenuController";
		private const LEFT:String = "left";
		private const GAP:String = "smtGap";
		private const STYLE1:String = "MenuItemLabelStyle1";
		private const STYLE2:String = "MenuItemLabelStyle2";
		
		private var _isAdmin:Boolean = GlobalsVO.getGlobal(GlobalsVO.ISADMIN);
			
		
		/**
		 * Build a new menu with all the components
		 * @param menu - Parent class object
		 * @param newMenuObj - New menu object to be decorated
		 */
		 
		public function InitializeMenu_View(menu:Menu,newMenuObj:Object) {
			
			menuItemArr = new Array();
			
			_menu = menu;
			_newMenuObj = newMenuObj;
			_menuData = newMenuObj.menuData;
			
			// Alias for data model
			_model = GlobalsVO.getGlobal(GlobalsVO.DATA_MODEL);
			
			/* Needed to make sure all the items have
			 * Finished loading and are ready */
			_menuItemsRemaining = _menuItems = newMenuObj.menuItems;
			
			// To place the new items into the new menu
			_target = newMenuObj.target;
			
       		// Build the menu items for the menu container
       		createContainerItems();
       		
       		/* After the menu has finished loading
			 * and is ready to display, set the
			 * position of the menu based on if
			 * the menu is a category menu or a sub-menu */		
			 
       		_menu.menuType == 0 ? new PositionMenu_View().positionDownMenu(_menu,_target) :
						      	  new PositionMenu_View().positionSideMenu(_menu,_target);
		}
		
		
		
		/**
		 * Create all the menu components
		 * that will make up the menu 
		 */
		 		
		private function createContainerItems():void {
			
			var shift:Number = 0;
			if(onSubmenuLeft()) {
				shift = Number(GlobalsVO.getCSSProperty("menuItemShift"));
			}

			var currentDataContainer:* = (_menuData.currentDataContainer) ? _menuData.currentDataContainer : _menuData[_model.menuData.name];
			// Initialize loop for menu container components
			var obj:Object;
			var processMenu:Function = function (obj:*,container:*,i:int):void {
				try {
					if ( (obj[_model.getMetaDataValue(GlobalsVO.META_LABEL)] != null) && (obj[_model.getMetaDataValue(GlobalsVO.META_BODY)] != null) ) {
						isSubMenuTitle(obj,container);
					} else if(obj[_model.getMetaDataValue(GlobalsVO.META_TYPE)] != null) {
							/* The data is required to make the Admin Tool function. 
							 * Also all the other functions calls tend to carry data 
							 * so why not this one also ? */
							
							isSeparator(obj,container); 
						} else {
							
							// Otherwise it's a menuitem
							if( (!GlobalsVO.ISLoggedOut) && (i > 0) ) {
								addSeparator();
							}
							isMenuItem(obj,shift,container);
						}
				} catch (err:Error) {}
			};
			if (currentDataContainer is Array) {
				for (var i:String in currentDataContainer) {
					obj = currentDataContainer[i];
					if (processMenu is Function) {
						processMenu(obj,currentDataContainer,int(i));
					}
				}
			} else {
				obj = _menuData[_model.menuData.name];
				if (processMenu is Function) {
					processMenu(obj,currentDataContainer,0);
				}
			}
		}
		
		
		private var _separator_F:Boolean = false;
		
		/**
		 * Before any category menus are built,
		 * the application needs to validate two
		 * things: 1) Is the displayed menu have
		 * any sub-menu arrows that point to the
		 * left?  If so the application needs to
		 * tell the menu item component this
		 * to properly adjust the arrows and
		 * text field for display purposes 
		 */
		 
		private function onSubmenuLeft():Boolean {
			var i:int = 0;
			if(_menu.hOrientation == LEFT) {
       			while(i<_menuItems) {
       				if(_menuData[_model.menuData.name][i][_model.menuData.name] != null) return true;
       				++i;
       			}
   			}
   			
   			return false;
		}
		
		
		
		
		/**
		 * Call this function every time a component
		 * for the new menu is ready 
		 * @param e
		 */
		 		
		private function onAllItemsReady(e:Event):void {
			
			/* Tell the parent class object that all
			 * components have finished loading 
			 * and are ready */
			
			if( --_menuItemsRemaining <=0) this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		
		
		
		private function addSeparator():void {
			if(_separator_F) return;
			_separator_F = true;
			var mis:MenuItemSeparator = new MenuItemSeparator();
       		_menu.container.addChild(mis);
		}
		
		
		
		
		/**
		 * Check to see if the data object
		 * has information about a graphic separator
		 */
		 
		private function isSeparator(data:*,currentDataContainer:*):void {
			var mis:MenuItemSeparator = new MenuItemSeparator();
       		mis.addEventListener(FlexEvent.CREATION_COMPLETE,onAllItemsReady);
			_menu.container.addChild(mis);
			_separator_F = true;
			
   			mis.currentData = data;

			// BEGIN: Please do not change the code found within this comment block...
   			var mcr:* = GlobalsVO.getGlobal(MCR);
   			if ( (mcr != null) && (mcr.callback_signal_initMenuItem is Function) ) {
   				try {
   					mcr.callback_signal_initMenuItem(mis,data,currentDataContainer);
   				} catch (e:Error) {}
   			}
			// END!   Please do not change the code found within this comment block...
		}
		
		
			
 	
		
		/**
		 * If there is a sub-menu menu title
		 * @param data:Object - The data model
		 * may have a Sub-Menu Title
		 */
		 
		private function isSubMenuTitle(data:Object,currentDataContainer:*):void {
			_separator_F = false;
   			_menu.subMenuTitle = new MenuText();
   			
   			/* Assign the title and text body
   			 * for the SubMenuTitle.  Get the data
   			 * by accessing the menu model get metadata item
   			 * and call the globalVO meta data tag */
   			
   			_menu.subMenuTitle.title = unescape(data[_model.getMetaDataValue(GlobalsVO.META_LABEL)]);
   			_menu.subMenuTitle.body = data[_model.getMetaDataValue(GlobalsVO.META_BODY)];
   			
   			_menu.subMenuTitle.currentData = data;
   			
   			/* Add new class component to the
   			 * menu.vBox container */
   			_menu.container.addChild(_menu.subMenuTitle);
   			
   			// Add optional space between body and separator
   			var vSpacer:Spacer = new Spacer();
   			vSpacer.height = Number(GlobalsVO.getCSSProperty(GAP));
   			vSpacer.addEventListener(FlexEvent.CREATION_COMPLETE,onAllItemsReady);
   			_menu.container.addChild(vSpacer);

			// BEGIN: Please do not change the code found within this comment block...
   			var mcr:* = GlobalsVO.getGlobal(MCR);
   			if ( (mcr != null) && (mcr.callback_signal_initMenuItem is Function) ) {
   				try {
   					mcr.callback_signal_initMenuItem(_menu.subMenuTitle,data,currentDataContainer);
   				} catch (e:Error) {}
   			}
			// END!   Please do not change the code found within this comment block...
		}
		
		
		
		
		/**
		 * If the current expected object in
		 * the data model is a menu item
		 * @param data:Object - By default
		 * the application will assume that
		 * this is a dataItem object
		 * @param shift:Number - A padding to
		 * the left to move the textField component
		 * X number of pixels that is defined in the CSS
		 * This get set if the menu hOrientation is
		 * set to the right and their is a menuitem
		 * that has a sub-menu.
		 */
		 
		private function isMenuItem(data:Object,shift:Number,currentDataContainer:*):void {
			_separator_F = false;
			// BEGIN: Please do not change the code found within this comment block...
   			var mcr:* = GlobalsVO.getGlobal(MCR);
			// END    Please do not change the code found within this comment block...

			// Otherwise, get a new menu item
   			var menuItem:MenuItem = new MenuItem();
   			
   			/* Store the list of menuitems for keyboard control
   			 * @see Accessibility */
   			menuItemArr.push(menuItem);
   			
   			// Set the label name
   			menuItem.menuItemLabel = data[_model.getMetaDataValue(GlobalsVO.META_LABEL)];
   			
   			// If category then use style1 otherwise use style2
   			_newMenuObj.categoryItem != null ? menuItem.menuItemStyle = STYLE1 :
   											   menuItem.menuItemStyle = STYLE2;
   			
   			// Set the url
			var u:String = data[_model.metaData.hash.url];
			var hasUrl:Boolean = ( (u is String) && (u.length > 0) );
			menuItem.url = (hasUrl) ? _model.getUrl(data) : null;
		
			// Add url target
			menuItem.target = data[_model.getMetaDataValue(GlobalsVO.META_TARGET)];
			var defaultTarget:String = _model.getMetaDataHash(GlobalsVO.TARGET_DEFAULT);
			menuItem.target = ( ( (menuItem.target is String) && (menuItem.target.length == 0) ) || (menuItem.target == null) ) ? defaultTarget : menuItem.target;
			
   			// Set the menu width to the new menu item container
   			menuItem.menuContainerWidth = _newMenuObj.menuContainerWidth;
			
			// Define if the text field needs to be shifted to the right
			// BEGIN: Please do not change the code found within this comment block...
   			menuItem.shift = shift + ( (mcr != null) && (mcr.callback_signal_initMenuItem is Function) ) ? 15 : 0;
   			menuItem.shift += (this._isAdmin) ? 15 : 0; // makes room for the left arrow and the icon for the Admin Tool.
			// END    Please do not change the code found within this comment block...
   			
   			// Setup a listener when the new menu item has finished rendering
   			menuItem.addEventListener(FlexEvent.CREATION_COMPLETE,onAllItemsReady);
   			menuItem.addEventListener(MouseEvent.MOUSE_OVER ,mcr.currentMenuItem);
   			menuItem.addEventListener(MouseEvent.MOUSE_OUT ,mcr.currentMenuItem);
   			
   			/* Store the current menu item data into the menu item
   			 * This is needed to build any sub-menus */
   			
   			menuItem.currentData = data;
   			
   			/* Set the current vertical and horizontal 
   			 * orientation to position the menuitem arrows */
   			
   			menuItem.vOrientation =  _model.getMetaDataValue(GlobalsVO.META_V_ORIENTATION);
   			menuItem.hOrientation = _menu.hOrientation;
   			
   			// Set the mouse over and click event for the menu item
   			menuItem.addEventListener(MouseEvent.MOUSE_OVER,_menu.selectMenuItem);
   			menuItem.addEventListener(MouseEvent.CLICK,_menu.selectMenuItem);
   			
   			// Place the new menu item in the menu container
   			_menu.container.addChild(menuItem);
   			try {
	   			var maskContainer:Canvas = _menu['mymask'];
				if ( (!GlobalsVO.ISLoggedOut) && (maskContainer != null) ) {
					_menu.container.mask = maskContainer;
				} else {
					maskContainer.visible = false;
				}
   			} catch (e:Error) {}
			
			// BEGIN: Please do not change the code found within this comment block...
   			if ( (mcr != null) && (mcr.callback_signal_initMenuItem is Function) ) {
   				try {
   					mcr.callback_signal_initMenuItem(menuItem,data,currentDataContainer);
   				} catch (e:Error) {}
   			}
			// END!   Please do not change the code found within this comment block...
		}
	}
}