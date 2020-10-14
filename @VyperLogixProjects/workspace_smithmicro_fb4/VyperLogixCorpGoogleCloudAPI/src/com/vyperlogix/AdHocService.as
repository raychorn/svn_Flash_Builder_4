package com.vyperlogix {
	import flash.net.URLRequestMethod;

	public class AdHocService extends GoogleCloudService {
		public function AdHocService() {
			super();
		}

		/**
		 * Returns the user record from the server. The user record has information about the status of the current sesstion including whether or not the user is logged in. 
		 * 
		 */
		public function custom(url:String):AdHocOperation {
			var operation:AdHocOperation = new AdHocOperation(url);
			operation.timeout = this.timeout;
			operation.method = URLRequestMethod.GET;
			operation.format = this.format;
			return operation;
		}
	}
}