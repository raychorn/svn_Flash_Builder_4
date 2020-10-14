package vyperlogix {
	public class DomainUtils {
		public static function parseDomain(url:String):Object {
			var data:Object = {};
			var parms:Object = {};
			var toks0:Array = url.split('?');
			var toks:Array = toks0[0].split('//');
			var toks1:Array = (toks0.length > 0) ? toks0[1].split('&') : [];
			data.protocol = toks[0];
			var toks2:Array = toks[1].split('/');
			data.domain = data.protocol+'//'+toks2[0];
			data.document = toks2.pop();
			data.url_prefix = data.protocol+'//'+toks2.join('/');
			var parts:Array;
			for (var i:String in toks1) {
				parts = toks1[i].split('=');
				if (parts.length == 2) {
					parms[parts[0]] = parts[1];
				}
			}
			data['args'] = parms;
			return data;
		}
	}
}