package models
{
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	

	
	public class XMLParser
	{
		
		// Content Data
		private var _data:Array = new Array();
		
		// META Data
		private var _metaData:Object = new Object();
		
		// Return Callback
		private var _onReturn:Function;
		
		
		
		/**
		 * Constructor 
		 * @param onReturn - Callback for calling class
		 */		
		
		public function XMLParser(onReturn:Function) {
			this._onReturn = onReturn;
		}
		
		
		/**
		 * Get the data result from the
		 * WebServices 
		 * @param data
		 */
		 		
		public function onData(data:ResultEvent):void {
			onReturn(data.result as ObjectProxy);
		}
		
		
		
		/**
		 * The WebServices object will invoke the
		 * this method upon the returned result
		 */
		 
		private function onReturn(result:ObjectProxy):void {
			
			// Store Meta data and content data
			assembleData(getDataRoot(result));
			
			// Return new Object to calling Model
			_onReturn({meta:this._metaData,data:this._data});
		}
		
		
		
		/**
		 * Set Data Root
		 */
		 
		private function getDataRoot(result:ObjectProxy):ArrayCollection {
			for(var resultObj:Object in result) {
				if(result[resultObj] is ObjectProxy) {
					for(var data:Object in result[resultObj]) {
						if(result[resultObj][data] is ArrayCollection) {
							// Set DataRoot
							return result[resultObj][data];
						}
					}
				}
			}
			
			return null;
		}
		
		
		/**
		 * Get the META data from the XML list
		 * then setup an object to hold the
		 * definations
		 * @param dataRoot:ArrayCollection - Root position for XML data object
		 * @return void
		 */
		 		 
		private function assembleData(dataRoot:ArrayCollection):void {
			for(var i:int=0; i<dataRoot.length;++i) {
				var obj:Object = dataRoot[i];
				for(var o:Object in obj) {
					if(obj[o] is ArrayCollection) {
						// Store into the _data array
						_data.push(obj);
					} else {
						// Store Meta Data
						_metaData[o] = obj[o];
					}
				}
			}
		}
	}
}