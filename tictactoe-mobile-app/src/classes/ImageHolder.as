package classes
{
	public class ImageHolder extends Object
	{
		private var value:String;   // X or O
		private var x:Number;
		private var y:Number;
		private var visible:Boolean;   // true or false
		
		public function set_value(value:String):void {
			this.value = ( (value == 'X') || (value == 'O') ) ? value : null;
		}
		
		public function get_value():String {
			return this.value;
		}
		
		public function set_x(x:Number):void {
			this.x = x;
		}
		
		public function get_x():Number {
			return this.x;
		}
		
		public function set_y(y:Number):void {
			this.y = y;
		}
		
		public function get_y():Number {
			return this.y;
		}
		
		public function set_visible(visible:Boolean):void {
			this.visible = visible;
		}
		
		public function get_visible():Boolean {
			return this.visible;
		}
		
		public function ImageHolder()
		{
			super();
		}
	}
}