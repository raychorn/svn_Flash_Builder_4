package com.adobe.dashboard.event
{
	import flash.events.Event;

	public class NavigationEvent extends Event
	{
		public static const GO_STATE_EVENT:String="goStateEvent";


		/**
		 * the destination state
		 */
		private var _state:String;

		public function get state():String
		{
			return _state;
		}

		/**
		 * if true, on mobile pop instead of push
		 */
		private var _doPop:Boolean;

		public function get doPop():Boolean
		{
			return _doPop;
		}

		/**
		 * constuctor
		 */
		public function NavigationEvent(type:String, state:String, doPop:Boolean=false)
		{
			super(type);

			_state=state;
			_doPop=doPop;
		}

		/**
		 * always override the clone method
		 */
		override public function clone():Event
		{
			return new NavigationEvent(type, state, doPop);
		}
	}
}
