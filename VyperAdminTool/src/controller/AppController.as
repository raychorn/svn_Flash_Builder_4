/*
 * Class: Controller
 * @author Ryan C. Knaggs
 * @since 1.0
 * @version 1.0 - RCK
 * @date 08/14/2009
 * @description: This file in the main entry point to
 * invoke other models and view class objects
 */


package controller
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	
	import libs.utils.JSInterface;
	import libs.vo.GlobalsVO;
	
	import models.Accessibility_Model;
	import models.LoadExternalData;
	import mx.accessibility.*;
	
	import utils.strings.Strings;
	import utils.strings.URLUtils;
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	
	
	public class AppController
	{
		
		/* You will need to have this code here
		 * in order to communicate with different
		 * domains. */
		Security.allowDomain("*");
		Security.allowInsecureDomain("*");
		//ExternalInterface.call("hasScreenReader",Accessibility.active);
		
		
		//hasScreenReader
		// Setup JS interface at application level
		// to send and receive JS calls
		GlobalsVO.setGlobal(GlobalsVO.JSINTERFACE ,new JSInterface());
	
		// BEGIN: Please do not change the code found within this comment block...
		public var callback_signal_start:Function;
		public var callback_signal_initMenuData:Function;
		// END!   Please do not change the code found within this comment block...
	
		private var _g:Object;
		private var _diagnostics:Object;									// Diagnostics
		private var _stage:Stage;
		
		private const APPLICATION_SPEED:String = "applicationFPS";			// Application Speed
		
		
		
		
		/**
		 * Constructor
		 * @param appRoot:Object - Reference of main application
		 */
		 
		public function AppController() {
			_g = GlobalsVO;
		}
		
		
		
		
		
		public function init(overRide:String=''):void {
			
			
			/* Need to determine if this application is
			 * running in the flex development enviornment
			 * or running on a HTTP webserver
			 * The application needs to know where
			 * it exists in the the path and
			 * what the fully qualified domain is
			 * if the domain is null and the
			 * prefix is file://, then we are to assume
			 * that the enviornment is flex */
			var url:String = _g.getGlobal("_APPLICATION").url;
			processURL(url + ((url.indexOf('?') == -1) ? '?' : '&') + overRide);
			
			/* Load all external data first
			 * The callback function will return
			 * a Event.Complete to indicate that all
			 * the data has successfuly loaded
			 * otherwise the screen will attach a ToolTip
			 * next to the mouse
			 */
			 
			var loadExternalData:LoadExternalData = new LoadExternalData();
			loadExternalData.load(overRide,onLoadSuccess);
						
			// Set diagnostics output
			_g.DIAG = false;
			
			// Register reference of the application controller to Globals
			_g.setGlobal(utils.strings.Strings.className(this),this);
			
			// Invoke JS keyboard listener
			setupKeyboardListener();
		}
		
		
		
		
		
		
		
		/**
		 * JS Keyboard listener 
		 * The reason why the JSINTERFACE is a global class
		 * is for other class components to listen
		 * to the same keyboard listener object
		 */
		 
		private var _jsInterface:JSInterface;
		private var _accessibility:Accessibility_Model;
		private var _accessibility_F:Boolean = true;	// Testing setup flashvars
		
		private function setupKeyboardListener():void {
			/* Setup JS interface at application level
			 * JS call back listener for keyboard commands */
			_jsInterface = JSInterface(_g.getGlobal(_g.JSINTERFACE));
			
			// If flashvars accessibility was set to false
			if(!_accessibility_F) return;
			
			// If Accessibility was true then setup the accessibility feature
			if (_jsInterface != null) {
				
				_accessibility = new Accessibility_Model();
				
				// Setup External interface to listen to the JS keyboard
				//ExternalInterface.addCallback(_g.JSKEYBOARD,_jsInterface[_g.JSKEYBOARD]);
				//ExternalInterface.addCallback(_g.FROMJS,_jsInterface[_g.FROMJS]);
				//GlobalsVO.FROMJS
				// Setup a listener to do something when specific keys are selected
				//_jsInterface.addEventListener(GlobalsVO.JSKEYBOARD,onKeyboard);
			}
		}
		
		
		/**
		 * Send selected key command to determine
		 * what the menu should focus and display 
		 * @param key
		 */
		 		
		public function onKeyboard(e:Event):void {
			_accessibility.keySelect(e.currentTarget.currentKey);
		}
		
		
		
		/** Need to determine if this application is
		 * running in the flex development enviornment
		 * or running on a HTTP webserver
		 * The application needs to know where
		 * it exists in the the path and
		 * what the fully qualified domain is
		 * @param Full URL from enviornment
		 */
		 		
		private function processURL(url:String):void {
			var appURL:Object = URLUtils.parse_overrides(url);
			var domain:String = '.';
    		var prefix:String = '/';

    		//trace('### processURL().1 --> appURL.domain='+appURL.domain);
    		//trace('### processURL().2 --> appURL.prefix='+appURL.prefix);

    		domain = ((appURL.domain is String) && (appURL.domain.length > 0)) ? appURL.domain : domain;
    		prefix = ((appURL.prefix is String) && (appURL.prefix.length > 0)) ? appURL.prefix : prefix;
    		
    		//trace('### processURL().3 --> domain='+domain);
    		//trace('### processURL().4 --> prefix='+prefix);
    		
    		/* Store the domain and prefix in _g
    		 * for this application to properly load
    		 * all external data
    		 * @see LoadExternalData */
			_g.setGlobal(_g.APP_URL_DOMAIN,domain);    		
			_g.setGlobal(_g.APP_URL_PREFIX,prefix);    		
		}
		
		
		
		
		
		/**
		 * If all external files have
		 * successfully loaded then
		 * perform a stage clean up
		 * and start the Application
		 */
		 		
		public function onLoadSuccess(e:Event):void {
			// Clear the canvas
			_g.getGlobal(_g.APPLICATION).removeAllChildren();
			//trace("onLoadSuccess: "+e);
			// Start the application
			start();
		}
		



		
		/**
		 * After you have loaded the files
		 * to set up the application,
		 * call the menu controller
		 * to start the process for getting
		 * the data model and assembling the menu
		 */
		 
		public function start():void {
			
			/* Set Application Frames Per Second
			 * for application speed */
			_stage = _g.getGlobal(_g.APPLICATION).stage;
			var appSpeed:int = int(Math.round(_g.getCSSProperty(APPLICATION_SPEED)));
			_stage.frameRate = appSpeed > 0 ?  appSpeed : _g.DEFAULT_FPS;
			
			/* Initialize diagnostics if the DIAG var 
			 * is set to true or the query string diag=true 
			 * to display diagnostics */
			//_g.diagnostics();
			
			
			var menuBar:MenuController;
			menuBar = new MenuController();
			
			// Initialize new header bar
			var headerBar:HeaderController = new HeaderController();
			// BEGIN: Please do not change the code found within this comment block...
			if (this.callback_signal_start is Function) {
				try {
					this.callback_signal_start(menuBar);
				} catch (e:Error) {}
			}
			// END!  Please do not change the code found within this comment block...
			
			// Initialize the menubar
			menuBar.init();
		}
	}
}