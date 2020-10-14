package com.soenkerohde.foursquare.event {
	import flash.events.Event;
	
	import org.iotashan.oauth.OAuthToken;
	
	public class FourSquareOAuthEvent extends Event {
		
		public static const REQUEST_TOKEN:String = "FourSquareOAuthEvent.REQUEST_TOKEN";
		public static const CONSUMER_ERROR:String = "FourSquareOAuthEvent.CONSUMER_ERROR";
		
		public static const ACCESS_TOKEN:String = "FourSquareOAuthEvent.ACCESS_TOKEN";
		
		private var _token:OAuthToken;
		
		public function get token() : OAuthToken {
			return _token;
		}
		
		public function FourSquareOAuthEvent( type : String, token : OAuthToken, bubbles : Boolean = false ) {
			super( type, bubbles );
			_token = token;
		}
		
		override public function clone() : Event {
			return new FourSquareOAuthEvent( type, token, bubbles );
		}
	}
}