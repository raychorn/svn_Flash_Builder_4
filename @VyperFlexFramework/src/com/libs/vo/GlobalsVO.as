package com.libs.vo {
	import flash.display.Sprite;
	
	public class GlobalsVO 	{
		
		// Main object container for all dynamic references
		protected static var _global:Object;
		
		// External Files
		public static const VER_FILE:String = "./version.txt";
		public static const PROP_FILE:String = "/properties.txt";
		public static const SWF_FILE:String = "./images/assets.swf";
		public static const CSS_FILE:String = "./css/css.txt";
		public static const DATA_FILE:String = "./datamodel.txt";


		// Application State
		public static var ISDev:Boolean = false;		
		public static var ISLocal:Boolean = false;		
		public static var ISLoggedOut:Boolean = true;
		
		
		// Version
		public static const VERSION:String = "2.0.001";
		
		/**
		 * Test environment 
		 * @return 
		 */
		 		
		public static function testEnv():String {
			// Logout State
			if(ISLoggedOut) {
				return "http://127.0.0.1/?originServer=http://127.0.0.1&img=http://127.0.0.1/gnlogout/images/&CITY=Huntington%20Beach&STATE=CA&ZIPCODE=92647&gnversioncookie=2009NOV25&cartStatus=1&gLinksDisplay=1&zipDisplay=1&logoDisplay=1&lobDisplay=1&searchDisplay=1&loggedInURL=/b2c/myaccount/signin.jsp&gnversion=http://127.0.0.1/gnlogout/gnversion.txt&CITY=Huntington%20Beach&STATE=CA&ZIPCODE=92647&p=http://127.0.0.1/flextestdata/globalnav.txt&css=http://127.0.0.1/gnlogout/css/globalnav-flex.css&diag=false&gn_category=1&d=http://127.0.0.1/flextestdata/logoutdata/LoggedOutState_Header-compressed-json.txt";
			} 
			
			// Login State
			return "?userName=RyanKnaggsTheCoolUsername&img=http://127.0.0.1/gnlogin/images/&CITY=Huntington%20Beach&STATE=CA&ZIPCODE=92647&gnversioncookie=2009NOV25&cartStatus=1&gLinksDisplay=1&zipDisplay=1&logoDisplay=1&lobDisplay=1&searchDisplay=1&loggedInURL=/b2c/myaccount/signin.jsp&gnversion=null&CITY=Huntington%20Beach&STATE=CA&ZIPCODE=92647&p=http://127.0.0.1/flextestdata/globalnavprop.txt&css=http://127.0.0.1/gnlogin/css/globalnav-flex.css&diag=false&gn_category=1&d=http://127.0.0.1/flextestdata/logindata/LoggedInState_Header-compressed-json.txt";
		}
		
		/**
		 * Constructor 
		 */
		 		
		public function GlobalsVO() {
		}
		
		/**
		 * @param name - String value of any datatype to store
		 * @param value - Any data type to store into the class var _global
		 */
		 
		public static function setGlobal(name:String,value:*):* {
			try {
				_global[name] = value;
			} catch(e:Error) {
				_global = {};
				_global[name] = value;
			}
			
			return _global[name];
		}
		
		
		/**
		 * @param name - String value to access the 
		 * class var _global to return the datatype reference
		 * 
		 * @return - Any datatype that is stored into the classvar _global
		 * If object name doesn't exist then return null, 
		 * otherwise return the datatype from the class var _global
		 */
		 
		public static function getGlobal(name:String):* {
			try {
				return _global[name];
			} catch(e:Error) {
				return null;
			}	
		}
	}
}