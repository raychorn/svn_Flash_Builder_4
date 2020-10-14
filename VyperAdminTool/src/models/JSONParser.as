package models
{
	
	import adobe.serialization.json.JSON;
	import mx.rpc.events.FaultEvent;
	

	public class JSONParser
	{
		
		private var _onStatus:Function;
		
		private const START_TAG:String = "{";
		private const END_TAG:String = "}";
		
		
		/**
		 * Constructor 
		 * @param onReturn - Callback for calling class
		 */		
		
		public function JSONParser() {
		}
		
		
		
		
		/**
		 * Get the data result from WebServices
		 * @param data:ResultEvent - The raw JSON data
		 */
		 		
		public function parse(data:String,onStatus:Function):void {
			this._onStatus = onStatus;
			var data:String = cropJSON(data, START_TAG, END_TAG);
			var jobj:Object = JSON.decode(unescape(data),onFault);
			
			var njobj:Object = getDataRoot(jobj);
			onStatus({info:"success",data:njobj});
		}
		
		
		
		
		public function onFault(e:FaultEvent):void {
			_onStatus({info:"error",data:e});
		}
		
		
		
		
		
		public function cropJSON(result:String, start:String, end:String):String {
			var c:int = 0;
			var s1:String = "";
			while(c<result.length) {
				if(result.charAt(c) == start) {
					s1 = result.substr(c);
					break;
				}
				c++;
			}
			// End
			c = s1.length;
			while(c>0) {
				if(s1.charAt(c) == end) {
					break;
				}
				c--;
			}
			result = s1.substring(0,c+1);
			return result;
		}
		
		
		
		/**
		 * Set Object Root
		 */
		 
		private function getDataRoot(data:Object):Object {
			for(var dataObj:Object in data) {
				if(data[dataObj] is Object) {
					return data[dataObj];
				} 
			}
			
			return null;
		}
	}
}