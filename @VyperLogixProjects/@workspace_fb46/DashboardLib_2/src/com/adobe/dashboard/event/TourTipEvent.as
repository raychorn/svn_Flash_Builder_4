package com.adobe.dashboard.event
{
	import flash.events.Event;

	public class TourTipEvent extends Event
	{
		public static const INIT_VIEW_TOUR_TIPS:String="initViewTourTips";

		public static const SHOW_TOUR_TIP:String="showTourTip";

		public static const HIDE_TOUR_TIP:String="hideTourTip";

		public static const HIDE_ALL_TOUR_TIPS:String="hideAllTourTips";

		private var _tourTipType:String;

		public function get tourTipType():String
		{
			return _tourTipType;
		}

		/**
		 * constructor
		 */
		public function TourTipEvent(type:String, tourTipType:String="")
		{
			super(type);

			_tourTipType=tourTipType;
		}

		/**
		 * always override the clone method
		 */
		override public function clone():Event
		{
			return new TourTipEvent(type, _tourTipType);
		}


	}
}
