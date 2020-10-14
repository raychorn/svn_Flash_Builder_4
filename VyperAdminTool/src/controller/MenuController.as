/*
 * Class: MenuController
 * @author Ryan C. Knaggs
 * @since 1.0
 * @date 08/14/2009
 * @version 1.1 - RCK
 * @date 12/03/2009
 * @version 1.5 - RCK
 * @description: This is the main controller for 
 * the menu bar and menu's
 * All presentation logic is handled in this class.
 */

package controller
{
	
	import vzw.utils.ArrayUtils;
	import vzw.utils.ObjectUtils;
	
	import communication.WebServices;
	
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.utils.getTimer;
	
	import libs.InteractionTimeOut;
	import libs.utils.ErrorMessages;
	import libs.vo.EventVO;
	import libs.vo.GlobalsVO;
	
	import models.Menu_Model;
	
	import mx.controls.Image;
	import mx.managers.PopUpManager;
	
	import mxml.CategoryItem;
	import mxml.Menu;
	import mxml.MenuBar;
	import mxml.MenuItem;
	import mxml.header.HomeButton;
	import mxml.header.LoginState;
	
	import views.CreateMenuBar_View;
	import views.CreateMenu_View;
	
	
	

	public class MenuController extends EventDispatcher
	{
		// BEGIN: Please do not change the code found within this comment block...
		public var createMenuBar:CreateMenuBar_View;		// To assemble a menu bar with categories
		public var callback_signal_initMenuItem:Function;
		public var callback_signal_initMenuData:Function;
		public var _childObject:Object;					// Child menu object
		
		public var isAdminTool:Boolean = false;			// this is supplied by the Admin Tool...
		// END!   Please do not change the code found within this comment block...
		
		private var _g:Object;
		private var _menuModel:Menu_Model;					// Menu Data Model
		private var _menuBarContainer:MenuBar;				// Menu Bar
		private var _selectedCategoryItem:*; 	// Store the previous Category Object
		private var _timeOut:InteractionTimeOut;			// This Object's Child Object
		private var _maxHeight:Number=0;					// To keep the last known max height for the DIV
		private var _currentMenuItem:MenuItem;				// Current selected menu item
		private var _menuPresent:Boolean;					// If a menu is present
		private var _cCategory:Object = null;
		
		private const LOADSTATE:String = "ONLOAD";
		private const MBC:String = "MenuBarContainer";
		private const MCR:String = "MenuController";
		private const MITO:String = "menuInteractionTimeOut";
		private const MBH:String = "menuBarHeight";
		
		private var _fakeMenuImages:Array = [];
		
        [Bindable]
        public var onMouseOverCategory_callback:Function;
        
        [Bindable]
        public var onMouseClickCategory_callback:Function;

        [Bindable]
        public var onMouseClickHomeButton_callback:Function;

        [Bindable]
        public var onMouseClickUserName_callback:Function;

        [Bindable]
        public var onMouseOverMenu_callback:Function;
        
        [Bindable]
        public var onMouseOverMenuItem_callback:Function;
        
        [Bindable]
        public var onMouseOverMenuItemSeparator_callback:Function;
        
        [Bindable]
        public var onMouseOverMenuBody_callback:Function;

        [Bindable]
        public var onMouseOutMenuBody_callback:Function;

        [Bindable]
        public var onMouseClickMenuItem_callback:Function;

        [Bindable]
        public var onMouseClickMenuBody_callback:Function;
        
        [Bindable]
        public var onMouseClickMenuLogo_callback:Function;
        
        [Bindable]
        public var onMouseClickMenuLOB_callback:Function;
        
        [Bindable]
        public var onMouseClickMenuSearch_callback:Function;
        
        [Bindable]
        public var onMouseClickMenuLocation_callback:Function;
        
        [Bindable]
        public var onMouseClickMenuGLinks_callback:Function;
        
        [Bindable]
        public var onMouseClickMenuGLinkRoot_callback:Function;
        
        [Bindable]
        public var onMouseClickMenuShoppingCart_callback:Function;
        
        [Bindable]
        public var onMouseClickMenuHome_callback:Function;
        
		/**
		 * Constructor
		 */
		
		public function MenuController() {
		}
		
		
		
		/**
		 * Initialization
		 */
		
		public function init():void {
			if (GlobalsVO.ISLoggedOut == true) {
				this.init_LoggedOut();
			} else {
				this.init_LoggedIn();
			}
		}
		
		
		
		
		/**
		 * Getter for the Admin Tool because it seems to require the information before the GlobalsVO knows about it...
		 */
		public function get menuModel():Menu_Model {
			return this._menuModel;
		}
		
		
		
		
		public function init_LoggedIn():void {
			_g = GlobalsVO;
			 
			 // Get the data model from the static class
			_menuModel = Menu_Model(_g.getGlobal(_g.DATA_MODEL));
			
			/* Set user mouse away from menus
			 * user interactivity */
			var _this:Object = this;
			var removeAllMenus:Function = function(e:TimerEvent):void {
				//if (_this.isAdminTool == false) {
					_this.deleteChildrenObjects();
					_cCategory = null;
				//}
			}
			 _timeOut = new InteractionTimeOut((isAdminTool) ? 2000 : int(_g.getCSSProperty(MITO)),removeAllMenus);
			
			// Create a new menu bar
			createMenuBar = new CreateMenuBar_View();


			// Get the headerBar container
			var hc:Object = _g.getGlobal("HeaderContainer");
			
			// Get the menuBar Class
			_menuBarContainer = new MenuBar();
			
			/* Since the style of the menu has changed
			 * and the menubar needs to be in the header
			 * then addChild of the menubar
			 * to the header container */
			hc.header.addChild(_menuBarContainer);
			
			// Store the menuBar container in GlobalsVO
			_g.setGlobal(MBC,_menuBarContainer);
			
			// Position the menu under the header bar
			this._menuBarContainer.verticalScrollPolicy = "off";
			this._menuBarContainer.horizontalScrollPolicy = "off";

			// Set reference to this Menu Controller
			_g.setGlobal(MCR,this);
			
			// Start Menu Applicatoin Component
			onMenuData();
			
			_menuBarContainer.x = Number(GlobalsVO.getCSSProperty("menuBarXPos"));
		}
		
		
		
		
		
		public function init_LoggedOut():void {
			_g = GlobalsVO;
			 
			 // Get the data model from the static class
			_menuModel = Menu_Model(_g.getGlobal(_g.DATA_MODEL));
			
			/* Set user mouse away from menus
			 * user interactivity */
			var _this:Object = this;
			var removeAllMenus:Function = function(e:TimerEvent):void {
				if (_this.isAdminTool == false) {
					_this.deleteChildrenObjects();
					_cCategory = null;
				}
			}
			 _timeOut = new InteractionTimeOut((isAdminTool) ? 2000 : int(_g.getCSSProperty(MITO)),removeAllMenus);
			
			// Setup the target
			var target:Object = _g.getGlobal(_g.APPLICATION);
			
			// Get a new menubar
			_menuBarContainer = new MenuBar();

			// Add menubar to the target
			target.addChild(_menuBarContainer);

			// Set the menubar as a global reference
			_g.setGlobal(MBC,_menuBarContainer);
			
			// Create a new menu bar
			createMenuBar = new CreateMenuBar_View();
			
			// Position the menu under the header bar
			var hc:Object = _g.getGlobal("HeaderContainer");
			this._menuBarContainer.y = hc.y + Number(_g.getCSSProperty("headerHeight"));
			
			// Set reference to this Menu Controller
			_g.setGlobal(MCR,this);
			
			// Start Menu Applicatoin Component
			onMenuData();
		}
		
		
		
		
		
		
		/**
		 * Build a new menubar with categories
		 * @param e:Event - Not used
		 * @return void
		 */		
		
		public function onMenuData():void {
			if (this.callback_signal_initMenuData is Function) {
				try {
					this.callback_signal_initMenuData(this);
				} catch (e:Error) {
				}
			}

			// If string of gnDisplay is "0" then don't display the menu categories
			if(String(_g.getGlobal(_g.EXTERNALVARS)[_g.GN_DISPLAY]) == "0") return;
			
			createMenuBar.init(onCategoryItem);
			//createMenuBar.setStaticCategory(int(_g.getGlobal(_g.EXTERNALVARS)[_g.STATICCATEGORY])-1);
			
			/* Call a JS function to get the category
			 * This has been modified due to the JS container
			 * not sending the integer value to this application
			 * through the flash var in time */
			createMenuBar.setStaticCategory(int(GlobalsVO.getGlobal("gnCategory"))-1);
			
			// BenchMark
			GlobalsVO.benchMark = getTimer() - GlobalsVO.bStart;
			
			if(GlobalsVO.status < 0) {
				ExternalInterface.call("flexReady", GlobalsVO.status);
			} else {
				ExternalInterface.call("flexReady", GlobalsVO.benchMark);
			}
			
		}
		
		
		
		
		/**
		 * Build a new menubar with categories
		 * @return void
		 */		
		
		public function deleteAndRemoveAllMenuChildren():void {
			this.deleteChildrenObjects();
			_g.getGlobal(MBC).menuBar.removeAllChildren();
		}
		
		
		
		
		
		/**
		 * Delete all child objects
		 * from this object
		 */
		 
		public function deleteChildrenObjects():void {
			if(_childObject == null) return;
			_childObject.deleteChildrenObjects();
			_childObject.hideMenu();
			setExternalContainerHeight(_g.getMaxHeight());
			this._selectedCategoryItem.onMouseOut();
			_menuPresent = false;
		}
		
		
		public function dismissChildrenObjects():void {
			if(_childObject == null) return;
			_childObject.hideMenu();
			setExternalContainerHeight(_g.getMaxHeight());
			this._selectedCategoryItem.onMouseOut();
			_menuPresent = false;
		}
		
		public function ignoreMenuEvents():void {
			if(_childObject == null) return;
			_childObject.ignoreEvents = true;
		}
		
		public function fakeMenuImage(img:Image):void {
			if (img is Image) {
				this._fakeMenuImages.push(img);
			}
		}
		
		public function dismissFakeMenuImages():void {
			var img:Image;
			var app:* = GlobalsVO.getGlobal(GlobalsVO.APPLICATION);
			//trace('MenuController.dismissFakeMenuImages().1 --> app='+app);
			if (app != null) {
				//trace('MenuController.dismissFakeMenuImages().2 --> this._fakeMenuImages.length='+this._fakeMenuImages.length);
				while (this._fakeMenuImages.length > 0) {
					img = this._fakeMenuImages.pop();
					//trace('MenuController.dismissFakeMenuImages().3 --> img='+img);
		        	if (img is Image) {
						//trace('MenuController.dismissFakeMenuImages().4 --> app.removeChild !');
						app.removeChild(img);
		        	}
				}
			}
		}
		
		
		/**
		 * The menu object will reference the
		 * current category to get the proper data 
		 * @return 
		 */
		 	
		public function get selectedCategoryItem():* {
			return _selectedCategoryItem;
		}
		
		
		
		
		/**
		 * If the user has their mouse over
		 * the menu the reset the timeout
		 * otherwise start the timeout clock 
		 * @param e:MouseEvent
		 */
		 		
		public function onMenu(e:MouseEvent):void {
			switch(e.type) {
				case MouseEvent.MOUSE_OVER :
					/* If user mouseover then reset
					 * the timer */
					 if (this.onMouseOverMenu_callback is Function) {
					 	this.onMouseOverMenu_callback(e.currentTarget);
					 }
					 if (!isAdminTool) {
						_timeOut.setTimeOut(e);
					 }
				break;
				
				case MouseEvent.MOUSE_OUT :
					/* If user mouseout then start
					 * the timer */
					 if (!isAdminTool) {
						_timeOut.setTimeOut(e);
					 }
				break;
			}			
		}
		
		
		
		
		/**
		 * If logged In menu and user select LoginState 
		 * @param e
		 */
		 		
		public function onHomeButton(e:MouseEvent):void {
			//trace('onHomeButton().0 e='+e);
			switch(e.type) {
				case MouseEvent.MOUSE_OVER :
					try {
						//trace('onHomeButton().1 e.target='+e.target);
						if(e.target.toString().indexOf("HomeButton") > -1) {
							//trace('onHomeButton().2 e.currentTarget='+e.currentTarget);
							if(_cCategory != e.currentTarget) {
								_cCategory = e.currentTarget;
								newCategory(e);
								_timeOut.setTimeOut(e);
							} else {
								_timeOut.setTimeOut(e);
								_currentMenuItem.onMouseOut();
							}
						}
					} catch(e:Error) {}
				break;
				
				case MouseEvent.MOUSE_OUT :
					_timeOut.setTimeOut(e);
				break;
				
				case MouseEvent.CLICK :
					if (this.onMouseClickHomeButton_callback is Function) {
						this.onMouseClickHomeButton_callback(e.currentTarget);
					}
					//buildURL(e);
				break;
			}
		}
		
		
		
	
		/**
		 * If logged In menu and user select LoginState 
		 * @param e
		 */
		 		
		public function onUserName(e:MouseEvent):void {
			switch(e.type) {
				case MouseEvent.MOUSE_OVER :
					try {
						if(e.target.toString().indexOf("userNameVBox") > -1) {
							if(_cCategory != e.currentTarget) {
								_cCategory = e.currentTarget;
								newCategory(e);
								 if (!isAdminTool) {
									_timeOut.setTimeOut(e);
								 }
							} else {
								 if (!isAdminTool) {
									_timeOut.setTimeOut(e);
								 }
								_currentMenuItem.onMouseOut();
							}
						}
						// If _cCatgory is null
					} catch(e:Error) {}
				break;
				
				case MouseEvent.MOUSE_OUT :
					 if (!isAdminTool) {
						_timeOut.setTimeOut(e);
					 }
				break;
				
				case MouseEvent.CLICK :
					if (this.onMouseClickUserName_callback is Function) {
						this.onMouseClickUserName_callback(e.currentTarget);
					}
					buildURL(e);
				break;
			}
		}
		
		private function onNewCategory():void {
			this.dismissFakeMenuImages();
		}
		
		
		/**
		 * When the user clicks a main menu category item
		 * @param e:MouseEvent - The current selected
		 * category event.
		 */
		
		private function onCategoryItem(e:MouseEvent):void {
			
			switch(e.type) {
				// If the user moves their mouse into the cateogry item
				case MouseEvent.MOUSE_OVER :
					try {
						if(e.target.toString().indexOf("categoryWrapper") > -1) {
							if(_cCategory != e.currentTarget) {
								_cCategory = e.currentTarget;
								newCategory(e);
								this.onNewCategory();
								if (this.onMouseOverCategory_callback is Function) {
									this.onMouseOverCategory_callback(_cCategory);
								}
							} else if (!isAdminTool) {
								_timeOut.setTimeOut(e);
								_currentMenuItem.onMouseOut();
							}
						}
						// If _cCatgory is null
					} catch(e:Error) {trace('### onCategoryItem().ERROR --> e='+e.toString()+'\n'+e.getStackTrace());}
				break;
				
				case MouseEvent.MOUSE_OUT :
					if (!isAdminTool) {
						_timeOut.setTimeOut(e);
					}
				break;
				
				// If the user selects a category or menuitem
				case MouseEvent.CLICK :
					if (this.onMouseClickCategory_callback is Function) {
						this.onMouseClickCategory_callback(e,e.currentTarget);
					}
					//buildURL(e);
				break;
			}
		}


		private var _headerMenu:String = null;
		
		/**
		 * Create a new category item either
		 * by a mouse event or keyboard event 
		 * @param e
		 * @param categoryItem
		 */
		 
		public function newCategory(e:MouseEvent,categoryItem:CategoryItem=null):void {
			
			var classObj:* = (e == null) ? e : e.currentTarget.document;
			
			if ((classObj is LoginState || classObj is HomeButton) && !GlobalsVO.ISLoggedOut) {
				if (classObj is LoginState) {
					_headerMenu = "welcome";
					onLoginCategory(classObj);
				} else if (classObj is HomeButton) {
					_headerMenu = "home";
					onHomeCategory(classObj);
				}
			} else {
				if(categoryItem == null) {
					createCategory(e.currentTarget as CategoryItem);
					_timeOut.setTimeOut(e);
				} else {
					createCategory(categoryItem);
				}
			}
		}
		
		
		
		
		
		/**
		 * This is the business logic for
		 * this application.  The business logic is
		 * used to give this application the type
		 * of behavior.
		 * @param e:MouseEvent
		 */
		 		
		private function onLoginCategory(item:*):void {
			
			/* If the user moves the mouse to quickly
   			 * then remove the menu with no effects */
   			if(_childObject != null) {
   				if(_childObject.getState() < _childObject.getStatebyName(LOADSTATE)) {
   					_childObject.interrupt = true;
   					PopUpManager.removePopUp(_childObject as Menu);
   				}
   			}
   			
   			// Remove highlight from all category items
   			createMenuBar.deSelectAll();
   		
   			// If previous selected category is not null invoke mouseout
   			if(_selectedCategoryItem!=null) _selectedCategoryItem.onMouseOut();
   			
   			// Set to selected category item
   			_selectedCategoryItem = item;
   			
   			// Remove all existing menu objects
   			deleteChildrenObjects();
   			
   			// Create a new menu
   			createLoginMenu();
   			
   			// Set the new selected category item to mouseover state
   			_selectedCategoryItem.onMouseOver();
		}
		
		private function onHomeCategory(item:*):void {
			
			/* If the user moves the mouse to quickly
   			 * then remove the menu with no effects */
   			if(_childObject != null) {
   				if(_childObject.getState() < _childObject.getStatebyName(LOADSTATE)) {
   					_childObject.interrupt = true;
   					PopUpManager.removePopUp(_childObject as Menu);
   				}
   			}
   			
   			// Remove highlight from all category items
   			createMenuBar.deSelectAll();
   		
   			// If previous selected category is not null invoke mouseout
   			if(_selectedCategoryItem!=null) _selectedCategoryItem.onMouseOut();
   			
   			// Set to selected category item
   			_selectedCategoryItem = item;
   			
   			// Remove all existing menu objects
   			deleteChildrenObjects();
   			
   			// Create a new menu
   			createHomeMenu();
   			
   			// Set the new selected category item to mouseover state
   			_selectedCategoryItem.onMouseOver();
		}
		
		
		/**
		 * Create a new menu 
		 * @param menu - Child object is to call
		 * this function if there are some problems
		 * with the menu creation, otherwise
		 * this class object will create a new menu object
		 */
		public function isEmptyHeaderDataHomeObject(headerData:*):Boolean {
			var x:String = _menuModel.getMetaDataHash('uuid');
			var keys:Array = [];
			var _keys:Array = ObjectUtils.keys(headerData);
			var fileterOut_x:Function = function (anItem:Object):Boolean { return anItem != x; };
			if (headerData is Array) {
				for (var i:String in headerData) {
					ArrayUtils.addAllInto(keys,ObjectUtils.keys(headerData[i]), fileterOut_x);
				}
			} else if ( (_keys is Array) && (_keys.length > 0) ) {
				ArrayUtils.addAllInto(keys,_keys, fileterOut_x);
			} else {
				return false;
			}
			return ( (keys is Array) && (keys.length == 0) );
		}
		
		public function createLoginMenu(menu:Menu=null):void {
			if(menu != null) PopUpManager.removePopUp(menu);
			
			var menuData:Object = new Object();
			var headerData:* = _menuModel.getHeaderData(_headerMenu);
			var isEmptyDataObject:Boolean = this.isEmptyHeaderDataHomeObject(headerData);
			menuData[_menuModel.menuData.name] = _menuModel.getHeaderData(_headerMenu);
			
			/* Create a new menu Object, this _childObject
			 * is the Menu.mxml reference for this class object */
			if (!isEmptyDataObject) {
	       		_childObject = new CreateMenu_View().createNewMenu( { 
	       			  categoryItem:_selectedCategoryItem, target:_menuBarContainer.parent,
	       			  menuData:menuData } );
	       			  
	       		dispatchEvent(new Event(EventVO.NEWMENU));
			}
       			  
		}
		
		
		public function createHomeMenu(menu:Menu=null):void {
			if(menu != null) PopUpManager.removePopUp(menu);
			
			var menuData:Object = new Object();
			var headerData:* = _menuModel.getHeaderData(_headerMenu);
			var isEmptyDataObject:Boolean = this.isEmptyHeaderDataHomeObject(headerData);
			menuData[_menuModel.menuData.name] = _menuModel.headerData.data.home[_menuModel.headerData.name];
			menuData['currentDataContainer'] = _menuModel.headerData.data.home;
			
			/* Create a new menu Object, this _childObject
			 * is the Menu.mxml reference for this class object */
			if (!isEmptyDataObject) {
	       		_childObject = new CreateMenu_View().createNewMenu( { 
	       			  categoryItem:_selectedCategoryItem, target:_menuBarContainer.parent,
	       			  menuData:menuData } );
	       			  
	       		dispatchEvent(new Event(EventVO.NEWMENU));
			}
       			  
		}
		
		
		/**
		 * This is the business logic for
		 * this application.  The business logic is
		 * used to give this application the type
		 * of behavior.
		 * @param e:MouseEvent
		 */
		 		
		private function createCategory(categoryItem:CategoryItem):void {
			
			/* If the user moves the mouse to quickly
   			 * then remove the menu with no effects */
   			if(_childObject != null) {
   				if(_childObject.getState() < _childObject.getStatebyName(LOADSTATE)) {
   					_childObject.interrupt = true;
   					PopUpManager.removePopUp(_childObject as Menu);
   				}
   			}
   			
   			// Remove highlight from all category items
   			createMenuBar.deSelectAll();
   		
   			// If previous selected category is not null invoke mouseout
   			if(_selectedCategoryItem!=null) _selectedCategoryItem.onMouseOut();
   			
   			// Set to selected category item
   			_selectedCategoryItem = categoryItem;
   			
   			// Remove all existing menu objects
   			deleteChildrenObjects();
   			
   			// Create a new menu
   			createMenu();
   			
   			// Set the new selected category item to mouseover state
   			_selectedCategoryItem.onMouseOver();
		}
		
		
		
		
		/**
		 * Create a new menu 
		 * @param menu - Child object is to call
		 * this function if there are some problems
		 * with the menu creation, otherwise
		 * this class object will create a new menu object
		 */
		 		
		public function createMenu(menu:Menu=null):void {
			if(menu != null) PopUpManager.removePopUp(menu);
			
			var menuData:Object = _menuModel.menuData.data[_selectedCategoryItem.document.categoryPosition];
			
			/* Create a new menu Object, this _childObject
			 * is the Menu.mxml reference for this class object */
       		_childObject = new CreateMenu_View().createNewMenu( { 
       			  categoryItem:_selectedCategoryItem, 
       			  target:_menuBarContainer.parent,
       			  menuData:menuData
       			  } );
       			  
       		dispatchEvent(new Event(EventVO.NEWMENU));
       			  
		}
		
		
		
		
		/**
		 * Needed when the user selects the category
		 * then the first menuitem in the category menu
		 * then the user decideds to re-select the
		 * same category item again.
		 * @param e
		 */
		public function currentMenuItem(e:MouseEvent):void {
			
			_currentMenuItem = e.currentTarget as MenuItem;
			try {
				var errorMsg:String = _currentMenuItem.missingImageMsg;
				// If Error
					if(errorMsg != null) {
						new ErrorMessages(e.currentTarget,errorMsg);
					}
			} catch (e:Error) {}
		}
				
		
		
		
		
		/**
		 * Send a message to the JS container
		 * about the new application height
		 * This is for setting the new size
		 * of the DIV tag that container this
		 * application 
		 * @param target:* - Target item that is
		 * rendered on the stage
		 */
		 		
		public function setExternalContainerHeight(target:*=null):void {
			// Send new application height back to JS
			/* Get the Global JS interface
			 * Needed for a static listener */
			try {
				_g.getGlobal(_g.JSINTERFACE).setExternalContainerHeight(target);
			} catch (e:Error) {}
		}
		
		
		
		
		/**
		 * Call the external JS container
		 * and set the DIV height 
		 * @param target - An abstract var that can
		 * determine if you are targeting a specific
		 * component or if the menthod is being passed
		 * a number to determine the new size height
		 * of the application.
		 */
		 
		public function buildURL(e:Event):void {
			//_g.diagnostics(e.currentTarget.url+" "+e.currentTarget.target);
			var type:String = _g.PAGE_TYPE;
			/* Change the page type from default _self 
			 * to link type if one exists */
			if(e.currentTarget.target != null) type = e.currentTarget.target;
			
			
			//trace("## navigateToUrl: "+e.currentTarget.url, type);
			if ( (!isAdminTool) && (e.currentTarget.url is String) && (e.currentTarget.url.length > 0) ) {
				WebServices.navigateToUrl(e.currentTarget.url,type);
			}
		}
	}
}