package libs.effects
{
	import flash.events.*;
	import utils.displayObject.LoopIterator;
	
	
	
	
	public class Fade extends EventDispatcher
	{
		
		private var _P:Number=-1;
		private var _asset:*;
	 	private var _value:Number;
	    private var iterator:LoopIterator = new LoopIterator();
	    
		private const MIN:Number = 0;
		private const MAX:Number = 0;
	   
	    
	    
	    
	    public function Fade() {
	    }
	    
	    
	    
	    
	    
		public function init(effect:Object):void {

			this._asset = effect.asset;
	    	this._asset.alpha = effect.from;
	    	this._value = effect.from;
	    	this._P = effect.from;
	    	
	    	iterator.stop();
			iterator.init(effect);
			iterator.addEventListener(Event.CHANGE,onChange);
			iterator.addEventListener(Event.COMPLETE,onComplete);
			iterator.play();
		}
		
		
		
		
		
		
		public function onChange(e:Event):void {
			_value = e.currentTarget.value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		
		
		public function onComplete(e:Event):void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		
		
		public function get value():Number {
			return _value;
		}

	}
	
}