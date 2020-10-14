package com.vyperlogix {
	import flash.net.URLRequestMethod;

	public class AdMobService extends AdHocService {
		private const __url__:String = 'http://r.admob.com/ad_source.php';
		
		public function AdMobService() {
			super();
		}

		/**
		 * Returns the user record from the server. The user record has information about the status of the current sesstion including whether or not the user is logged in. 
		 *  
		 */
		public function admob(pub_id:String):AdMobOperation {
			var operation:AdMobOperation = new AdMobOperation(this.__url__);
			operation.timeout = this.timeout;
			operation.method = URLRequestMethod.POST;
			operation.format = null;
			operation.params = {
				'rt':0,
				'z':Math.round(new Date().getTime() / 1000),
				'y':'banner',
				'u':'Mozilla%2F5.0+%28Windows%3B+U%3B+Windows+NT+6.1%3B+en-US%29+AppleWebKit%2F534.16+%28KHTML%2C+like+Gecko%29+Chrome%2F10.0.648.204+Safari%2F534.16',
				'i':this.ip_address,
				'p':'http%3A%2F%2Fwww.near-by.info',
				'v':'20081105-PHPFSOCK-33fdd8e59a40dd9a',
				's':pub_id,
				'h%5BHTTP_ACCEPT%5D':'application%2Fxml%2Capplication%2Fxhtml%2Bxml%2Ctext%2Fhtml%3Bq%3D0.9%2Ctext%2Fplain%3Bq%3D0.8%2Cimage%2Fpng%2C%2A%2F%2A%3Bq%3D0.5',
				'h%5BHTTP_ACCEPT_CHARSET%5D':'ISO-8859-1%2Cutf-8%3Bq%3D0.7%2C%2A%3Bq%3D0.3',
				'h%5BHTTP_ACCEPT_ENCODING%5D':'gzip%2Cdeflate%2Csdch',
				'h%5BHTTP_ACCEPT_LANGUAGE%5D':'en-US%2Cen%3Bq%3D0.8',
				'h%5BHTTP_AUTHORIZATION%5D':'&h%5BHTTP_HOST%5D=www.near-by.info'
			};
			return operation;
		}
	}
}