package baseflex.utils.strings
{
	import baseflex.utils.hex.StringUtils;;
	
	
	public class URLUtilsOLD
	{
		
		
	
		public static const http_symbol:String = "http";
		public static const https_symbol:String = "https";
		public static const file_symbol:String = "file";
		
		
		
		
		public function URLUtilsOLD() {
		}
		
		
		
		
		
		public static function getFullURL(baseUrl:String,url:String):String {
			var i:int = url.indexOf(URLUtilsOLD.http_symbol+"://");
			if (i > -1) {
				return ((i > -1) ? "" : URLUtilsOLD.protocol(baseUrl)) + "//" + url;
			}
			i = url.indexOf(URLUtilsOLD.https_symbol+"://");
			return ((i > -1) ? "" : URLUtilsOLD.protocol(baseUrl)) + "//" + url;
		}
		
		
		
		
		public static function removePort(domain:String):String {
			try {
				var ar:Array = domain.split(':');
				return ar[0];
			} catch (e:Error) { }
			return domain;
		}
		



		public static function domain_without_port(url:String):String {
			var domain:String = URLUtilsOLD._domain(url);
			return URLUtilsOLD.removePort(domain);
		}




		public static function domain(url:String):String {
			return URLUtilsOLD.domain_without_port(url);
		}




		public static function domain_with_port(url:String):String {
			var domain:String = URLUtilsOLD._domain(url);
			return domain;
		}




		public static function domain_with_port_and_protocol(url:String):String {
			var domain:String = URLUtilsOLD._domain(url);
			var toks:Array = [];
			if (domain.length > 0) {
				toks = url.split(domain);
			}
			return ((toks.length > 0) ? toks[0] : '') + domain;
		}





		public static function url_prefix_sans_domain_name_and_protocol(url:String):String {
			var domain_with_port_and_protocol:String = URLUtilsOLD.domain_with_port_and_protocol(url);
			var toks:Array = url.replace(domain_with_port_and_protocol,'').split('?');
			var toks_slash:Array = toks[0].split('/');
			var toks_dot:Array = toks_slash[toks_slash.length-1].split('.');
			if (toks_dot.length == 2) {
				toks_slash[toks_slash.length-1] = '';
				toks[0] = toks_slash.join('/');
			}
			return ((toks.length > 0) ? toks[0] : '');
		}





		public static function protocol(url:String):String {
			try {
				var ar:Array = url.split("/");
				var i:int = ar[0].indexOf(URLUtilsOLD.http_symbol+":");
				if (i > -1) {
					return ar[0];
				}
				i = ar[0].indexOf(URLUtilsOLD.https_symbol+":");
				if (i > -1) {
					return ar[0];
				}
				i = ar[0].indexOf(URLUtilsOLD.file_symbol+":");
				if (i > -1) {
					return ar[0];
				}
				return '';
			} catch (e:Error) {}
			
			return '';
		}





		public static function isDomainLocal(domain:String):Boolean {
			return (domain.indexOf('127.0.0.1') > -1) || (domain.indexOf('localhost') > -1);
		}
		
		
		
		
		
		public static function parse_overrides(url:String):Object {
    		var domain:String = URLUtilsOLD.domain_with_port_and_protocol(url);
    		var prefix:String = URLUtilsOLD.url_prefix_sans_domain_name_and_protocol(url);

			var toks:Array = url.split('?');
			toks = toks[toks.length-1].split('&');
			
			var options:Object = {'domain':domain,'prefix':prefix}
			var _toks:Array;
			
			for (var i:String in toks) {
				_toks = toks[i].split('=');
				options[_toks[0]] = StringUtils.urlDecode(_toks[_toks.length-1]);
			}
			
			return options;
		}
		
		
		
		
		private static function _domain(url:String):String {
			try {
				var ar:Array = url.split("/");
				var errCount:int = 0;
				var numCount:int = 0;
				if (ar.length > 1) {
					var i:int = ar[0].indexOf(URLUtilsOLD.http_symbol+":");
					numCount++;
					if (i > -1) {
						return ar[2];
					} else {
						errCount++;
					}
					i = ar[0].indexOf(URLUtilsOLD.https_symbol+":");
					numCount++;
					if (i > -1) {
						return ar[2];
					} else {
						errCount++;
					}
					i = ar[0].indexOf(URLUtilsOLD.file_symbol+":");
					numCount++;
					if (i > -1) {
						return '';
					} else {
						errCount++;
					}
					if (errCount == 3) {
						return ar[0];
					}
				}
				return '';
			} catch (e:Error) {}
			return '';
		}

		public static function maskOffCacheBuster(url:String):String {
			if (url is String) {
				var toks:Array = url.split('?');
				toks.pop();
				return toks.join('');
			}
			return url;
		}
	}
	
}