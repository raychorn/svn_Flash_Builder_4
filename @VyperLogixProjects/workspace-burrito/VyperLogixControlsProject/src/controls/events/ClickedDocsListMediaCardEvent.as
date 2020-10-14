package controls.events {
	import flash.events.Event;

	public class ClickedDocsListMediaCardEvent extends Event {
		public function ClickedDocsListMediaCardEvent(type:String, mediaCard:*, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.mediaCard = mediaCard;
		}
		
		public var mediaCard:*;
		
        public static const TYPE_CLICKED_DOCSLIST_MEDIA_CARD:String = "clickedDocsListMediaCard";

        override public function clone():Event {
            return new ClickedDocsListMediaCardEvent(type,this.mediaCard);
        }
	}
}