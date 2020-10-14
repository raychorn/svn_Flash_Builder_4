package controls.google.buttons.events {
	import flash.events.Event;

	public class PlayButtonClickedEvent extends Event {
		public function PlayButtonClickedEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
        public static const TYPE_PLAY_BUTTON_CLICKED:String = "playButtonClicked";
        
        override public function clone():Event {
            return new PlayButtonClickedEvent(type);
        }
	}
}