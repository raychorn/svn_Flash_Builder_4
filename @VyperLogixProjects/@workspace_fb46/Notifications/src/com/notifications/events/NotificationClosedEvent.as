package com.notifications.events {
	import com.notifications.Notification;
	
	import flash.events.Event;

	public class NotificationClosedEvent extends Event {
		public function NotificationClosedEvent(type:String, source:Notification, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			this.source = source;
		}
		
        public static const TYPE_NOTIFICATION_CLOSED:String = "notificatonClosed";
        
		public var source:Notification;

        override public function clone():Event {
            return new NotificationClosedEvent(type, this.source);
        }
	}
}