package com.models
{
	import com.libs.utils.ErrorMessages;
	import com.libs.vo.GlobalsVO;
	
	import communication.WebServices;
	
	import flash.events.*;
	
	import mx.rpc.events.FaultEvent;
	
	import utils.Generator;
	import utils.ObjectUtils;

	public class Domains_Model extends EventDispatcher
	{
		
		private var _domainsData:Object;

		private var _generator:Generator;
		
		private var _domains:Object = {};

		private var _active:Array = [];
				
		private var _callback:Function;
		
		private var _url:String;

		private const URL:String = "dataURL";
		private const PROPERTIES:String = "props";
		private const EXTERNALVARS:String = "externalVars";
		
		/**
		 * Constructor
		 */
		 
		public function Domains_Model() {
		}
		
		
		public function get domainsData():Object {
			return this._domainsData;	
		}
		
		public function get generator():Generator {
			return this._generator;
		}
		
		public function get domains():Object {
			return this._domains;
		}
		
		public function get active():Object {
			return this._active;
		}
		
		
		/**
		 * Call the WebServices to get the data
		 * for the data grid.  The Model should
		 * only get the data, access the encapsulated WebServices Class
		 */
		
		public function getData(url:String=null,callback:Function=null):String {
			this._callback = callback;
			
			this._url = (url) ? url : GlobalsVO.getGlobal(EXTERNALVARS)[GlobalsVO.DOMAINSFILE];				

			var ws:WebServices = new WebServices();
			ws.getData(this._url,onReturn,GlobalsVO.getGlobal(EXTERNALVARS)[GlobalsVO.CACHEBUSTER]);
			
			return this._url;
		}


		private var initalLoadSuccess:Boolean = true;

		/**
		 * onReturn 
		 * @param o - Returned object from Webservices
		 * If o.success is true the data was
		 * successfully loaded.  False no data.
		 * 
		 */		
		public function onReturn(o:Object):void {
			
			if(!initalLoadSuccess) return;
			
			if(!o.success) {
				GlobalsVO.DATAMODEL_ERROR = "ERROR: 404 - Data model failed to load: "+this._url;
				initalLoadSuccess = false;
				dispatchEvent(new Event(Event.CANCEL));
				return;
			}
				
			if(o.success) {
				var jsp:JSONParser = new JSONParser();
				jsp.parse(o.data,onData);
			}
			
			if (this._callback is Function) {
				this._callback(o);
			}
		}
		

		/**
		 * Returned data from the selected parser 
		 * @param obj - Data object that contains all
		 * information about the menu data model
		 */
		 		
		private function onData(data:Object):void {
			
			if(data == null) return;
			data = data.data;

			/* Get static constant for the field names 
			 * to look for in the data model to separate 
			 * the menu data from the meta data */

			var _this:*=  this;
			 this._domainsData = {};
			 try {
				this._domainsData = data;
				this._generator = new Generator(data,function (generator:Generator,item:*):void {
					if (!(item is Array)) {
						var keys:Array = ObjectUtils.keys(item);
						if (keys.length > 0) {
							if (int(item['IsActive__c']) == 1) {
								var _item:Object = ObjectUtils.cloneIfNecessary(item,true);
								_item['Domain__c'] = String(_item['Domain__c']).toLowerCase();
								_this._domains[_item['Domain__c']] = _item;
								_this._active.push(_item['Domain__c']); 
							}
						}
					}
				});
			 } catch (err:Error) {trace('Domains_Model.onData().ERROR '+err.toString()+'\n'+err.getStackTrace())}

			// Dispatch a load ready event
			dispatchEvent(new Event(Event.COMPLETE));
		}
		


		/**
		 * If Global Navigation Data Model
		 * JSON file is missing
		 */
		private function onFault(e:FaultEvent):void {
			/* Call the Error_View class and
			 * display the error message */
			 new ErrorMessages(GlobalsVO.getGlobal(GlobalsVO.APPLICATION),e.type+": "+this._url);
			 dispatchEvent(new Event(Event.CANCEL));
		}
		
	}
}