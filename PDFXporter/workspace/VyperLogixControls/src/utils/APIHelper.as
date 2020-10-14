package utils {
	import com.EzHTTPService;
	import com.StringUtils;
	
	import controls.Alert.AlertPopUp;
	
	import mx.core.FlexGlobals;
	import mx.rpc.events.ResultEvent;

	public class APIHelper {
		private static const _get_user_endpoint:String = '/get/user/';
		private static const _login_user_endpoint:String = '/login/user/';
		private static const _register_user_endpoint:String = '/register/user/';
		private static const _activate_endpoint:String = '/activate/';
		private static const _reactivate_endpoint:String = '/reactivate/';
		private static const _chgpassword_endpoint:String = '/chgpassword/';
		private static const _send_email_endpoint:String = '/send/email/';
		private static const _get_form_endpoint:String = '/get/form/';

		private static const _save_data_endpoint:String = '/save/data/';
		private static const _get_data_endpoint:String = '/get/data/';

		private static const _pageparser_endpoint:String = '/pageparser/';
		
		private static const _updater_endpoint:String = '/updater/';

		private static const _get_data1000_endpoint:String = '/get/data/1000/';
		private static const _get_usage_data_endpoint:String = '/get/usage/data/';
		private static const _set_usage_data_endpoint:String = '/set/usage/data/';
		
		public static var ezREST:EzHTTPService = new EzHTTPService(false,false);

		private static function build_endpoint(toks:Array):String {
			try {
				toks.pop();
				toks.push(FlexGlobals.topLevelApplication.appProxy.app_id);
				toks.push('');
			} catch (err:Error) {trace('APIHelper.build_endpoint().1 --> error='+err.toString());}
			return toks.join('/');
		}
		
		public static function get get_user_endpoint():String {
			var toks:Array = APIHelper._get_user_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get login_user_endpoint():String {
			var toks:Array = APIHelper._login_user_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get register_user_endpoint():String {
			var toks:Array = APIHelper._register_user_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get activate_endpoint():String {
			var toks:Array = APIHelper._activate_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get reactivate_endpoint():String {
			var toks:Array = APIHelper._reactivate_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get chgpassword_endpoint():String {
			var toks:Array = APIHelper._chgpassword_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get send_email_endpoint():String {
			var toks:Array = APIHelper._send_email_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get get_form_endpoint():String {
			var toks:Array = APIHelper._get_form_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get pageparser_endpoint():String {
			var toks:Array = APIHelper._pageparser_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get save_data_endpoint():String {
			var toks:Array = APIHelper._save_data_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get get_data_endpoint():String {
			var toks:Array = APIHelper._get_data_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get updater_endpoint():String {
			var toks:Array = APIHelper._updater_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get get_data1000_endpoint():String {
			var toks:Array = APIHelper._get_data1000_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get get_usage_data_endpoint():String {
			var toks:Array = APIHelper._get_usage_data_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function get set_usage_data_endpoint():String {
			var toks:Array = APIHelper._set_usage_data_endpoint.split('/');
			return APIHelper.build_endpoint(toks);
		}
		
		public static function post(url:String,vars:Object,callback:Function):void {
			var userid:String = FlexGlobals.topLevelApplication.appProxy.user.id;
			var session_key:String = FlexGlobals.topLevelApplication.appProxy.user.session_key;
			var _vars:Object = (vars) ? vars : {};
			_vars['userid'] = userid;
			_vars['session_key'] = session_key;
			APIHelper.ezREST.post(FlexGlobals.topLevelApplication.domain+url,_vars, 
				function (event:ResultEvent):void {
					var response:*;
					try {
						if (callback is Function) {
							response = (event.result is String) ? event.result : event.result.getItemAt(0);
							trace('APIHelper.post().1 event='+event.toString());
							callback(event,response);
						}
					} catch (e:Error) {
						var stackTrace:String = e.getStackTrace();
						AlertPopUp.errorNoOkay('APIHelper.post().ERROR\n' + e.message.toString() + '\n' + StringUtils.ellipsis(stackTrace,1024),'ERROR');
					}
				}, ezREST.jsonResultType);
		}
	}
}