package com.adobe.dashboard.model
{

	public class UserModel
	{
		/**
		 * The user name used to log in (email address) 
		 */
		private var _username:String;

		[Bindable]
		public function get username():String
		{
			return _username;
		}

		public function set username(value:String):void
		{
			_username = value;
		}


		
		/**
		 * The password the user entered.  This should be cleared out of memory when it is not needed. 
		 */
		private var _password:String;

		[Bindable]
		public function get password():String
		{
			return _password;
		}

		public function set password(value:String):void
		{
			_password = value;
		}

		
		/**
		 * Indicates when the user wants to keep the account logged in. 
		 */
		private var _rememberPass:Boolean;

		public function get rememberPass():Boolean
		{
			return _rememberPass;
		}

		public function set rememberPass(value:Boolean):void
		{
			_rememberPass = value;
		}
		
		/**
		 * Constuctor 
		 */
		public function UserModel(userName:String = null, password:String = null)
		{
			_username = userName;
			_password = password;
		}
	}
}