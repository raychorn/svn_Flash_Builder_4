package events {
	import flash.events.Event;

	public class ClickedTileEvent extends Event {
		public function ClickedTileEvent(type:String, value:*, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			this.value = value;
		}
		
        public static const TYPE_CLICKED_TILE:String = "clickedTile";
        
        public var value:*;

        override public function clone():Event {
            return new ClickedTileEvent(type, this.value);
        }
	}
}