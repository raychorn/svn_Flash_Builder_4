package models
{
	import libs.utils.FilterURL;
	import libs.vo.GlobalsVO;
	
	import mx.utils.ObjectUtil;
	
	import utils.strings.*;
	
	
	public class ProcessExternalVars
	{
		private var _overRide_F:Boolean = false;
		private var _domain:String;
		private var _prefix:String;
		
		private const QLASTCHAR:String = "\"";
		private const LOCAL_FILE:String = "./";
		private const ROOT_FILE:String = "/";
		
		/**
		 * Constructor
		 */
		 
		public function ProcessExternalVars() {
		}
		
		
		/**
		 * Parse through the SWFObject
		 * and or the query string to build
		 * a new  
		 * @param overRide
		 * @return 
		 * 
		 */		
		public function parse(overRide:String):Object {
			//trace("############## override: "+overRide);
			if(overRide.length>0) {
				_overRide_F = true;
			} 
			
			this._domain = String(GlobalsVO.getGlobal(GlobalsVO.APP_URL_DOMAIN));
			this._prefix = String(GlobalsVO.getGlobal(GlobalsVO.APP_URL_PREFIX));
			
			this._prefix += (this._prefix.substr(this._prefix.length-1,1) != '/') ? '/' : '';
			
			//trace('### this._prefix=' + this._prefix);
			
			var externalVars:Object = new Object();
			var pCount:int = 0;
			
			/* SWFObject Flashvars not Query String */
			var params:Object = GlobalsVO.getGlobal("_APPLICATION").parameters;
			
			// Determine if there are any values in parameters
			for(var v:Object in params) pCount++;
			
			/* If the simulated override string exists
			 * then use it instead of the querystring from
			 * the HTML page */
			var qs:Object = new Object();
			
			/* Get the querystring and not the SWFObject Flashvars*/
			overRide==null ?
				qs = QueryString.parse(ObjectUtil.toString(GlobalsVO.getGlobal("_APPLICATION").url),QLASTCHAR) :
				qs = QueryString.parse(overRide,QLASTCHAR);
				
			/* There is data in both SWFObject Flash vars
			 * and the query string */			

			if(qs!=null && pCount>0) {
				
				/* Combine both input vars into one object
				 * override the Flashvars with the query
				 * string if the var names are the same */
			
				for(var p:Object in params) {
					for(var q:Object in qs) {
						var name:String = p.toString();
						
						// If doesn't exist
						if(params[name]==null) {
							params[name] = qs[q];
						} else {
							// If exists override with qs
							if(p == q) {
								params[p] = qs[q];
							}
						}
					}
				}
				externalVars = params;
				
				// If no query string but has Flash vars
			} else if(qs==null && pCount > 0) {
				externalVars = params;
				// If query string but no Flash vars
			} else if(qs!=null && pCount == 0) {
				externalVars = qs;
				// If neather query string and Flash vars
			} else {
				
				/* The validateEvars() function wants to use 
				 * this variable as though it is an object 
				 * rather than null however this value could 
				 * still be null if the functions that consume 
				 * this value are able to roll with the flow...  
				 * this fix was easier and accomplished the 
				 * same goal with less code. */
				 
				externalVars = {}; 
				
			}
			
			// Evaluate external vars then return
			return validateEvars(externalVars);
		}
		
	
		
		
		/**
		 * Check the external vars object to
		 * see if any of the key parameters exist
		 * and have valid values.  If so, use the values
		 * instead of the default settings from GlobalsVO 
		 * @param obj
		 * @return 
		 */
		
		public function validateEvars(obj:Object):Object {
			
			if(!_overRide_F) {
				
				// Process version file domain and path
				if(_domain == "" || _domain == null) {
						//trace("1");
						obj[GlobalsVO.GN_VERSION] = GlobalsVO.DEFAULT_VERSION_FILE;
				} else {
						//trace("2");
					
					/* Otherwise application is running on webserver then 
					 * add domain and prefix to default file */
					
					obj[GlobalsVO.GN_VERSION] = Strings.filter(_domain + _prefix + GlobalsVO.DEFAULT_VERSION_FILE,this.LOCAL_FILE,"");
					
					// If separate frame work file then filter url
					obj[GlobalsVO.GN_VERSION] = FilterURL.filter1(obj[GlobalsVO.GN_VERSION]);			
				}
			}
			
			
			//trace("gnversion: "+ obj[GlobalsVO.GN_VERSION]);
			
			
			// If Cachebuster doesn't exists then set to default otherwise set to true
			Strings.strToBool(String(obj[GlobalsVO.CACHEBUSTER])) ? 
				obj[GlobalsVO.CACHEBUSTER] = true :
				obj[GlobalsVO.CACHEBUSTER] = GlobalsVO.DEFAULT_CACHEBUSTER;
			 
			/* Get Properties file if not external
			 * properties file override, 
			 * just a file /globalnav.txt */
			
			if(obj[GlobalsVO.PROPERTIESFILE] == undefined) {
				
				if(_domain == "" || _domain == null) {
					obj[GlobalsVO.PROPERTIESFILE] = GlobalsVO.DEFAULT_PERPERTIES_FILE;
				} else {
					
					/* Otherwise application is running on webserver then 
					 * add domain and prefix to default file */
					
					// Check relative paths
					var fn:String = GlobalsVO.DEFAULT_PERPERTIES_FILE;
					if(fn.indexOf(this.LOCAL_FILE) > -1) {
						/* File locate at application level (Local to the swf)
						 * Remove "./" and add domain and prefix */
						obj[GlobalsVO.PROPERTIESFILE] =  FilterURL.filter1(_domain + _prefix + Strings.removeChar(fn,"./"));
						
					} else if(fn.indexOf(this.ROOT_FILE) > -1) {
						/* File is to be found at root of webserver
						 * Remove "/" from file and add domain only */
						obj[GlobalsVO.PROPERTIESFILE] = FilterURL.filter1(_domain + fn);
					}
					
				}
				
			}
			
			
			/* Get CSS If no external CSS override,
			 * just a file ./css/cssfile.css */
			
			if(obj[GlobalsVO.CSSFILE] == undefined) {
				
				// If development mode no domain
				if(_domain == "" || _domain == null) {
					obj[GlobalsVO.CSSFILE] = GlobalsVO.DEFAULT_CSS_FILE;
				} else {
				
					/* Otherwise application is running on webserver then 
					 * add domain and prefix to default file */
					var aDomain:String = GlobalsVO.getGlobal(GlobalsVO.APP_URL_DOMAIN);
					var aPrefix:String = GlobalsVO.getGlobal(GlobalsVO.APP_URL_PREFIX);
					
					obj[GlobalsVO.CSSFILE] = Strings.filter(aDomain + aPrefix + GlobalsVO.DEFAULT_CSS_FILE,"./","");
					
					// If separate frame work file then filter url
					obj[GlobalsVO.CSSFILE] = FilterURL.filter1(obj[GlobalsVO.CSSFILE]);
				}
				
				/* Otherwise If CSS override exists,
				 * CSS override must be a fully qualified
				 * domain and path in order for the application
				 * to work.*/
			
			}
			
			
			/* Get Data
			 * @see Menu_Model getMenuData for 
			 * loading the data model */
			
			if(obj[GlobalsVO.DATAFILE] == undefined) { 
				if(_domain == "" || _domain == null) {
					obj[GlobalsVO.DATAFILE] = GlobalsVO.DEFAULT_DATA_FILE;
				} else {
					obj[GlobalsVO.DATAFILE] = Strings.filter(GlobalsVO.getGlobal(GlobalsVO.APP_URL_DOMAIN) + 
					GlobalsVO.getGlobal(GlobalsVO.APP_URL_PREFIX) + GlobalsVO.DEFAULT_DATA_FILE,"./","");
				
					// If separate frame work file then filter url
					obj[GlobalsVO.DATAFILE] = FilterURL.filter1(obj[GlobalsVO.DATAFILE]);
				}
			}
			
			// Check to open diagnostics window
			if(obj[GlobalsVO.DIAGNOSTICS] == undefined) {
				obj[GlobalsVO.DIAGNOSTICS] = GlobalsVO.DEFAULT_DIAGNOSTICS;
			}
			
			GlobalsVO.setGlobal(GlobalsVO.EXTERNALVARS,obj);
			
			return obj;
		}
	}
}