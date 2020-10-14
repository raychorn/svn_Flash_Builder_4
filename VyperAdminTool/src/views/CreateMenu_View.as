/*
 * Class: AssembleMenu
 * @author Ryan C. Knaggs
 * @since 1.0
 * @version 1.2 - RCK
 * @date 10/06/2009
 * @description: The class will assemble a new menu
 * to display on the stage.
 *
 * @see mxml.Menu, mxml.MenuItem, mxml.Separator
 */

package views
{
	import vzw.menu.builder.MenuController;
	
	import flash.events.EventDispatcher;
	
	import libs.vo.GlobalsVO;
	
	import mx.events.FlexEvent;
	
	import mxml.Menu;
	
	
	
	public class CreateMenu_View extends EventDispatcher
	{
		
		
		private const CATEGORY_MENU:int = 0;
		private const SUBMENU_MENU:int = 1;

		/**
		 * Constructor
		 */
		 
		public function CreateMenu_View() {
		}
		
		
		
		
		/**
		 * 
		 * @param target
		 * @param menuData
		 * @param menuType - Menu type is the type of menu to display
		 * 					 0 - CategoryMenu, 1 - Side SubMenu
		 */
		 
		public function createNewMenu(obj:Object):Object {
			
			var model:Object = GlobalsVO.getGlobal(GlobalsVO.DATA_MODEL);
			var dataType:* = obj.menuData[model.menuData.name];
       		
       		// Check to see if there are any menu items to build the menu
       		if(dataType is Array) {        		
       			obj.menuItems = dataType.length;
       		}
       		// If no menu items then don't create a new menu
       		if(obj.menuItems == 0) return null;
			var menu:Menu;
			menu = new Menu();
			menu.preInit(obj);
			
			/* Did the request come from a selected Category? If so,
			 * Then tell the new menu type to be a category menu, 
			 * so it can be positioned later on */
			 
			if(obj.categoryItem != null) {
				menu.menuType = CATEGORY_MENU;
				menu.parentRef = obj.categoryItem;
			} else {
				menu.parentRef = obj.parentMenu;
				if(obj.selectedMenuItem != null) {
					menu.parentRef.selectedMenuItem = obj.selectedMenuItem;
				}
				menu.menuType = SUBMENU_MENU;
			}
			var _this:* = this;
			menu.addEventListener(FlexEvent.CREATION_COMPLETE,function (event:FlexEvent):void {
				if (MenuController.createdMenu_callback is Function) {
					try { MenuController.createdMenu_callback(event.currentTarget) } catch (err:Error) {}
				}
			});
			return menu;
		}
	}
}