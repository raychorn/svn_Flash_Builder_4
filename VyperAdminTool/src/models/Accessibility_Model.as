/*
 * Class: Accessibility
 * @author Ryan C. Knaggs
 * @since 1.0
 * @version 1.0 - RCK
 * @date 12/03/2009
 * @description: This class object is designed to
 * allow a user to interact with this
 * application by using the keyboard
 */


package models
{
	
	
	import communication.WebServices;
	
	import controller.MenuController;
	
	import flash.accessibility.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.*;
	import flash.utils.Timer;
	
	import libs.utils.ExtendedChars;
	import libs.vo.EventVO;
	import libs.vo.GlobalsVO;
	
	import mx.controls.Label;
	import mx.core.*;
	
	import mxml.CategoryItem;
	import mxml.Menu;
	import mxml.MenuItem;
	
	
	
	
	public class Accessibility_Model
	{
		
		private var loop:Timer;							// Focus iterator
		private var _menuController:MenuController;		// Menu controller
		private var _currentMenuContainer:Menu;			// Current menu container that is displayed
		private var _currentMenuItems:Array;			// Current menuitems that exist inside the menu container
		private var _currentTabbedSelection:Object = new Object();
		// Is menu open Flag
		private var _isOpen:Boolean = false;
		
		// Is menu Flag
		private var _isMenu_F:Boolean = false;
		
		// Categories
		private var _maxCategories:int;
		private var _categoryIndex:int;
		
		// Menu Items
		private var _menuItemIndex:int;
		private var _maxMenuItems:int;
		private var _forceShowMenuItem:Boolean = false;		// When user select SHIFT+TAB to advance back
		private var _tabIndex:int;
		private var _tabList:Array;
		private var _tabIsFwd:Boolean = true;
		private var _space_F:Boolean = true;
		private var _currentInstanceObject:Object;
		
		// Alias
		private const MCR:String = "MenuController";
		
		
		
		
		/**
		 * Constructor
		 */
		 
		public function Accessibility_Model() {
			_tabIndex = -1;
			resetMenu();
		}
		
		
		
		
		/**
		 * Keyboard behavior 
		 * @param key:Object
		 * @see JSInterface
		 */
		 		
		public function keySelect(key:Object):void {
			
			/* This class object MUST be referenced after
			 * Everything has initialized.  Don't place this
			 * in the constructor of this class object
			 * otherwise it will be null */
			
			if(this._menuController == null) {
				
				//trace("get tablist");
				_tabList = GlobalsVO.accessableTabList;
				
				// Get MenuController
				_menuController = MenuController(GlobalsVO.getGlobal(MCR));
				
				/* Setup Listener on menu controller 
				 * when a new menu has invoked */
				 try {
					_menuController.addEventListener(EventVO.NEWMENU,onMenuController);
					} catch(e:Error) {
						return;
					}
				
				/*  Set the max number of menu 
				 * categories to work with */
				try {
					_maxCategories = _menuController.createMenuBar.getCategories().length;
				} catch(e:Error) {
					_maxCategories = 0
				}
				
			}

			/* Determine what key from 
			 * keyboard was pressed */
			 
			switch(key.keyCode) {
				// Tab key
				case 9:
					_tabIsFwd = !key.isShift
					onTab();
				break;
				
				// Spacebar
				case 32:
					navigateURL();
				break;
				
				// Left Arrow
				case 37:
					_menuItemIndex = -1;
					onCategory(false);	
				break;
				
				// Up Arrow
				case 38:	
					onMenuItem(false);
				break;
				
				// Right Arrow
				case 39:
					_menuItemIndex = -1;
					onCategory(true);
				break;
				
				// Down Arrow
				case 40:	
					onMenuItem(true);
				break;
			}
		}
		
		
		
		
		/**
		 * Menu controller available 
		 * @param e
		 */
		 	
		public function onMenuController(e:Event):void {
			
			/* If the Menu Controller dispatched
			 * then setup a listener for a new menu
			 * This is needed to access all then resources
			 * for the new created menu */
			 
			if(e.currentTarget is MenuController) {
				_currentMenuContainer = e.currentTarget._childObject as Menu;
				_currentMenuContainer.addEventListener(EventVO.ONMENULOAD,onNewMenu);
			}
		}
		
		
		
		
		
		/**
		 * If the user selected the TAB key 
		 * @param _tabIsFwd
		 */
		 		
		private function onTab():void {
			
			// If menu not opened
			if(!_isMenu_F) {
				_tabIndex += _tabIsFwd ? 1 : -1;
			}
			
			if(_tabIndex >= GlobalsVO.INIT_TAB_MENUBAR && _maxCategories > 0) {
				_isMenu_F = true;
				unFocusHeader();
				onTabMenu(_tabIsFwd);
			} else {
				if(_isOpen) {
					resetMenu();
				}
				focus();
			}
		}
		
		
		
		
		/**
		 * Initialize the Menu
		 * for positioning purposes
		 */
		 	
		private function resetMenu():void {
			_categoryIndex = -1;
			_menuItemIndex = -1;
			try {
				_menuController.deleteChildrenObjects();
				_isOpen = false;
			} catch(e:Error){}
			
		}
		
		
		
		
		
		
		/**
		 * After the menu is finished being constructed
		 * and is ready, then you can get reference to 
		 * all of the menu's public accessed objects
		 * @param e:Event - Current menu reference of the
		 * newly created menu that has displayed on the stage
		 */
		 
		public function onNewMenu(e:Event):void {
			
			/* If new menu selected, then set this flag
			 * Needed for onTab method */
			_isOpen = true;
			
			/* At this point, you have all references to
			 * all public object that are inside the
			 * Menu.mxml object.
			 * The menuInitializer holds on to all of the
			 * menuitems that are inside the current menu
			 * container
			 * @see view.InitializeMenu_View.as */
			 
			 // Menu Items Array Reference
			_currentMenuItems = e.currentTarget.menuInitializer.menuItemArr;
			
			// Max Number of Menu Items
			_maxMenuItems = _currentMenuItems.length;
			
			// Clean Up
			_currentMenuContainer.removeEventListener(EventVO.ONMENULOAD,onNewMenu);
			
			/* If the user selects SHIFT+TAB while
			 * using the menu and the menu is about to
			 * go to the previous category */
			if(_forceShowMenuItem) {
				_forceShowMenuItem = false;
				_menuItemIndex = _maxMenuItems-1;
				menuItemSelect();
			}
		}
		
		
		
		
		
		/**
		 * Required to fix a bug with Flex focus to
		 * properly focus on the correct asset 
		 */
		 		
		private function focus():void {
			
			if(loop != null) {
				loop.stop();
				loop = null;
			}
			
			if(loop == null) {
				loop = new Timer(10,1);
				loop.addEventListener(TimerEvent.TIMER,onHeaderFocus);
				loop.start();
			}
		}
		
		
		
		
		/**
		 * Verify if the next item to tab
		 * exists.  If not the check to see
		 * if the next or previous one exists
		 * @return:Object - Display Object
		 * to set focus 
		 */
		 		
		private function validateTab():Object {
			var i:int;
			var instance:Object;
			_currentInstanceObject = instance = getTabObjectByPriority(_tabIndex);
			//trace("\n\n_currentInstanceObject: "+_currentInstanceObject);
			

			/* If the Flex components want to respond based on focus
			 * such as a button and you do not wish for that class
			 * to react, then you need to set something in the class
			  to respond or not */
			if(instance == null) {
				
				// Check if no more items in header to tab through
				if(_tabIndex >= _tabList.length) {
					_tabIndex == GlobalsVO.INIT_TAB_MENUBAR;
					if(_maxCategories <=0) {
						exitFocus();
					} else {
						onTab();
					}
				}
				// Tab is forward
				if(_tabIsFwd) {
					for(i=_tabIndex;i<_tabList.length;++i) {
						_tabIndex++;
						instance = getTabObjectByPriority(_tabIndex);
						//trace("3 loop validateTab: "+_tabIndex);
						if(instance != null) {
							return instance;
						}
					}	
				// Otherwise Backwards
				} else {
					for(i=_tabList.length;i>0;--i) {
						_tabIndex--;
						instance = getTabObjectByPriority(_tabIndex);
						if(instance != null) {
							return instance;
						}
					}	
				}
			}
			
			return instance;
		}
			
				
		
		
		
		/**
		 * Navigate to the current selection
		 * from one of the items in the header
		 * or the menu
		 */
		
		private function navigateURL():void {
			/* If user is focued on the search field
			 * and presses the space bar while entering
			 * in a word, skip navigateURL */
			if(_currentInstanceObject.toString().toLowerCase().indexOf("searchfield") > -1) return;
 			
 			if(_currentTabbedSelection.value == null || _currentTabbedSelection.value == undefined) return;
 			//trace("Selected URL: "+_currentTabbedSelection.value,_currentTabbedSelection.target);
			WebServices.navigateToUrl(_currentTabbedSelection.value,_currentTabbedSelection.target);
		}
		
		
		
		
		
		
		
		
		
		/**
		 * Set focus on an asset only for header 
		 * @param e	
		 */
		 		
		private function onHeaderFocus(e:TimerEvent):void {
			var instance:Object = validateTab();
			try {
				instance.setFocus();
            	instance.drawFocus(true);
            	talk(instance.parentDocument.getDataByAccessibility(instance));
            	
			} catch(e:Error) {}
		}
		
		
		
		/**
		 * Converts HTML stuff back to a talkable word
		 * such as &amp; 
		 * @param str
		 * @return 
		 */
		 				
		private function convertHTMLtoWord(str:String):String {
			return new ExtendedChars().convertWord(str);
		}
		
		
		
		
		
		
		private function talk(valueObj:Object=null):void {
			//trace("talk: "+valueObj);
			
			/* for(var i:Object in valueObj) {
				trace("i: "+i+" valueObj[i]: "+valueObj[i]);
			} */
			var vo:String = new String();
			try {
			 	vo = valueObj.component.toString();
			} catch(e:Error) {
				vo = "";
			}
			trace("\n####################vo: "+vo);
			
			if(vo.indexOf("searchField") > -1) {
				//trace("######## 1");
				ExternalInterface.call("focusMe",1);
			} else {
				//trace("######## 0");
				ExternalInterface.call("focusMe",0);
			}
			GlobalsVO.getGlobal(GlobalsVO.JSINTERFACE).talk(convertHTMLtoWord(valueObj.name));
			
			/* Set current URL when the user selects
			 * the spacebar */
			_currentTabbedSelection = valueObj;
		}
		
		
		
		
		
		/**
		 * Get the displayObject based on the index 
		 * @param index
		 * @return 
		 */
		 		
		private function getTabObjectByPriority(index:int):* {
			for(var i:int=0; i<_tabList.length; ++i) {
				try{
					if(_tabList[i].tabOrder == index) {
						return _tabList[i].displayObject;
					}
				} catch(e:Error) {}
			}
			
			return null;
		}
		
		
		
		
		
		
		/**
		 * Stop showing focus on items
		 * in the header bar 
		 */
		 		
		private function unFocusHeader():void {
			
			for(var i:int = 0; i< GlobalsVO.INIT_TAB_MENUBAR; ++i) {
				try {
					getTabObjectByPriority(i).drawFocus(false);
				} catch(e:Error) {}
			}
			
			/* The last option is the search button
			 * the setfocus needs to stop focusing on the
			 * search button, if the user decides to tab
			 * to the menu categories and menuitems.
			 * You simply can't unfocus from the current focused
			 * object.  Instead, you need to focus on a new object*/
			var label:Label = new Label();
			var instance:Object = FlexGlobals.topLevelApplication.addChild(label);
			label.setFocus();
			FlexGlobals.topLevelApplication.removeChild(instance);
		}
		
		
		
		
		
		
		/**
		 * If the "Tab" key was selected 
		 * @param isForward:Boolean
		 */
		 		
		private function onTabMenu(isForward:Boolean):void {
			// Tab key advance by one
			if(isForward) {
				
				// If menu is open
				if(_isOpen) {
					
					/* If the menu item index exceeds max menuitems 
					 * for the current menu container */
					
					if(_menuItemIndex >=_maxMenuItems-1) {
						onCategory(true);
					} else {
						// Tab forward and go to the next menuitem below
						onMenuItem(true);
					}
				} else {
					// If first time menu open from tab key
					onCategory(true);		
				}
			} else {
				// If menu is open
				if(_isOpen) {
					// If menu item index is at the top
					if(_menuItemIndex <=0) {
						/* If the first category is displayed
						 * SHIFT+TAB was selected
						 * then go back to the header */
						if(_categoryIndex <= 0) {
							_isMenu_F = false;
							resetMenu();
							_tabIsFwd = false;
							onTab();
							return;
						}
						
						// Display Menu item in last row for previous menu show
						_forceShowMenuItem = true;		
						onCategory(false);
					} else {
						onMenuItem(false);
					}
				} else {
					onCategory(false);		// If first time menu open from tab key
				}
			}
		}
		
		
		
		
		
		
		/**
		 * Advance new category 
		 * @param isRight
		 */
		 		
		private function onCategory(isRight:Boolean):void {
			
			// If the menubar is blank
			if(_maxCategories <= 0) exitFocus();
			
			// Assume that the menu is closed
			_isOpen = false;
			
			// If Left or Right Arrow key
			if(isRight) {
				_categoryIndex++;
				_menuItemIndex = -1;
			} else { 
				_categoryIndex--;
			}

			if(_categoryIndex == -1) {
				_categoryIndex = 0;
			}
			
			// If last category reach, then repeat
			if(_categoryIndex >= _maxCategories) {
				exitFocus();
				_categoryIndex = 0;
				return;
			} 

			var instance:CategoryItem = _menuController.createMenuBar.getCategoryRef(_categoryIndex) as CategoryItem;
			_menuController.newCategory(null,instance);
			talk(instance.getDataByAccessibility(instance));
		}
		
		
		
		
		/**
		 * Select the current menuitem from the
		 * current menu container 
		 */
		 		
		private function menuItemSelect():void {
			// Call the Menu.mxml container and select a menuitem
			var instance:MenuItem = _currentMenuItems[_menuItemIndex] as MenuItem;
			_currentMenuContainer.selectMenuItem(null,instance);
			talk(instance.getDataByAccessibility(instance));
		}
		
		
		
		
		
		/**
		 * Send focus back to the JS container 
		 */
		 		
		public function exitFocus():void {
			//trace("exitFocus");
			resetMenu();
			
			try {
				GlobalsVO.getGlobal(GlobalsVO.JSINTERFACE).tabOut();
			} catch (e:Error) {}
		}
		
		
		
		/**
		 * Advance the menuitem 
		 * @param isDown:Boolean
		 */
		 		
		private function onMenuItem(isDown:Boolean):void {
			
			// If menu is not open then ignore
			if(!_isOpen) return;
			
			// If isDown then advance down
			isDown ? _menuItemIndex++ : _menuItemIndex--;
			
			// If first menuitem and up then goto the last menuitem
			if(_menuItemIndex < 0) _menuItemIndex = _maxMenuItems-1;
			
			// If the last menuitem and down then goto the first menuitem
			if(_menuItemIndex >= _maxMenuItems) _menuItemIndex = 0;
			menuItemSelect();
		}
	}
}