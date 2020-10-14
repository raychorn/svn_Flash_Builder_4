package controls.MediaPresentation.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ChangeNavBar extends Event {
		public function ChangeNavBar(type:String, _displayable_:*, _aspect_:*, _is_:Boolean, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this._is_ = _is_;
			this._aspect_ = _aspect_;
			this._displayable_ = _displayable_;
		}
		
		public var _displayable_:*;
		public var _aspect_:*;
		public var _is_:Boolean;
		
		public static const TYPE_CHANGE_NAVBAR:String = "changeNavBar";
		
		override public function clone():Event {
			return new ChangeNavBar(type,_displayable_,_aspect_,_is_);
		}
	}
}