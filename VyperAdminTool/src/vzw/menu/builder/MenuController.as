package vzw.menu.builder
{
	import com.hurlant.util.der.Integer;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.Menu;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.styles.CSSStyleDeclaration;
	import mx.utils.ObjectProxy;
	
	import utils.math.MathUtils;
	
	import vzw.adobe.serialization.json.JSON;
	import vzw.adobe.serialization.json.JSONEncoder;
	import vzw.controls.Alert.AlertPopUp;
	import vzw.controls.ColorPickerCanvas;
	import vzw.controls.MenuIdMonitor;
	import vzw.controls.MenuNamePopUp;
	import vzw.controls.MenuNameRenamePopUp;
	import vzw.controls.ReorderPanel;
	import vzw.controls.SmartConfirmation;
	import vzw.controls.SmartMenuFlyoutItemAdmin;
	import vzw.controls.SmartPopUpMenuButton;
	import vzw.controls.login.events.LoginCompletedEvent;
	import vzw.controls.login.events.LogoutCompletedEvent;
	import vzw.menu.builder.events.MenuChangedEvent;
	import vzw.menu.builder.events.MenuDataChangedEvent;
	import vzw.utils.ArrayCollectionUtils;
	import vzw.utils.ArrayUtils;
	import vzw.utils.CSS;
	import vzw.utils.EzHTTPService;
	import vzw.utils.GUID;
	import vzw.utils.Generator;
	import vzw.utils.GeneratorUtils;
	import vzw.utils.Images;
	import vzw.utils.ObjectUtils;
	import vzw.utils.StringUtils;

	public class MenuController {
        [Bindable]
		public static var VersionNumber:String = "Admin Tool 1.0.104";
		
        [Bindable]
		public static var isInitialized:Boolean = false;
		
        [Bindable]
		public static var AdminMode:Boolean = true;
		
		public static var isRunningLocal:Boolean = false;

		public static var urlPrefix:String = 'http://127.0.0.1:8888';
		
        [Bindable]
		public static var _overrides:String = '';

        [Bindable]
		public static var _isAdminMode:Boolean = true;

        [Bindable]
		public static var _isAdminEnabled:Boolean = false;

        [Bindable]
		public static var _numMenus:int = -1;

		public static var _maxMenuDepth:int = 3;
		
        [Bindable]
		public static var userID:String = '';

        public static var ezREST:EzHTTPService = new EzHTTPService(false,false);

        public static var _currentTargetMenuBar:*;

        public static var _currentTargetMenuBarDataProvider:*;

        [Bindable]
        public static var _currentSelectedMenuId:int;
            
        [Bindable]
        public static var _currentSelectedMenu:Object = null;
        
        [Bindable]
        public static var reloadMenus_callback:Function;

        [Bindable]
        public static var createdMenu_callback:Function;

        [Bindable]
        public static var onMouseClickLoginState_callback:Function;

        [Bindable]
        public static var onMouseClickLogoutLabel_callback:Function;

        [Bindable]
        public static var onMouseClickLogoutLabel_iconCallbackVector:Object = {};

        [Bindable]
        public static var displayOrder:Array = [];

        private static var _registered_categories:ArrayCollection;

        private static var _registered_menuitems:ArrayCollection;

		private static var loaded_expected_UUID:Boolean = false;
        private static var _expected_UUID:String;

		private static var trigger_update_menu_selection:Boolean = false;

		public static var numPropertiesErrors:int = 0;
		public static var numPropertiesConsistencyErrors:int = 0;

		public static var mySO:SharedObject = SharedObject.getLocal("/AdminTool/Settings/Preferences");

		public static var adminColorPickerIcon:Class = Images.adminColorPickerIcon;
		public static var adminDeleteIcon:Class = Images.adminDeleteIcon;
		public static var adminEditIcon:Class = Images.adminEditIcon;
		public static var adminAddIcon:Class = Images.adminAddIcon;
		public static var adminReorderIcon:Class = Images.adminReorderIcon;
		public static var adminAddDisabledIcon:Class = Images.adminAddDisabledIcon;
		public static var adminDeleteDisabledIcon:Class = Images.adminDeleteDisabledIcon;
		public static var adminEditDisabledIcon:Class = Images.adminEditDisabledIcon;
		
        public static var parent:*;

        [Bindable]
        public static var controlPanel:ControlPanel;
        
        [Bindable]
        public static var controlPanelBottom:ControlPanel;
        
        [Bindable]
        public static var colorPickerIcon:ColorPickerCanvas;
        
        [Bindable]
		public static var menuModel:Object;
		
        [Bindable]
		public static var hash:Object;
		
        [Bindable]
		public static var menuProps:Array = null;
		
        [Bindable(event="callbackGlobalsVO_Changed")]
		public static var callback_GlobalsVO:Function;

        [Bindable]
		public static var metafield:String = 'meta';

        [Bindable]
		public static var datafield:String = 'menuitem';

        public static var _menu_id_monitor_popup:MenuIdMonitor;

        private static var _admin_editor_popup:SmartMenuFlyoutItemAdmin;

        private static var _admin_reorder_popup:ReorderPanel;
        
        public static var dummy:Function = function ():void {};

        public static var callback:Function = dummy;
        
        public static var faultCallBack:Function = dummy;
        public static var resultCallBack:Function = dummy;

        public static var callback_sendDataToMenuModel:Function = dummy;
        
		public static var propsParser:* = null;

        [Bindable]
		public static var rolesList:Array = [];

        [Bindable]
		public static var envsList:Array = [];

		private static var timer:Timer;        
        private static var action_stack:Array = [];
        
		MenuController._registered_categories = new ArrayCollection();
		MenuController._registered_menuitems = new ArrayCollection();

		private static var devMode:Boolean = false;
		
		public static var isLoggedOut:Boolean = false;

		public static var isUserLoggedIn:Boolean = false;

		public static var generator:Generator;
		
		public static var uuid_to_generator:Object = {};

		public static var menu_id_to_generator:Object = {};

		public static var menu_id_sorted:Array = [];

		public static var _menu_id_sorted:Array = [];

		public static var uuid_to_menuItemPopUpItems:Object = {};
		public static var uuid_to_menuItem:Object = {};

		public static var active_menus:Array = [];

		public static var urlEditors_Names:Array = ['urlEditor_AccountHolder','urlEditor_MobileSecure','urlEditor_Prepay'];

		public static var used_GN_Values:Array = ['GN7'];

		public static function isDummyFunction(aFunc:Function):Boolean {
			return (aFunc == MenuController.dummy);
		}
	
		// ===============================================================================================

		public static function generator_callback(generator:Generator,item:*):void {
			var uuid:String;
			// BEGIN: Make the UUID unique by stamping each record with a fresh UUID...
			var cannotHaveUUID:Boolean = (item is String) || (item is Boolean) || (item is Integer) || (item is Number) || (item == null) || (item is Array) || (item is ArrayCollection);
			if (!cannotHaveUUID) {
				try {
					item[MenuController._currentTargetMenuBarDataProvider.metaData.hash.uuid] = GUID.create();
				} catch (err:Error) {
					trace('generator_callback().ERROR '+err.toString()+'\n'+err.getStackTrace());
				}
			} else {
				//trace('generator_callback().1 item='+(new ObjectExplainer(item)).explainThisWay());
			}
			// END!   Make the UUID unique by stamping each record with a fresh UUID...
			try { uuid = item[MenuController._currentTargetMenuBarDataProvider.metaData.hash.uuid]; } 
				catch (err:Error) {}
			if (uuid is String) {
				MenuController.uuid_to_generator[uuid] = generator;
				//trace('generator_callback().1 --> uuid='+uuid);
			}
			if (!isLoggedOut) {
				var i:String;
				var aMenuId:Object;
				var aUrlEditor:Object;
				var aRolesEditor:Object;
				var roles:Array = [];
				try { roles = item[MenuController.hash.roles]; } catch (err:Error) {}
				var hasRoles:Boolean = ( (roles is Array) && (roles.length > 0) );
				if (hasRoles) {
					var aRole:Object = roles[0];
					try {
						aRolesEditor = aRole.rolesEditor;
						if (aRolesEditor != null) {
							var anEditor:String;
							var urlEditors:Array = MenuController.urlEditors_Names;
							for (i in urlEditors) {
								anEditor = urlEditors[i];
								aUrlEditor = aRolesEditor[anEditor];
								if (aUrlEditor != null) {
									aMenuId = aUrlEditor.menu_id;
									if ( (aMenuId != null) && (aMenuId.menu_id != null) ) {
										MenuController.menu_id_to_generator[aMenuId.menu_id] = generator;
									}
								}
							}
						}
					} catch (err:Error) {}
				}
			}
		}
		
		public static function filter_menu_id_to_number(aMenuId:String):int {
			var toks:Array = aMenuId.split('_');
			var aTok:String = toks[toks.length-1];
			toks = aTok.split('GN');
			aTok = toks[toks.length-1];
			return int(aTok);
		}

		private static function handle_rest_errors_gracefully(e:FaultEvent):void {
			//trace('handle_rest_errors_gracefully().1 --> e='+e.toString());
			//trace('handle_rest_errors_gracefully().2 --> MenuController.isRunningLocal='+MenuController.isRunningLocal);
			if (MenuController.isRunningLocal == false) {
				AlertPopUp.errorNoOkay('The server is not available at this time due to some kind of error.\n' + e.message,'ERROR +++');
			} else {
				//trace('handle_rest_errors_gracefully().3 !');
				// redirect to MenuController.resultCallBack if there is any valid JSON in the result...
				MenuController.faultCallBack(e);
			}
		}
		
		private static function get_props_if_necessary(flashVars:*):void {
            function onResultProps(event:ResultEvent):void {
				var response:*;
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					MenuController.menuProps = MenuController.propsParser.parse(response);
				} catch (e:Error) {
					var stackTrace:String = e.getStackTrace();
					AlertPopUp.errorNoOkay('get_props_if_necessary().ERROR\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace,1024),'ERROR +++');
				}
            }
			
			if ( (MenuController.menuProps == null) || (MenuController.menuProps.length == 0) ) {
				var props:Array = MenuController.callback_GlobalsVO('getGlobal',"props");
				if (props == null) {
	            	MenuController.ezREST.send(WmsAPI._overrides.p, onResultProps, ezREST.objectResultType);
				}
			}
		} 
		
		public static function getRandomColor():String {
			var greenOctet:int = MathUtils.randomRange(0,255);
			var blueOctet:int = MathUtils.randomRange(0,255);
			return StringUtils.uintToString((greenOctet * 255) + blueOctet);
		}
		
		public static function applyNewColorScheme(color:String):void {
			var styles:Object = CSS.styles;
			var aCSSStyleDeclaration:CSSStyleDeclaration;
			var aPropertyNames:*;
			var aPropertyName:String;
			var aColor:String;
			var colors:*
			var isColorValid:Boolean = ( (color is String) && (color.length > 0) );
			//trace('### applyNewColorScheme().1 --> color='+color);
			aColor = color;
			if (!isColorValid) {
				aColor = MenuController.getRandomColor();
				//trace('### applyNewColorScheme().2 --> aColor='+aColor);
				isColorValid = true;
				MenuController.mySO.data.color = aColor;
				MenuController.mySO.flush();
			}
			if (isColorValid) {
				for (var aStyleDeclaration:String in styles) {
					aCSSStyleDeclaration = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(aStyleDeclaration) as CSSStyleDeclaration;
					if (aCSSStyleDeclaration != null) {
						aPropertyNames = styles[aStyleDeclaration];
						aPropertyNames = (aPropertyNames is Array) ? aPropertyNames : [aPropertyNames];
						for (var i:String in aPropertyNames) {
							aPropertyName = aPropertyNames[i];
							//trace('### applyNewColorScheme().3 --> aPropertyName='+aPropertyName);
							colors = aColor;
							if (aPropertyName == 'headerColors') {
								colors = [aColor,aColor];
								//trace('### applyNewColorScheme().4 --> colors='+colors);
							}
							//trace('### applyNewColorScheme().5 --> colors='+colors);
							aCSSStyleDeclaration.setStyle(aPropertyName, colors);
						}
					}
				}
			}
		}
		
		private static function _keepalive(url:String):void {
            function onResultKeepaliveJSON(event:ResultEvent):void {
				var response:*;
				try {
					// BEGIN: Do Nothing !  Not expecting a response of any kind...
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					// END!   Do Nothing !  Not expecting a response of any kind...
				} catch (e:Error) {
					trace('### _keepalive().1 ERROR='+e.toString()+'\n'+e.getStackTrace());
				}
            }
            
            var aREST:EzHTTPService = new EzHTTPService(false,false);
        	aREST.send(url, onResultKeepaliveJSON, ezREST.jsonResultType);
		}

		private static function keepalive_callback():void {
			var url:String = WmsAPI.api_Keepalive();
			MenuController._keepalive(url);
		}

		public static function initialize(application:*,parent:*,container:*,isInternal:Boolean,flashVars:*,WmsAPI_disable_keepalive_timer:Boolean):void {
			if (MenuController.isInitialized == false) {
				try {
		        	MenuController.parent = parent;
		        	MenuController.parent.enabled = true;
		        	MenuController.isRunningLocal = (String(application.url).toLowerCase().indexOf("file://") > -1);
		        	MenuController.faultCallBack = (MenuController.ezREST.faultCallBack is Function) ? MenuController.ezREST.faultCallBack : MenuController.ezREST.onFaultHandler;
					MenuController.ezREST.faultCallBack = MenuController.handle_rest_errors_gracefully;
					MenuController.resultCallBack = MenuController.ezREST.myCallback;
					var isWmsDev:Boolean = MenuController.callback_GlobalsVO('getGlobal',"ISWMSDEV") as Boolean;
					var isDebugging:Boolean = MenuController.callback_GlobalsVO('getGlobal',"ISDEBUGGING") as Boolean;
					WmsAPI.initialize(application,isInternal,MenuController._overrides,isWmsDev,isDebugging,function():void{},keepalive_callback);
					WmsAPI._disable_keepalive_timer = WmsAPI_disable_keepalive_timer;
					MenuController.initialize_control_panel(container);
					MenuController._initialize(parent);
					MenuController.getMenuCount(parent);
					MenuController.get_props_if_necessary(flashVars);
					MenuController.devMode = MenuController.callback_GlobalsVO('DEVMODE') as Boolean;
					MenuController.isLoggedOut = MenuController.callback_GlobalsVO('ISLoggedOut') as Boolean;

					var color:String = MenuController.mySO.data.color;
					MenuController.applyNewColorScheme(color);
				} catch (e:Error) {}

				MenuController.isInitialized = true;
			}
		}

		private static function _initialize(container:*):void {
            function onResultMenuEnvJSON(event:ResultEvent):void {
				var response:*;
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					response = (response is ObjectProxy) ? response.valueOf() : response;
				} catch (e:Error) {
					var stackTrace:String = e.getStackTrace();
					AlertPopUp.errorNoOkay('Constants :: 1.0\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace,1024),'ERROR');
				} finally {
	            	container.enabled = true;
				}
            }
            
			function getDomains():void {
            	container.enabled = false;
				var url:String = urlPrefix + '/rest/get/menu/environments/json/';
            	MenuController.ezREST.send(url, onResultMenuEnvJSON, ezREST.jsonResultType);
			}
		}

		private static function handle_loginRequest(event:LoginCompletedEvent):void {
			MenuController.userID = event.username + ',' + event.password;
			MenuController.getMenuCount(MenuController.parent);
			MenuController.getMenus();
		}
		
		private static function handle_logoutRequest(event:LogoutCompletedEvent):void {
			MenuController.userID = '';
			MenuController.getMenuCount(MenuController.parent);
			MenuController.getMenus();
		}
		
		private static function get_last_selected_menu():void {
            function onResultMenusJSON(event:ResultEvent):void {
				var response:*;
				var hasSuccess:Boolean = false;
				var uuid:String = '';
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					response = (response is ObjectProxy) ? response.valueOf() : response;
					uuid = (response.uuid != null) ? response.uuid : uuid;
					hasSuccess = ((response.success != null) ? response.success : hasSuccess) && ( (uuid is String) && (uuid.length > 0) );
				} catch (e:Error) {
					var stackTrace2:String = e.getStackTrace();
					AlertPopUp.errorNoOkay('<MenuController> :: get_last_selected_menu.onResultMenusJSON\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace2,1024),'ERROR MenuController.501');
				} finally {
	            	MenuController.parent.enabled = true;
		        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
		        	if (hasSuccess) {
	            		var aMenu:Menu = MenuController.controlPanel.btn_menuChoice.popUp as Menu;
	            		var ac:ArrayCollection = aMenu.dataProvider as ArrayCollection;
	            		var i:int = ArrayCollectionUtils.findIndexOfItem(ac,'uuid',uuid);
	            		if (i > -1) {
	            			MenuController.loaded_expected_UUID = false;
	            			MenuController._expected_UUID = uuid;
	            			MenuController._currentSelectedMenu = {'uuid':uuid,'name':''}; // spoof the system to make it do the required work...
	            			MenuController.getMenu();
	            		}
		        	}
				}
            }
		}
		
		private static function initialize_control_panel(container:*):void {
			function after_controlPanel():void {
				var userID:String = MenuController.callback_GlobalsVO('getGlobal',"UserId") as String;
				MenuController.controlPanel.HasUserID = (userID is String) && (userID.length > 0);
				MenuController.controlPanel.IsWmsDev = MenuController.callback_GlobalsVO('getGlobal',"IsWmsDev") as Boolean;
				
				MenuController.controlPanel.btnSaveMenuAs.addEventListener(MouseEvent.CLICK,MenuController.onClick_btnSaveMenuAs);

				MenuController.controlPanel.hbox2.visible = false;
				
				if (MenuController.controlPanel.HasUserID) {
					MenuController.controlPanel.currentState = 'LoggedIn';
					MenuController.userID = userID;
					MenuController.getMenuCount(MenuController.parent);
		        	MenuController.action_stack.push(MenuController.get_last_selected_menu);
				}
			}
			
			function menu_changed(event:MenuChangedEvent):void {
				var target:ControlPanel = event.target as ControlPanel;
        		var aMenu:Menu = target.btn_menuChoice.popUp as Menu;
            	//trace('menu_changed().1 --> (aMenu is Menu)='+(aMenu is Menu));
				aMenu = (aMenu is Menu) ? aMenu : event.menu as Menu;
            	//trace('menu_changed().2 --> (aMenu is Menu)='+(aMenu is Menu));
                try {
	                var menu:Object = aMenu.dataProvider[(aMenu.selectedIndex > -1) ? aMenu.selectedIndex : 0];
                	//trace('menu_changed().3 --> aMenu.selectedIndex='+aMenu.selectedIndex);
                	//aMenu.selectedIndex = MenuController._currentSelectedMenuId;
                	//MenuController._currentSelectedMenuId = aMenu.selectedIndex;
                	//trace('menu_changed().4 --> MenuController._currentSelectedMenuId='+MenuController._currentSelectedMenuId);
	                target.btn_menuChoice.label = menu.label;
	                target.btn_menuChoice.popUp = aMenu;
                } catch (e:Error) {trace('menu_changed().1 ERROR='+e.toString());}
			}
			
			MenuController.controlPanel = new ControlPanel();
			MenuController.controlPanel.id = MenuController.controlPanel.name = 'control_panel';
			var version:String = MenuController.callback_GlobalsVO("VERSION") as String;
			MenuController.controlPanel.VersionNumber = version;
        	MenuController.controlPanel.addEventListener(MenuChangedEvent.TYPE_MENU_CHANGED_EVENT,menu_changed);
        	MenuController.controlPanel.addEventListener(LoginCompletedEvent.TYPE_LOGIN_COMPLETED, MenuController.handle_loginRequest);
        	MenuController.controlPanel.addEventListener(LogoutCompletedEvent.TYPE_LOGOUT_COMPLETED, MenuController.handle_logoutRequest);
        	MenuController.controlPanel.callLater(after_controlPanel);

			MenuController.controlPanelBottom = PopUpManager.createPopUp(MenuController.parent, ControlPanel, false) as ControlPanel;
			MenuController.controlPanelBottom.id = MenuController.controlPanelBottom.name = 'control_panel_bottom';
			MenuController.controlPanelBottom.currentState = 'PublishOnly';
			PopUpManager.centerPopUp(MenuController.controlPanelBottom);
			MenuController.controlPanelBottom.x = MenuController.parent.width - MenuController.controlPanelBottom.width - 35;
			MenuController.controlPanelBottom.y = MenuController.parent.height - 75;
			MenuController.controlPanelBottom.styleName = 'BottomControlPanel';
			
			container.addChild(MenuController.controlPanel);
		}
		
		private static function onClick_admin_editor_popup(event:MouseEvent):void {
			PopUpManager.removePopUp(MenuController._admin_editor_popup);
			MenuController._admin_editor_popup = null;
		}
		
		private static function onClick_admin_reorder_popup(event:MouseEvent):void {
			PopUpManager.removePopUp(MenuController._admin_reorder_popup);
			MenuController._admin_reorder_popup = null;
		}
		
		public static function descend_into_looking_for(ar:Array,selector:String,value:String,menuDataSelector:String,aFunc:Function):Boolean {
			var found:Boolean = false;
			var aValue:String;
			var aMenu:Array;
			for (var i:int = 0; i < ar.length; i++) {
				aValue = ar[i][selector];
				if ( (aFunc is Function) && (aValue is String) && (value is String) && (aValue == value) ) {
					try {
						aFunc(ar,i);
						return true;
					} catch (e:Error) {}
				}
				aMenu = ar[i][menuDataSelector];
				if (aMenu is Array) {
					found = MenuController.descend_into_looking_for(aMenu,selector,value,menuDataSelector,aFunc);
					if (found) {
						return found;
					}
				}
			}
			return false;
		}

		public static function getProps():Array {
			var props:Array = MenuController.menuProps;
			if ( (MenuController.menuProps == null) || (MenuController.menuProps.length == 0) ) {
				props = MenuController.callback_GlobalsVO('getGlobal',"props");
				MenuController.menuProps = props;
			}
			return MenuController.menuProps;
		}
		
		private static function isLabelBody(item:*):Boolean {
			var label:String = item[MenuController.hash.label];
			var body:String = item[MenuController.hash.body];
			var url:String = item[MenuController.hash.url];
			var is_body_string:Boolean = (body is String);
			var is_body_length:Boolean = (is_body_string) ? (body.length > 0) : false;
			var is_body_URL_null:Boolean = (url == null);
			var is_body_label:Boolean = (is_body_string) && (is_body_length) && (is_body_URL_null);
			
			return is_body_label;
		}

		private static function isDefault(item:*):Boolean {
			var label:String = item[MenuController.hash.label];
			var url:String = item[MenuController.hash.url];
			var is_label:Boolean = ( (label is String) && (label.length > 0) );
			var is_url:Boolean = ( (url is String) && (url.length > 0) );
			var is_default:Boolean = is_label && is_url;
			
			return is_default;
		}

		private static function isSeparator(item:*):Boolean {
			return (MenuController.isDefault(item) == false) && (MenuController.isLabelBody(item) == false);
		}

		public static function onClick_PopUpMenu_ActionBtn(event:MenuEvent):void {
			var item:* = event.item;
			
			if (ObjectUtils.isEmpty(MenuController._currentSelectedMenu)) {
				return;
			}

			var isFalseCategory:Boolean = (item.category == null);
			var popUp:SmartPopUpMenuButton = event.currentTarget as SmartPopUpMenuButton;

			MenuController.dismissFakeMenuImages();
			
			var _target:* = item;
			try { _target = popUp.target; } catch (err:Error) {}
			var menuLevel:int = -1;
			try { menuLevel = (_target != null) ? _target.menuLevel : -1; } 
				catch (err:Error) {}

			var isFakeCategory:Boolean = (_target == null); // This is a rewrite and not well written to be sure...
			if (isFakeCategory) {
				isFalseCategory = false; // this is a hack, but that's life sometimes...
			}

			function return_target_object(ar:Array,i:int):void {
				target_ar = ar;
				target_i = i;
				target = target_ar[target_i];
			}

			var i:String;

			var m:*;
			var aCategory:*;
			var aDP:*;
			var name:String = item.name;
			var menuitem:* = (item.menuitem != null) ? item.menuitem : item.category_dp;
			var numCats:int = MenuController.menuModel.menuData.data.length;
			var item_id:String = (menuitem != null) ? menuitem[MenuController.hash.id] : '';

			var isEditHomeLink:Boolean = (item_id == 'home');
			var isEditProfileLink:Boolean = (item_id == 'profile');
			var categoryPosition:int = (isEditHomeLink) ? 0 : ((isEditProfileLink) ? numCats+1 : -1);
			var itemPosition:int = -1;
			menuitem = (menuitem == null) ? {} : menuitem;
			var isEditLogoLink:Boolean = (name == 'edit_logo_item');
			var isEditLobLink:Boolean = (name == 'edit_lob_item');
			var isAddGLinksItem:Boolean = (name == 'add_glinks_item');
			var isEditGLinksItem:Boolean = (name == 'edit_glinks_item');
			var isDeleteGLinksItem:Boolean = (name == 'delete_glinks_item');
			var isEditCategoryItem:Boolean = (name == 'edit_category_item');
			var isEditLocationItem:Boolean = (name == 'edit_location_item');
			var isEditHouseItem:Boolean = (name == 'edit_house_item');
			var isEditSignOutItem:Boolean = (name == 'edit_signout_item');
			var isEditSearchItem:Boolean = (name == 'edit_search_item');
			var isEditCartItem:Boolean = (name == 'edit_cart_item');
			var isAddHouseItem:Boolean = (name == 'add_house_item');
			var isHomeNode:Boolean = false;
			var anItem:* = item.currentTarget;
			var uuid:String = menuitem[MenuController._currentTargetMenuBarDataProvider.metaData.hash.uuid];
			var isAnItemMenuText:Boolean = (anItem.className == 'MenuText');
			menuitem = ((isAddHouseItem) ? anItem.currentData[MenuController._currentTargetMenuBarDataProvider.headerData.name] : (isEditCartItem) ? anItem.currentData : menuitem);
			var isEditCartEmptyItem:Boolean = (isEditCartItem) && (menuitem[MenuController._currentTargetMenuBarDataProvider.metaData.hash.id] == 'empty');
			aCategory = item.category;
			if ( (isFalseCategory) || (isAnItemMenuText) ) {
				aDP = item.menuitem;
			} else {
				categoryPosition = ( (aCategory != null) && (aCategory.categoryPosition != null) ) ? aCategory.categoryPosition+1 : categoryPosition;
				aDP = item.category_dp;
				if (!isFakeCategory) {
					aDP = (isEditCategoryItem) ? aDP : aDP[MenuController.menuModel.menuData.name];
				} else {
					aDP = (isEditLogoLink) ? MenuController._currentTargetMenuBarDataProvider.headerData.data.logo[MenuController._currentTargetMenuBarDataProvider.headerData.name] : 
							((isEditLobLink) ? MenuController._currentTargetMenuBarDataProvider.headerData.data.lob[MenuController._currentTargetMenuBarDataProvider.headerData.name] : 
							((isEditLocationItem) ? MenuController._currentTargetMenuBarDataProvider.headerData.data.localeCoverage[MenuController._currentTargetMenuBarDataProvider.headerData.name] : 
							((isEditHouseItem) ? MenuController._currentTargetMenuBarDataProvider.headerData.data.home : 
							((isEditSignOutItem) ? MenuController._currentTargetMenuBarDataProvider.headerData.data.logout[MenuController._currentTargetMenuBarDataProvider.headerData.name] : 
							((isEditSearchItem) ? MenuController._currentTargetMenuBarDataProvider.headerData.data.search[MenuController._currentTargetMenuBarDataProvider.headerData.name] : 
							((isEditCartItem) ? MenuController._currentTargetMenuBarDataProvider.headerData.data.cart[MenuController._currentTargetMenuBarDataProvider.headerData.name] : 
							((isAddHouseItem) ? MenuController._currentTargetMenuBarDataProvider.headerData.data.home[MenuController._currentTargetMenuBarDataProvider.headerData.name] : MenuController._currentTargetMenuBarDataProvider.headerData.data.gLinks[MenuController._currentTargetMenuBarDataProvider.headerData.name])))))));
					if ( (!isEditLobLink) && (!isEditLocationItem) && (!isEditCartItem) ) {
						menuitem = ((aDP is Array) && (aDP.length > 0)) ? (((isEditGLinksItem || isDeleteGLinksItem) && (menuitem is Array) && (menuitem.length > 0)) ? menuitem[0] : aDP[0]) : aDP;
					} else if (!isEditCartItem) {
						menuitem = ((menuitem is Array) && (menuitem.length > 0)) ? menuitem[0] : menuitem;
						if ( (aDP is Array) && (aDP.length > 0) && (menuitem is int) && (menuitem >= 0) && (menuitem <= aDP.length) ) {
							menuitem = aDP[menuitem];
						}
					}
				}
			}
			var isAddSubMenuItem:Boolean = (name == 'add_submenuitem') || (isAddGLinksItem);
			var isAddSubMenuItem2:Boolean = (name == 'add_submenuitem2');
			var isDeleteMenuItem:Boolean = (name == 'delete_menuitem') || (isDeleteGLinksItem);
			var isEditMenuItem:Boolean = ( (name == 'edit_menuitem') || (isEditLogoLink) || (isEditLobLink) || (isEditCategoryItem) || (isEditLocationItem) );
			var isReorderMenuItem:Boolean = (name == 'reorder_menu_items');
			var aLabel:String = menuitem[MenuController.hash.label];
			var popup:Alert;
			var popup2:SmartConfirmation;
			if ( (aCategory) || (isFalseCategory) || (isFakeCategory) ) {
				if (isDeleteMenuItem) {
					var target:Object;
					var target_ar:Array;
					var target_i:int;
					
					function perform_delete_function(ar:Array,i:int):void {
						var uuid2:String;
						try { uuid2 = ar[i+1][MenuController.hash.uuid]; } catch (err:Error) {}
						var anItem2:* = ( (uuid2 is String) && (uuid2.length > 0) ) ? MenuController.uuid_to_menuItem[uuid2] : {'className':''};
						var isTakingOutSep2:Boolean = (isAnItemMenuText) && (anItem2.className == 'MenuItemSeparator');
						ar.splice(i,1+((isTakingOutSep2) ? 1 : 0));
					}
					
					function handle_confirmation(event:*):void {
						if (target_ar is Array) {
							perform_delete_function(target_ar,target_i);
						} else {
							ObjectUtils.makeEmpty(aDP);
						}
						MenuController.perform_garbage_collection();
						var menu:* = MenuController._currentTargetMenuBarDataProvider;
						MenuController.handle_menuitem_update(menu.uuid.data);
					}

					var label:* = (isDeleteGLinksItem) ? menuitem[MenuController.hash.label] : item._label;
					if (!(aDP is Array)) {
						try {
							aDP = (anItem.currentDataContainer is Array) ? anItem.currentDataContainer : aDP;
						} catch (err:Error) {
							aDP = (item.currentDataContainer is Array) ? item.currentDataContainer : aDP;
						}
					}
					if (aDP is Array) {
						MenuController.descend_into_looking_for(aDP,MenuController.hash.uuid,uuid,MenuController.menuModel.menuData.name,return_target_object);
					}
					aLabel = (target != null) ? target[MenuController.hash.label] : aLabel;
					var msg:String = (label != null) ? ((isDeleteGLinksItem) ? item._label : 'menu')+' item named "' + label + '"' : '';
					popup2 = PopUpManager.createPopUp(MenuController.parent, SmartConfirmation, true) as SmartConfirmation;
					popup2.title = 'Confirm';
					popup2.someText.text = 'Are you sure you want to delete the ' + msg + ' ?';
					popup2.btn_okay.label = 'Confirm';
					popup2.btn_cancel.label = 'Cancel';
					popup2.width = 400;
					popup2.height = 200;
					popup2.btn_okay.addEventListener(MouseEvent.CLICK,function (event:MouseEvent):void {PopUpManager.removePopUp(popup2); handle_confirmation(event);});
					popup2.btn_cancel.addEventListener(MouseEvent.CLICK,function (event:MouseEvent):void {PopUpManager.removePopUp(popup2);});
					PopUpManager.centerPopUp(popup2);
				} else if (isReorderMenuItem) {
					MenuController._admin_reorder_popup = PopUpManager.createPopUp(MenuController.parent, ReorderPanel, true) as ReorderPanel;
					var maxX:Number = MenuController.parent.height - 100;
					MenuController._admin_reorder_popup.height = (aDP.length * 30) + 150;
					MenuController._admin_reorder_popup.height = (MenuController._admin_reorder_popup.height > maxX) ? maxX : MenuController._admin_reorder_popup.height;
					PopUpManager.centerPopUp(MenuController._admin_reorder_popup);
					
					m = menuitem[MenuController.menuModel.menuData.name];
					MenuController._admin_reorder_popup.dataProvider = (m != null) ? m : aDP;

					MenuController._admin_reorder_popup.btn_save.addEventListener(MouseEvent.CLICK,MenuController.onClick_save_admin_reorder_popup);
					MenuController._admin_reorder_popup.btn_dismiss.addEventListener(MouseEvent.CLICK,MenuController.onClick_admin_reorder_popup);
				} else {
					var props:Array = MenuController.getProps();
					if (MenuController.numPropertiesErrors == 0) {
						if (props is Array) {
							var isBodyLabel:Boolean = MenuController.isLabelBody(menuitem);
	
							MenuController._admin_editor_popup = PopUpManager.createPopUp(MenuController.parent, SmartMenuFlyoutItemAdmin, true) as SmartMenuFlyoutItemAdmin;
							MenuController._admin_editor_popup.width = MenuController.parent.width - 150;
							PopUpManager.centerPopUp(MenuController._admin_editor_popup);
	
							function perform_properties_file_analysis(_properties:Array):ArrayCollection {
								var i:String;
								
								var properties:Array = ArrayUtils.deepCopyFrom(_properties);
								
								// Read Properties from the Model... into a Hash...
								var d_hash:Object = {};
								var metaDomain_data:Object = MenuController._currentTargetMenuBarDataProvider.metaDomain.data;
								for (i in metaDomain_data) {
									if (StringUtils.isStringNumeric(i)) {
										d_hash[metaDomain_data[i]] = i;
									}
								}
								var drops:Array = [];
								var aDomain:String;
								for (i in properties) {
									aDomain = properties[i].value;
									if (d_hash[aDomain] != null) {
										drops.push({'i':i,'v':properties[i]});
									}
								}
								var n:int;
								var aDrop:Object;
								for (n=drops.length-1;n>-1;n--) {
									aDrop = drops[n];
									properties.splice(aDrop.i);
								}

								var _props:Array = [];

								for (i in metaDomain_data) {
									if (StringUtils.isStringNumeric(i)) {
										d_hash[metaDomain_data[i]] = i;
										_props.push({'label':metaDomain_data[i],'name':metaDomain_data[i],'value':metaDomain_data[i],'iDomain':i,'iKey':i});
									}
								}

								var aProp:Object;
								for (i in properties) {
									aProp = properties[i];
									aProp.iDomain = aProp.iKey = _props.length;
									_props.push(aProp);
								}

								_props.sortOn('label');

								_props.push({'label':'Other','name':SmartMenuFlyoutItemAdmin.symbol_other_domain,'value':'','iDomain':-1,'iKey':-1});
								
								return new ArrayCollection(_props);
							}

							var ac:ArrayCollection = perform_properties_file_analysis(props);
							MenuController._admin_editor_popup.combo_domain.dataProvider = ac;
							MenuController._admin_editor_popup.label_category.text = (aCategory && !isFakeCategory) ? aCategory.htmlText : '';
	
							var aStateName:String = (isBodyLabel) ? 'LabelsOnly' + ((WmsAPI.menuType == WmsAPI.symbol_loggedIn_token) ? '+'+WmsAPI.symbol_loggedIn_token : '') : (WmsAPI.menuType == WmsAPI.symbol_loggedIn_token) ? WmsAPI.symbol_loggedIn_token : '';
							//trace('+++ 1. aStateName='+aStateName);
							
							MenuController._admin_editor_popup.rolesList = new ArrayCollection(MenuController.rolesList);
	
							m = menuitem[MenuController.menuModel.menuData.name];
	
							if ( (isAddSubMenuItem) || (isAddSubMenuItem2) ) {
								aCategory = menuitem;
								menuitem = {};
							}
							MenuController._admin_editor_popup.source = ((aCategory != null) && (!isEditCategoryItem)) ? aCategory : name;
							MenuController._admin_editor_popup.source_dp = (isAddSubMenuItem2) ? aCategory : menuitem;
	
							var _aStateName:String = (m != null) ? '' : '';
							if (m == null) {
								var _ar:Array;
								var _isEditing:Boolean = false;
								var _obj:Object;
								function found_the_item(ar:Array,i:int):void {
									itemPosition = i + 1; // used by that GN_xxx_yyy thingy...
									_isEditing = true;
									_ar = ar;
								}
								m = {};
								if (!isAddGLinksItem) {
									if ( (aDP is Array) && (aDP.length > 0) ) {
										MenuController.descend_into_looking_for(aDP,MenuController.hash.uuid,menuitem[MenuController.hash.uuid],MenuController.menuModel.menuData.name,found_the_item);
										if (_isEditing) {
											m = _ar;
										}
									} else {
										// ?!?
									}
								}
							}
							if (isAddGLinksItem) {
								menuitem = {};
							} else if (isEditCategoryItem) {
								menuitem = aDP;
							}
							var menuitem_copy:* = ObjectUtils.cloneIfNecessary(menuitem,true);
							var count_seps:int = 0;
							var count_label_bodies:int = 0;
							for (i in m) {
								if (MenuController.isLabelBody(m[i])) {
									count_label_bodies++;
								} else if (MenuController.isSeparator(m[i])) {
									count_seps++;
								}
							}
							if (count_label_bodies > 0) {
								var isLabelBody:Boolean = MenuController.isLabelBody(menuitem);
								_aStateName = (isLabelBody) ? 'EditingExistingLabelBody' : 'ExistingLabelBody';
							}
							trace('+++ 2. _aStateName='+_aStateName);
							_aStateName = (aStateName.indexOf(WmsAPI.symbol_loggedIn_token) > -1) ? aStateName : ((isAddSubMenuItem && (count_label_bodies > 0) && (count_seps == 0)) ? 'AddingToExistingLabelBody' : _aStateName);
							trace('+++ 3. _aStateName='+_aStateName);
							_aStateName = ((isFakeCategory) && (!isEditLogoLink) && (!isEditLobLink) && (!isEditLocationItem) && (!isEditHouseItem) && (!isAddHouseItem) && (!isEditSignOutItem) && (!isEditSearchItem) && (!isEditCartItem)) ? 'glinks-only' : ((isEditLogoLink) ? 'logo-LinkOnly' : ((isEditLobLink) ? 'lob-LinkOnly' : ((isEditCategoryItem) ? ((MenuController.isLoggedOut) ? 'category' : 'category+LoggedIn') : ((isEditLocationItem) ? 'location' : ((isEditHouseItem || isAddHouseItem) ? 'house-LinkOnly' : ((isEditSignOutItem) ? 'signOut-LabelsOnly' : ((isEditSearchItem) ? 'search-LabelsOnly' : ((isEditCartItem) ? ((isEditCartEmptyItem) ? 'cart-LabelsOnly' : 'cart-LabelsAndLinks') : ((isAnItemMenuText) ? 'EditingExistingLabelBodyOnly' : ((isAddSubMenuItem2) ? 'add_to_category' : ((isEditGLinksItem || isAddGLinksItem) ? 'glinks-only' : _aStateName)))))))))));
							trace('+++ 4. _aStateName='+_aStateName);
							MenuController._admin_editor_popup.itemPosition = itemPosition;
							MenuController._admin_editor_popup.categoryPosition = categoryPosition;
							//trace('+++ 4.1 categoryPosition='+categoryPosition);
							MenuController._admin_editor_popup.dataProvider = menuitem_copy;
							MenuController._admin_editor_popup._currentState = _aStateName;
							
							// BEGIN: This block must happen AFTER the state has been set...
							MenuController._admin_editor_popup.isAddSubMenuItem = isAddSubMenuItem || isAddSubMenuItem2;
							MenuController._admin_editor_popup.isEditMenuItem = isEditMenuItem;
							MenuController._admin_editor_popup.isDeleteMenuItem = isDeleteMenuItem;
							if (_aStateName != 'EditingExistingLabelBodyOnly') {
								MenuController._admin_editor_popup.menuDepth = {'menuLevel':menuLevel,'count_label_bodies':count_label_bodies,'count_seps':count_seps};
							}
							//MenuController._admin_editor_popup.isAllowingSeps = (count_label_bodies > 0) && (count_seps == 0);
							// END!   This block must happen AFTER the state has been set...
	
							MenuController._admin_editor_popup.btn_save.addEventListener(MouseEvent.CLICK,MenuController.onClick_save_admin_editor_popup);
							MenuController._admin_editor_popup.btn_dismiss.addEventListener(MouseEvent.CLICK,MenuController.onClick_admin_editor_popup);
						} else {
							popup = AlertPopUp.errorNoOkay('Cannot edit a Menuitem unless there is a Properties file and presently there is no Properties file.\n\nThe Properties file is required even if no such file will be used once your Menu reaches the Production server.\n\nThe Properties file contains useful information about the many domains covered by the Admin Tool.\n\nKindly contact your CIS Administrator to make the Properties file available for your needs.','ERROR MenuController.101.1');
							PopUpManager.centerPopUp(popup);
						}
					} else {
						popup = AlertPopUp.errorNoOkay('Cannot edit a Menuitem unless the Properties file is known to be consistent with the model and there are no known issues with the Properties file.\n\nThe Properties file must be consistent with the Model which is to say there must be no keys that cannot be resolved from the perspective of the Model.','ERROR MenuController.101.2');
						PopUpManager.centerPopUp(popup);
					}
				}
			} else {
				popup = AlertPopUp.errorNoOkay('Cannot edit a Menu unless the Category is known at runtime and now the Category is not known.\nThis is a programming error. Kindly perform the required maintenance to resolve this issue before proceeding.','ERROR MenuController.101');
				PopUpManager.centerPopUp(popup);
			}
		}
		
		public static function deleteAndRemoveAllMenuChildren():void {
			var mcr:* = MenuController.callback_GlobalsVO('getGlobal',"MenuController");
			if (mcr != null) {
				mcr.deleteAndRemoveAllMenuChildren();
			}
		}
		
		public static function dismissChildrenObjects():void {
			var mcr:* = MenuController.callback_GlobalsVO('getGlobal',"MenuController");
			if (mcr != null) {
				mcr.dismissChildrenObjects();
			}
		}
		
		public static function ignoreMenuEvents():void {
			var mcr:* = MenuController.callback_GlobalsVO('getGlobal',"MenuController");
			if (mcr != null) {
				mcr.ignoreMenuEvents();
			}
		}
		
		public static function dismissFakeMenuImages():void {
			var mcr:* = MenuController.callback_GlobalsVO('getGlobal',"MenuController");
			if (mcr != null) {
				mcr.dismissFakeMenuImages();
			}
		}
		
		public static function handle_registered_category(aContainer:*,aCategory:*,category_label:*):void {
			var aChild:* = aContainer;
			var popup:MenuItemActions;
			var popup_id:String = 'btn_admin_add';
			var items:Array = [];
			var isFakeCategory:Boolean = (aCategory.className == 'FakeCategory');
			var category_dp:* = (isFakeCategory) ? MenuController._currentTargetMenuBarDataProvider.headerData.data.gLinks[MenuController._currentTargetMenuBarDataProvider.headerData.name] : MenuController._currentTargetMenuBarDataProvider.menuData.data[aCategory.categoryPosition];
			var uuid:String = category_dp[MenuController._currentTargetMenuBarDataProvider.metaData.hash.uuid];

			var tips:Array = [];
			var toolTip:String = '';			
			
			var isEmpty:Boolean = ObjectUtils.isEmpty(MenuController._currentSelectedMenu);
			var hasSubMenus:Boolean = (category_dp[MenuController._currentTargetMenuBarDataProvider.menuData.name] is Array) && (category_dp[MenuController._currentTargetMenuBarDataProvider.menuData.name].length > 0);
			if (isEmpty == false) {
				if (isFakeCategory) {
	            	tips.push({'label':'Add','index':0});
	            	tips.push({'label':'Reorder','index':1});
		            items = [
		            			{'label':'Add Global Links Item...','name':'add_menu_item','icon':MenuController.adminAddIcon,'category':aCategory,'category_dp':category_dp,'_label':category_label,'currentTarget':aCategory}
		            		];
		            if (hasSubMenus) {
		            	items.push({'label':'Reorder Global Links Items...','name':'reorder_menu_items','icon':MenuController.adminReorderIcon,'category':aCategory,'category_dp':category_dp,'_label':category_label,'currentTarget':aCategory});
		            }
				} else {
	            	tips.push({'label':'Reorder','index':0});
	            	tips.push({'label':'Add','index':1});
	            	tips.push({'label':'Edit','index':2});
		            items = [
		            			{'label':'Add Menu Item to Category "' + category_label.text + '"...','name':'add_submenuitem2','icon':MenuController.adminAddIcon,'category':aCategory,'category_dp':category_dp,'_label':category_label,'currentTarget':aCategory},
		            			{'label':'Edit Menu Category Item "' + category_label.text + '"...','name':'edit_category_item','icon':MenuController.adminEditIcon,'category':aCategory,'category_dp':category_dp,'_label':category_label,'currentTarget':aCategory},
		            		];
		            if (hasSubMenus) {
		            	items.push({'label':'Reorder Menu Items in Category "' + category_label.text + '"...','name':'reorder_menu_items','icon':MenuController.adminReorderIcon,'category':aCategory,'category_dp':category_dp,'_label':category_label,'currentTarget':aCategory});
		            }
				}
			} else {
	            items = [{'label':'Admin Tool is in View-Only Mode pending the selection of a Menu using the Control Panel...','name':'add_menu_item','icon':MenuController.adminAddDisabledIcon,'category':aCategory,'category_dp':category_dp,'_label':category_label}];
			}

			popup = new MenuItemActions();
			popup.x = (MenuController.isLoggedOut) ? 0 : 0;
			popup.y = 0;
			popup.height = 16;
			popup.width = 14;
			popup.styleName = 'AdminButton';
			popup.id = popup_id;

			tips.sortOn('index');
			tips = ArrayUtils.collectUsingSelector(tips,'label');
			toolTip = (isEmpty) ? 'Admin Tool is in View-Only Mode pending the selection of a Named Menu using the Control Panel...' : tips.join('/') + ' the ' + ((popup.menuLevel < MenuController._maxMenuDepth) ? 'highlighted category or the item(s) found below ' : 'selected category') + ' "' + category_label.text + '"...';

			popup.items = items;
			popup.toolTip = toolTip;

			popup._ignoreMenuEvents = MenuController.ignoreMenuEvents;
			var container:* = (isFakeCategory) ? aChild : aChild.parent;
			if (!isFakeCategory) {
				container._categoryWidth = (MenuController.isLoggedOut) ? -10 : 0;
			}
			if (MenuController.isLoggedOut) {
				popup.x = popup.width * 1.5;
				//aChild.addChild(popup); // DO NOT CHANGE THIS LINE OF CODE !
			} else {
				popup.x = 10;
				//container.addChild(popup); // DO NOT CHANGE THIS LINE OF CODE !
			}
			popup.connect_to_menuController(MenuController.callback_GlobalsVO('getGlobal',"MenuController"));
			if (!isFakeCategory) {
				category_label.text = ' ' + category_label.text;
			}
			popup.addEventListener(FlexEvent.CREATION_COMPLETE, 
				function(event:FlexEvent):void { 
					var target:MenuItemActions = event.currentTarget as MenuItemActions;
					var child:* = target.getChildByName('popup');
					if (child) {
						child.labelField = 'label';
						child.dataProvider = target.items;
						child.toolTip = target.toolTip;
						child.target = target;
						if (isEmpty == false) {
							child.addEventListener("itemClick", function (event:*):void {MenuController.onClick_PopUpMenu_ActionBtn(event)}); 
						}
					} else {
						AlertPopUp.errorNoOkay('Programming Error - you should never see this message but you have so there is a problem and your menu cannot be edited at this time until this error has been resolved. Sorry...','ERROR MenuController.201');
					}
				});
			aCategory.menuItems = items;
			aCategory.menuToolTip = toolTip;
		}
		
		public static function registerCategory(aContainer:*,aCategoryObject:*,category_label:*):void {
			MenuController.handle_registered_category(aContainer,aCategoryObject,category_label);
		}
		
		private static function handle_registered_menuitem(aMenuItemObject:*,parentSelector:String,parentClassName:String,GlobalsVO:*,labelSelector:String,dataSelector:*,menuModel:*,currentDataContainer:*):void {
			var aChild:* = aMenuItemObject;
			var aClassName:String = aChild.className;
			var aParent:* = aChild;
			var isLevel2:Boolean = aClassName == 'MenuItem';
			var isLevel3:Boolean = aClassName == 'MenuText';
			var aLabel:*;
			var dataModel:* = MenuController.callback_GlobalsVO('getGlobal',dataSelector);
			try { aLabel = menuModel[dataModel.metaData.hash[labelSelector]]; } catch (e:Error) { aLabel = null; };
			var popup:MenuItemActions;
			var popup_id:String = 'btn_admin_add_menuitem';
			var parentDp:* = MenuController._currentTargetMenuBarDataProvider;
			var aCategory:*;
			var uuid:String = menuModel[dataModel.metaData.hash.uuid];

			try { aCategory = aMenuItemObject[parentSelector]; } catch (e:Error) { aCategory = aMenuItemObject.parent; }
			while (aCategory) {
				try {
					if (aCategory[parentSelector].className == parentClassName) {
						aCategory = aCategory[parentSelector];
						break;
					}
				} catch (e:Error) { }
				try { aCategory = aCategory[parentSelector]; } catch (e:Error) { aCategory = aCategory.parent; }
			}

			var isFalseCategory:Boolean = (aCategory == null);

			var label_text:String = (aLabel) ? aLabel : '*UNKNOWN*';
			var menuData:* = (isFalseCategory) ? aChild.currentData : dataModel.menuData.data;
			
			if (!isFalseCategory) {
				var hOrientation:int = dataModel.metaData.hash['hOrientation'];
				var catPos:int = aCategory.categoryPosition;
				var catTotal:int = menuData.length;
				var isMirror:Boolean = (catPos >= (catTotal+hOrientation));
				var category_dp:* = menuData[aCategory.categoryPosition];
			}

			var isSpecialPopUp:Boolean = false;
			popup = new MenuItemActions();
			popup.height = 16;
			popup.width = 14;
			popup.isMirror = isMirror;
			popup.x = 0;
			popup.y = (aParent.height/2)-(popup.height/2);
			if (popup.y < 0) {
				try {
					aParent.barHeight = popup.height; 
					isSpecialPopUp = true;
					popup.y = aParent.y;
					label_text = 'Menu Separator'; // this is the only item that does not have a label...
				} catch (e:Error) {} // the special case is the only one that implements the "barHeight" method...
			}

			popup.id = popup_id;
			popup.parentSelector = parentSelector;
			popup._ignoreMenuEvents = MenuController.ignoreMenuEvents;
			
			var toolTip:String;

			var isEmpty:Boolean = ObjectUtils.isEmpty(MenuController._currentSelectedMenu);

			var items:Array = [];

			var tips:Array = [];			

			var hasSubMenus:Boolean = (menuModel[MenuController._currentTargetMenuBarDataProvider.menuData.name] is Array) && (menuModel[MenuController._currentTargetMenuBarDataProvider.menuData.name].length > 0);

        	popup.menuLevel = (isLevel2) ? 2 : ((isLevel3) ? 3 : 1);
			if (!isFalseCategory) {
				if (isSpecialPopUp == false) {
		            if (isEmpty) {
		            	//items.push({'label':'Reorder Menu Items','name':''});
		            } else if (hasSubMenus) {
		            	tips.push({'label':'Reorder','index':0});
			            items.push({'label':'Reorder...','name':'reorder_menu_items','icon':MenuController.adminReorderIcon,'menuitem':menuModel,'category_dp':category_dp,'category':aCategory,'_label':aLabel,'currentTarget':aMenuItemObject,'currentDataContainer':currentDataContainer});
		            }
				}
			}
			if (uuid is String) {
				var aGenerator:Generator = MenuController.uuid_to_generator[uuid];
				if (aGenerator) {
					var isTitleNode:Boolean = GeneratorUtils.isTitleNode(aGenerator);
					var isProfileNode:Boolean = GeneratorUtils.isProfileNode(aGenerator);
					if ( (!isTitleNode) && (!isProfileNode) ) {
						tips.push({'label':'Delete','index':3});
			        	items.push({'label':'Delete...','name':'delete_menuitem','icon':((isEmpty) ? MenuController.adminDeleteDisabledIcon : MenuController.adminDeleteIcon),'menuitem':menuModel,'category_dp':category_dp,'category':aCategory,'_label':aLabel,'currentTarget':aMenuItemObject,'currentDataContainer':currentDataContainer});
					}
				}
			}
            
			if (isSpecialPopUp) {
				//aParent.addChild(popup); // DO NOT CHANGE THIS LINE OF CODE !
			} else {
				tips.push({'label':'Edit','index':2});
	            items.push({'label':'Edit...','name':'edit_menuitem','icon':((isEmpty) ? MenuController.adminEditDisabledIcon : MenuController.adminEditIcon),'menuitem':menuModel,'category_dp':category_dp,'category':aCategory,'_label':aLabel,'currentTarget':aMenuItemObject,'currentDataContainer':currentDataContainer});
	            if (!isFalseCategory) {
		            if (popup.menuLevel < MenuController._maxMenuDepth) {
		            	tips.push({'label':'Add','index':1});
			            items.push({'label':'Add...','name':'add_submenuitem','icon':((isEmpty) ? MenuController.adminAddDisabledIcon : MenuController.adminAddIcon),'menuitem':menuModel,'category_dp':category_dp,'category':aCategory,'_label':aLabel,'currentTarget':aMenuItemObject,'currentDataContainer':currentDataContainer});
		            }
	            }
	            if (menuData != null) {
					//aParent.addChild(popup);  // DO NOT CHANGE THIS LINE OF CODE !
	            }
			}
			tips.sortOn('index');
			tips = ArrayUtils.collectUsingSelector(tips,'label');
			toolTip = (isEmpty) ? 'Admin Tool is in View-Only Mode pending the selection of a Named Menu using the Control Panel...' : tips.join('/') + ' the ' + ((popup.menuLevel < MenuController._maxMenuDepth) ? 'highlighted menu item or the item(s) found below ' : 'selected menuitem') + ' "' + label_text + '"...';

			popup.items = items;
			popup.toolTip = toolTip;
			popup.connect_to_menuController(MenuController.callback_GlobalsVO('getGlobal',"MenuController"));

			popup.addEventListener(FlexEvent.CREATION_COMPLETE, 
				function(event:FlexEvent):void { 
					var target:MenuItemActions = event.currentTarget as MenuItemActions;
					var child:SmartPopUpMenuButton = target.getChildByName('popup') as SmartPopUpMenuButton;
					if (child) {
						child.labelField = 'label';
						child.toolTip = target.toolTip;
						child.dataProvider = target.items;
						child.target = target;
						if (isEmpty == false) {
							child.addEventListener("itemClick", function (event:*):void {MenuController.onClick_PopUpMenu_ActionBtn(event)}); 
						}
					} else {
						AlertPopUp.errorNoOkay('Programming Error - you should never see this message but you have so there is a problem and your menu cannot be edited at this time until this error has been resolved. Sorry...','ERROR MenuController.301');
					}
				});
			aMenuItemObject.menuItems = items;
			aMenuItemObject.menuToolTip = toolTip;
		}
		
		public static function registerMenuItem(aMenuItemObject:*,parentSelector:String,parentClassName:String,GlobalsVO:*,labelSelector:String,dataSelector:*,menuModel:*,currentDataContainer:*):void {
			MenuController.handle_registered_menuitem(aMenuItemObject,parentSelector,parentClassName,GlobalsVO,labelSelector,dataSelector,menuModel,currentDataContainer);
		}

		public static function getCurrentUserString():String {
			var toks:Array = MenuController.userID.split(',');
			return ((MenuController.userID.length > 0) ? StringUtils.urlDecode(toks[0]) : '(NO USER - Please Login)');
		}

		private static var _control_panel_title:String = '';
						
		public static function updateControlPanelTitleWith(someText:String):void {
			try {
				if (MenuController._control_panel_title.length == 0) {
					MenuController._control_panel_title = MenuController.controlPanel.parent['title'];
				}
				MenuController.controlPanel.parent['title'] = MenuController._control_panel_title + ' :: USER: ' + getCurrentUserString() + ' (' + WmsAPI.menuType + ') : ' + someText + ' ' + MenuController.controlPanel.panel_title.text;
			} catch (e:Error) {}
		}
		
		private static function getMenuCount(parent:*):void {
            function onResultMenuCountJSON(event:ResultEvent):void {
				var response:*;
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					response = (response is ObjectProxy) ? response.valueOf() : response;
					MenuController._numMenus = response.count;
				} catch (e:Error) {
					var stackTrace2:String = e.getStackTrace();
					AlertPopUp.errorNoOkay('<MenuController> :: getMenuCount.onResultMenuCountJSON\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace2,1024),'ERROR MenuController.401');
				} finally {
	            	parent.enabled = true;
		        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
				}
            }
            
            if ( (MenuController.userID is String) && (MenuController.userID.length > 0) ) {
	        	parent.enabled = false;
	        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Get_Menu_Count);
				var url:String = WmsAPI.api_Get_Menu_Count(MenuController.userID);
	        	MenuController.ezREST.send(url, onResultMenuCountJSON, MenuController.ezREST.jsonResultType);
            }
		}

		private static function update_menu_selection(aMenu_or_uuid:*):void {
            function onResultSetMenuSelectionJSON(event:ResultEvent):void {
				var response:*;
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					response = (response is ObjectProxy) ? response.valueOf() : response;
				} catch (e:Error) {
					var stackTrace2:String = e.getStackTrace();
					// BEGIN: Ignore this for now - there is no requirement to set the menu selection for WMS...
					//AlertPopUp.errorNoOkay('<MenuController> :: initialize_control_panel.onResultSetMenuSelectionJSON\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace2,1024),'ERROR MenuController.901');
					// END!   Ignore this for now - there is no requirement to set the menu selection for WMS...
				} finally {
	            	MenuController.parent.enabled = true;
		        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
					MenuController.getMenus();
				}
            }
            
        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Set_Menu_Selection);

			var aUuid:String = (aMenu_or_uuid is String) ? aMenu_or_uuid : aMenu_or_uuid.uuid;

			var url:String = WmsAPI.api_Set_Menu_Selection(aUuid,MenuController.userID);

        	MenuController.ezREST.send(url, onResultSetMenuSelectionJSON, MenuController.ezREST.jsonResultType);
		}
		
    	public static function do_action(event:TimerEvent):void {
    		var timer:Timer = event.currentTarget as Timer;
    		
        	var aFunc:*;

        	if (MenuController.action_stack.length > 0) {
        		aFunc = MenuController.action_stack.pop();
        		if (aFunc is Function) {
        			try {
						//trace('do_action().2 timer.stop() !');
			    		timer.stop();
        				aFunc();
        			} catch (e:Error) {}
        		} else {
        			var _aFunc:Function = aFunc.callback;
        			if (_aFunc is Function) {
	        			try {
	        				if (aFunc.args is Array) {
		        				_aFunc(aFunc.args);
	        				} else {
		        				_aFunc();
	        				}
	        			} catch (e:Error) {}
        			}
        		}
        	} else {
	    		timer.stop();
        	}
        	MenuController.parent.enabled = true;
        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
    	}

		public static function getMenus():void {
			function onClickMenuChoiceBtn(event:MenuEvent):void {
				var menu:Menu = event.currentTarget as Menu;
				MenuController._currentSelectedMenuId = menu.selectedIndex;

				MenuController._currentSelectedMenu = event.item;
				var aMenu:Object = menu.dataProvider[(menu.selectedIndex > -1) ? menu.selectedIndex : 0];
				MenuController._currentSelectedMenu = aMenu;
				
				//trace('### getMenus().1 !');
				MenuController.controlPanel.label_release.text = aMenu.name;
				MenuController.controlPanelBottom.refresh_envs();

        		MenuController._expected_UUID = (new String(aMenu.uuid)).toString();

				MenuController.trigger_update_menu_selection = true;
				
				MenuController.mySO.data._expected_UUID = MenuController._expected_UUID;
				MenuController.mySO.flush();
				
				menu.callLater(MenuController.getMenus);
			}
			
            function onResultMenusJSON(event:ResultEvent):void {
				var response:*;
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					response = (response is ObjectProxy) ? response.valueOf() : response;

					MenuController._numMenus = 0;
	                var aMenu:Menu = new Menu();
	                var dp:Array = [];
					//trace('getMenus().1 MenuController._currentSelectedMenuId='+MenuController._currentSelectedMenuId);
                	dp.push({label: "Select GN Release"});
	                var node:Object;
	                var iSelection:int = 0;
	                for (var i:String in response) {
	                	node = response[i];
	                	node['label'] = node.name;
	                	if (node['selected'] != null) {
		                	delete node['selected'];
	                	}
						if (MenuController._currentSelectedMenuId > 0) {
		                	node['selected'] = ((MenuController._numMenus+1) == MenuController._currentSelectedMenuId) ? true : false;
		                	iSelection = MenuController._currentSelectedMenuId;
						}
						//trace('getMenus().2 node='+(new ObjectExplainer(node)).explainThisWay());
	                	dp.push(node);
	                	MenuController._numMenus++;
	                }
	                aMenu.dataProvider = dp;
	                //MenuController._currentSelectedMenuId = aMenu.selectedIndex = iSelection;
	                //aMenu.selectedIndex = iSelection;
					//trace('getMenus().2 aMenu.selectedIndex='+aMenu.selectedIndex);
					//trace('getMenus().3 MenuController._currentSelectedMenuId='+MenuController._currentSelectedMenuId);
	                aMenu.addEventListener("itemClick", onClickMenuChoiceBtn);
	                MenuController.controlPanel.btn_menuChoice.popUp = aMenu;

	                MenuController.controlPanel.dispatchEvent(new MenuChangedEvent(MenuChangedEvent.TYPE_MENU_CHANGED_EVENT,aMenu));
	                MenuController.controlPanel.dispatchEvent(new MenuDataChangedEvent(MenuDataChangedEvent.TYPE_MENU_DATA_CHANGED_EVENT));

	                if (MenuController._currentSelectedMenuId > 0) {
		            	MenuController._currentSelectedMenu = dp[MenuController._currentSelectedMenuId];
	                } else {
		            	MenuController._currentSelectedMenu = {};
		            	MenuController._currentSelectedMenuId = -1;
	                }
		        	MenuController.action_stack.push(MenuController.getMenu);
		        	
		        	MenuController.controlPanel.refresh_btnSaveMenuAs();

				} catch (e:Error) {
					var stackTrace2:String = e.getStackTrace();
					AlertPopUp.errorNoOkay('<MenuController> :: getMenus.onResultMenusJSON\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace2,1024),'ERROR MenuController.501');
				} finally {
	            	if (MenuController.callback is Function) {
	            		MenuController.callback();
	            	}
	            	
	            	MenuController.timer = new Timer(250);
	            	MenuController.timer.addEventListener(TimerEvent.TIMER, MenuController.do_action);
	            	MenuController.timer.start();
				}
            }
            
        	MenuController.parent.enabled = false;
        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Get_Menus);
			var url:String = WmsAPI.api_Get_Menus(MenuController.userID);
        	MenuController.ezREST.send(url, onResultMenusJSON, MenuController.ezREST.jsonResultType);
		}

		public static function performMenuPublish(event:*):void {
			var parent:* = MenuController._currentTargetMenuBar;
            function onResultMenuPublishJSON(event:ResultEvent):void {
				var response:*;
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					response = (response is ObjectProxy) ? response.valueOf() : response;
				} catch (e:Error) {
					var stackTrace2:String = e.getStackTrace();
					AlertPopUp.errorNoOkay('<MenuController> :: performMenuPublish.onResultMenuDeleteJSON\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace2,1024),'ERROR MenuController.610');
				} finally {
	            	parent.enabled = true;
		        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
	            	try { MenuController.reloadMenus_callback() } catch (e:Error) { }
	            	MenuController.getMenus();
				}
            }

        	if (event.detail == Alert.YES) {
            	parent.enabled = false;
	        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Publish_Menu);
				var url:String = WmsAPI.api_Publish_Menu(MenuController.userID,MenuController._currentSelectedMenu.uuid,event.envs);
            	MenuController.ezREST.send(url, onResultMenuPublishJSON, MenuController.ezREST.jsonResultType);
        	}
		}
						
		public static function performMenuDelete(event:CloseEvent):void {
			var parent:* = MenuController._currentTargetMenuBar;
            function onResultMenuDeleteJSON(event:ResultEvent):void {
				var response:*;
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					response = (response is ObjectProxy) ? response.valueOf() : response;
				} catch (e:Error) {
					var stackTrace2:String = e.getStackTrace();
					AlertPopUp.errorNoOkay('<MenuController> :: performMenuDelete.onResultMenuDeleteJSON\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace2,1024),'ERROR MenuController.601');
				} finally {
	            	parent.enabled = true;
		        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
	            	try { MenuController.reloadMenus_callback() } catch (e:Error) { }
	            	MenuController.getMenus();
				}
            }

        	if (event.detail == Alert.YES) {
            	parent.enabled = false;
	        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Delete_Menu_By_UUID);
				var url:String = WmsAPI.api_Delete_Menu_By_UUID(MenuController.userID,MenuController._currentSelectedMenu.uuid);
            	MenuController.ezREST.send(url, onResultMenuDeleteJSON, MenuController.ezREST.jsonResultType);
        	}
		}
						
		public static function getMenu():void {
        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Get_Menu_By_UUID);
			var url:String;
        	var uuid:String = MenuController._currentSelectedMenu.uuid;

        	if ( (uuid is String) && (uuid.length > 0) ) {
				url = WmsAPI.api_Get_Menu_By_UUID(MenuController.userID,uuid);
				if (MenuController.callback_sendDataToMenuModel is Function) {
					try {
						MenuController.callback_sendDataToMenuModel(url);
					} catch (e:Error) {
						AlertPopUp.errorNoOkay('<MenuController>.<getMenu> :: 2.2\n' + e.message.toString(),'ERROR MenuController.1001.1');
					}
				}
        	} else {
	        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
        	}
		}
						
		public static function handleMenuNameRenamePopUp(parent:*,popup:MenuNameRenamePopUp):void {
            function onResultMenuRenameJSON(event:ResultEvent):void {
				var response:*;
				var uuid:String;
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					response = (response is ObjectProxy) ? response.valueOf() : response;
					uuid = response.uuid;
				} catch (e:Error) {
					var stackTrace2:String = e.getStackTrace();
					AlertPopUp.errorNoOkay('<MenuController> :: handleMenuNameRenamePopUp.onResultMenuRenameJSON\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace2,1024),'ERROR MenuController.1001');
				} finally {
	            	parent.enabled = true;
		        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
	            	MenuController.getMenus();
				}
            }

        	parent.enabled = false;
        	var menuName:String = popup.txt_new_menu_name.text;
        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Rename_Menu_by_UUID);
			var url:String = WmsAPI.api_Rename_Menu_by_UUID(MenuController.userID,MenuController._currentSelectedMenu.uuid,menuName);
        	MenuController.ezREST.send(url, onResultMenuRenameJSON, MenuController.ezREST.jsonResultType);
		}
			
		public static function onClick_btnRenameSelectedMenu(event:Event):void {
			function popuUpRenameMenuNameEditor(menuName:String):void {
				var parent:* = MenuController.parent;
				parent.enabled = false;
				var popup:MenuNameRenamePopUp = PopUpManager.createPopUp(parent, MenuNameRenamePopUp, true) as MenuNameRenamePopUp;
				popup.width = 500;
				PopUpManager.centerPopUp(popup);
				popup.txt_current_menu_name.text = menuName;
				popup.btn_save.addEventListener(MouseEvent.CLICK, function (event:MouseEvent):void { parent.enabled = true; PopUpManager.removePopUp(popup); MenuController.handleMenuNameRenamePopUp(parent,popup); });
				popup.btn_dismiss.addEventListener(MouseEvent.CLICK, function (event:MouseEvent):void { parent.enabled = true; PopUpManager.removePopUp(popup); });
			}

			popuUpRenameMenuNameEditor(MenuController._currentSelectedMenu.name);
		}

		private static function issue_JSON_communications_error_popup(id:String='#000',reason:String='Server Communications'):void {
			AlertPopUp.errorNoOkay('The server is not responding as it should however this is a pretty serious error.  Kindly have someone take a look at the server to ensure it is working correctly.\nYour menu may not have been handled correctly by the server.','ERROR ' + id + ' Reason: ' + reason + '.');
		}
		
		public static function callback_getData_done(e:*):void {
			//trace('### MenuController.callback_getData_done().1 --> e.result='+e.result);
			var data:* = JSON.decode(e.data);
			var keys:Array = ObjectUtils.keys(data);
			var aUuid:String = '';
			var uuid:String = data['uuid'];
			if ( (uuid is String) && (uuid == MenuController._expected_UUID) ) {
				aUuid = uuid;
			} else {
				uuid = data[keys[0]]['uuid'];
				if ( (uuid is String) && (uuid == MenuController._expected_UUID) ) {
					aUuid = uuid;
				} else {
					aUuid = new String(MenuController._expected_UUID);
					MenuController._expected_UUID = aUuid;
				}
			}
			if ( (MenuController.timer is Timer) && (MenuController.timer.running) ) {
				MenuController.timer.stop();
				MenuController.action_stack.pop();
			}
			if ( (aUuid is String) && (aUuid == MenuController._expected_UUID) ) {
				// all is well...
    			MenuController.loaded_expected_UUID = true;
				if (MenuController.trigger_update_menu_selection) {
					// BEGIN:  DO NOT UNCOMMENT THIS LINE OF CODE BECAUSE IT IS NO LONGER NEEDED...
					MenuController.update_menu_selection(aUuid);
					// END!    DO NOT UNCOMMENT THIS LINE OF CODE BECAUSE IT IS NO LONGER NEEDED...
					MenuController.trigger_update_menu_selection = false;
				}
			} else {
				MenuController.issue_JSON_communications_error_popup('#101 - UUID Mismatch !');
			}
		}
		
		public static function perform_garbage_collection():void {
			var menu:Object = MenuController.menuModel.metaData.name;
			var data:Array = MenuController.menuModel.menuData.data;
			var metaDomain:*;
			var metaDomainKey:*;
			if (MenuController.menuModel.metaDomain != null) {
    			metaDomain = MenuController.menuModel.metaDomain.data;
			}
			if (MenuController.menuModel.metaDomainKey != null) {
    			metaDomainKey = MenuController.menuModel.metaDomainKey.data;
			}
			var i:int = -1;
		}

		public static function menu_model_as_obj(doInitialize:Boolean=false):Object {
			var obj:Object = {};
			obj['menu'] = {};
			var metafield:String = MenuController.callback_GlobalsVO('METAFIELD');
			var datafield:String = MenuController.callback_GlobalsVO('DATAFIELD');
			var headerfield:String = MenuController.callback_GlobalsVO('HEADERFIELD');
			obj['menu'][MenuController.menuModel.metaData.name] = MenuController.menuModel.metaData.data;
			obj['menu'][MenuController.menuModel.headerData.name] = MenuController.menuModel.headerData.data;
			var data:Array = MenuController.menuModel.menuData.data;
			if (doInitialize) {
				var aNode:Object;
				for (var i:String in data) {
					aNode = data[i];
					aNode[MenuController.menuModel.menuData.name] = [];
				}
			}
			obj['menu'][MenuController.menuModel.menuData.name] = data;
			obj['menu'][datafield] = MenuController.menuModel.menuData.name;
			obj['menu'][metafield] = MenuController.menuModel.metaData.name;
			obj['menu'][headerfield] = MenuController.menuModel.headerData.name;
			obj['menu']['uuid'] = MenuController._expected_UUID;
			if (MenuController.menuModel.metaDomain != null) {
    			obj['menu']['meta_domain'] = MenuController.menuModel.metaDomain.data;
			}
			if (MenuController.menuModel.metaDomainKey != null) {
    			obj['menu']['meta_domain_key'] = MenuController.menuModel.metaDomainKey.data;
			}
        	return obj;
		}
		
		public static function menu_model_as_json(doInitialize:Boolean=false):String {
			var obj:Object = MenuController.menu_model_as_obj(doInitialize);
        	var json:JSONEncoder = new JSONEncoder(obj);
        	return json.getString();
		}
		
		public static function popuUpNewMenuNameEditor(menuName:String,isSaveAsState:Boolean=false):void {
			var parent:* = MenuController.parent;

			function handleMenuNamePopUp(popup:MenuNamePopUp):void {
            	parent.enabled = false;
            	var menuName:String = popup.txt_menu_name.text;
            	var isSaveAs:Boolean = popup.isSaveAsState;
            	
            	function handle_menu_names_loaded(event:MenuDataChangedEvent):void {
            		MenuController.controlPanel.removeEventListener(MenuDataChangedEvent.TYPE_MENU_DATA_CHANGED_EVENT,handle_menu_names_loaded);
            		var aMenu:Menu = MenuController.controlPanel.btn_menuChoice.popUp as Menu;
            		var ac:ArrayCollection = aMenu.dataProvider as ArrayCollection;
            		var i:int = ArrayCollectionUtils.findIndexOfItem(ac,'label',menuName);
            		if (i > -1) {
	            		//aMenu.selectedIndex = i;
	            		//trace('handle_menu_names_loaded().1 --> aMenu.selectedIndex='+aMenu.selectedIndex);
	            		aMenu.dispatchEvent(new MenuEvent(MenuEvent.ITEM_CLICK));
            		}
            	}
            	
		        function onResultMenuSaveAsJSON(event:ResultEvent):void {
					var response:*;
					try {
						response = (event.result is String) ? event.result : event.result.getItemAt(0);
						response = (response is ObjectProxy) ? response.valueOf() : response;
						if (response.menu is String) {
							response = JSON.decode(response.menu);
						}
					} catch (e:Error) {
						var stackTrace2:String = e.getStackTrace();
						AlertPopUp.errorNoOkay('<MenuController> :: popuUpNewMenuNameEditor.onResultMenuSaveAsJSON\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace2,1024),'ERROR MenuController.1301');
					} finally {
						if ( ( (response.uuid != null) && (response.uuid is String) && (response.uuid.length > 0) ) || ( (response.menu.uuid != null) && (response.menu.uuid is String) && (response.menu.uuid.length > 0) ) ) {
							if ( (response.uuid != MenuController._expected_UUID) && (response.menu.uuid != MenuController._expected_UUID) ) {
								MenuController.issue_JSON_communications_error_popup('#103 - UUID Mismatch in response !');
							} else {
					        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
					        	MenuController.action_stack.push(MenuController.getMenu);
					        	//trace('### popuUpNewMenuNameEditor() --> MenuController.getMenus()');
				            	MenuController.getMenus();
							}
						} else {
							MenuController.issue_JSON_communications_error_popup('#102 - UUID Missing from response !');
						}
					}
		        }
		        
        		MenuController.controlPanel.addEventListener(MenuDataChangedEvent.TYPE_MENU_DATA_CHANGED_EVENT, handle_menu_names_loaded);
        		
        		var url:String;
        		var s_json:String;
        		
	        	MenuController.updateControlPanelTitleWith((isSaveAsState == true) ? WmsAPI.caption_Set_Menu_by_UIUD : WmsAPI.caption_New_Menu_By_UUID);
        		MenuController._expected_UUID = GUID.create();
				var localMode:Boolean = MenuController.callback_GlobalsVO('LOCALMODE') as Boolean;
	        	trace('### MenuController.popuUpNewMenuNameEditor.handleMenuNamePopUp().0.0 isSaveAsState='+isSaveAsState);
	        	trace('### MenuController.popuUpNewMenuNameEditor.handleMenuNamePopUp().0.1 localMode='+localMode);
        		if (isSaveAsState == true) {
		        	s_json = MenuController.menu_model_as_json();
		        	trace('### MenuController.popuUpNewMenuNameEditor.handleMenuNamePopUp().1 s_json='+s_json);
					url = WmsAPI.api_New_Menu_By_UUID(MenuController.userID,MenuController._expected_UUID,menuName);
		        	MenuController.ezREST.post(url, s_json, onResultMenuSaveAsJSON, MenuController.ezREST.jsonResultType);
        		} else if ( (isSaveAsState == false) && (localMode == false) ) {
		        	s_json = MenuController.menu_model_as_json(true);
		        	trace('### MenuController.popuUpNewMenuNameEditor.handleMenuNamePopUp().2 s_json='+s_json);
					url = WmsAPI.api_New_Menu_By_UUID(MenuController.userID,MenuController._expected_UUID,menuName);
		        	MenuController.ezREST.post(url, s_json, onResultMenuSaveAsJSON, MenuController.ezREST.jsonResultType);
        		} else {
					url = WmsAPI.api_New_Menu_By_UUID(MenuController.userID,MenuController._expected_UUID,menuName);
					if (MenuController.callback_sendDataToMenuModel is Function) {
						try {
							MenuController.callback_sendDataToMenuModel(url);
						} catch (e:Error) {
							AlertPopUp.errorNoOkay('<MenuController>.<popuUpNewMenuNameEditor>.<handle_menu_names_loaded> :: 2.2\n' + e.message.toString(),'ERROR MenuController.1201.1');
						}
					}
        		}
			}

			parent.enabled = false;
			var popup:MenuNamePopUp = PopUpManager.createPopUp(parent, MenuNamePopUp, true) as MenuNamePopUp;
			var aMenu:Menu = MenuController.controlPanel.btn_menuChoice.popUp as Menu;
			var model:ArrayCollection = aMenu.dataProvider as ArrayCollection;
			popup.menu_list_data_provider = model;
			popup.width = 500;
			if (isSaveAsState == true) {
				popup.saveAsState();
			}
			PopUpManager.centerPopUp(popup);
			popup.txt_menu_name.text = menuName;
			popup.btn_save.addEventListener(MouseEvent.CLICK, function (event:MouseEvent):void { parent.enabled = true; PopUpManager.removePopUp(popup); handleMenuNamePopUp(popup); });
			popup.btn_dismiss.addEventListener(MouseEvent.CLICK, function (event:MouseEvent):void { parent.enabled = true; PopUpManager.removePopUp(popup); });
		}
			
		public static function popuUpSaveMenuAs():void {
			MenuController.popuUpNewMenuNameEditor('',true);
		}
		
		public static function onClick_btnNewMenu(event:MouseEvent):void {
			MenuController.popuUpNewMenuNameEditor('');
		}
		
		public static function onClick_btnSaveMenuAs(event:MouseEvent):void {
			MenuController.popuUpSaveMenuAs();
		}
			
		public static function setMenuJSON(json:String):void {
	        function onResultSetMenuJSON(event:ResultEvent):void {
				var response:*;
				try {
					response = (event.result is String) ? event.result : event.result.getItemAt(0);
					response = (response is ObjectProxy) ? response.valueOf() : response;
				} catch (e:Error) {
					var stackTrace2:String = e.getStackTrace();
					AlertPopUp.errorNoOkay('<MenuController> :: setMenuJSON.onResultSetMenuJSON\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace2,1024),'ERROR MenuController.1302');
				} finally {
		        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Ready);
		        	MenuController.getMenu();
				}
	        }

        	MenuController.updateControlPanelTitleWith(WmsAPI.caption_Set_Menu_by_UIUD);
			var url:String = WmsAPI.api_Set_Menu_by_UIUD(MenuController.userID,MenuController._currentSelectedMenu.uuid);
        	MenuController.ezREST.post(url, json, onResultSetMenuJSON, MenuController.ezREST.jsonResultType);
		}

        public static function onClick_save_admin_reorder_popup(event:MouseEvent):void {
        	var popup:ReorderPanel = event.currentTarget.parentDocument as ReorderPanel;
        	var dp:* = popup.dataProvider;

        	PopUpManager.removePopUp(popup);
        	var s_json:String = MenuController.menu_model_as_json();
        	MenuController.setMenuJSON(s_json);
        }
		
        public static function onClick_save_admin_editor_popup(event:MouseEvent):void {
        	var popup:SmartMenuFlyoutItemAdmin = event.currentTarget.parentDocument as SmartMenuFlyoutItemAdmin;
        	var menuitem:Object = popup.asObject;
        	
			var aMenuItem:* = popup.source;
        	var source_dp:* = popup.source_dp;

        	var ar:Array = [];
        	
			if (popup.isAddSubMenuItem) {
				if (!(aMenuItem is Array)) {
					if (aMenuItem[MenuController.menuModel.menuData.name] == null) {
						aMenuItem[MenuController.menuModel.menuData.name] = [];
					}
					ar = aMenuItem[MenuController.menuModel.menuData.name];
				} else {
					ar = aMenuItem;
				}
			} else {
				ObjectUtils.replicateDataFromInto(menuitem,source_dp);
			}
			
			if (popup.isAddSubMenuItem) {
	        	ar.push(menuitem);
			}

        	PopUpManager.removePopUp(popup);
        	var s_json:String = MenuController.menu_model_as_json();
        	trace('### s_json='+s_json);
        	MenuController.setMenuJSON(s_json);
        }

		public static function handle_menuitem_update(uuid:String):void {
        	var s_json:String = MenuController.menu_model_as_json();
        	MenuController.setMenuJSON(s_json);
		}
	}
}