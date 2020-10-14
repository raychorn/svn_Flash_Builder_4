/*
 * @author Ryan C. Knaggs
 * @date 04/30/2007
 * @description - Slot Listener class.
 * This is imported into the slots class object.
 * @see EventExchange.as
 * It is designed to allow you to setup a listener
 * from your own application.
 */
 
 
 
package eventexchange{

	public class EventListener implements IEventListener {

		private var rc:Object;
		private var chn:Object;
		private var rf:String;
		
		
		
		/**
		* Constructor
		*/
		
		function EventListener() {
		}
		
		
		
		
		/**
		* When you specifiy a new listener in your application,
		* you are registering the calling class object to this
		* method.  The method will return any new updates back
		* to the calling class.
		*
		* @param	rc:Object - Calling class object
		* @param	rf:String - Return function
		* @param	c:Number - Slot Number
		*/
		
		public function init(rc:Object,rf:String,c:Number):void {
			this.rc = rc;
			this.rf = rf;
			this.chn = rc.chn;
			chn.ch[c].addObserver(this);
			
		}
		
		
		
		
		public function register(rc:Object,rf:String,c:Number):void {
			this.rc = rc;
			this.rf = rf;
			this.chn = rc.chn;
			chn.ch[c].addObserver(this);
			
		}
		
		
		
			
		
		/**
		* Update calling class method with updated
		* object data
		* @param	e:Object - Updated slot object information
		*/
		public function update(e:Object):void {
			rc[rf](e);
		}
		
	}
	
}
	