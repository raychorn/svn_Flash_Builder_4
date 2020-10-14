/*
 * Class: EffectManager.as
 * @author Ryan C. Knaggs
 * @date 10/08/2009
 * @version 1.1
 * @since 1.0
 * @description: This class is use as a wrapper for the
 * different effects that can be applied
 */


package libs.effects
{
	
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	
	public class EffectManager extends EventDispatcher
	{
		
		
		private var _fadeObj:Object;
		private var _resizeWObj:Object;
		private var _resizeHObj:Object;
		private var _numEffects:int=0;
		
		
		public function EffectManager()	{
		}
		
		
		
		
		public function get numEffects():int {
			return _numEffects;
		}
		
		
		
		/**
		 * Resize Display Object Width
		 * @param obj
		 */
		 		
		public function setWResizeAsset(obj:Object):void {
			// Decorate new width resize effect
			this._resizeWObj = obj;
			this._resizeWObj.effect = new Resize();
			_numEffects++;
		}
		
		
		
		public function runWResizeEffect(callBack:Function=null):void {
			_resizeWObj.callBack = callBack;
			_resizeWObj.effect.init(_resizeWObj);
			_resizeWObj.effect.addEventListener(Event.CHANGE,onWResizeChange);
			_resizeWObj.effect.addEventListener(Event.COMPLETE,onWResizeComplete);
		}
		
      	
      	
      	public function onWResizeChange(e:Event):void {
			_resizeWObj.asset.width = e.currentTarget.value;
		}
		
		
		
		public function onWResizeComplete(e:Event):void {
			_numEffects--;
			_resizeWObj.callBack();
		}
		
		
		
		public function getWResizeValue():Number {
			return _resizeWObj.asset.width;
		}
		
		
		
		/**
		 * Resize Display Object Height
		 * @param obj
		 */	
		 
		public function setHResizeAsset(obj:Object):void {
			// Decorate new vertical resize effect
			this._resizeHObj = obj;
			this._resizeHObj.effect = new Resize();
			_numEffects++;
		}
		
		
		
		public function runHResizeEffect(callBack:Function=null):void {
			_resizeHObj.callBack = callBack;
			_resizeHObj.effect.init(_resizeHObj);
			_resizeHObj.effect.addEventListener(Event.CHANGE,onHResizeChange);
			_resizeHObj.effect.addEventListener(Event.COMPLETE,onHResizeComplete);
		}
		
      	
      	
      	public function onHResizeChange(e:Event):void {
			_resizeHObj.asset.height = e.currentTarget.value;
		}
		
		
		
		public function onHResizeComplete(e:Event):void {
			_numEffects--;
			_resizeHObj.callBack();
		}
		
		
		
		public function getHResizeValue():Number {
			return _resizeHObj.asset.height;
		}
		


		
		/**
		 * Fade Display Object
		 * @param obj
		 */
		 
		public function setFadeAsset(obj:Object):void {
			// Decorate new fade effect
			this._fadeObj = new Object();
			this._fadeObj = obj;
			this._fadeObj.effect = new Fade();
			_numEffects++;
		}
		
		
		
		public function runFadeEffect(callBack:Function=null):void {
			this._fadeObj.callBack = callBack;
			this._fadeObj.effect.init(this._fadeObj);
			this._fadeObj.effect.addEventListener(Event.CHANGE,onFadeChange);
			this._fadeObj.effect.addEventListener(Event.COMPLETE,onFadeComplete);
		}
		
      	
      	
      	public function onFadeChange(e:Event):void {
			this._fadeObj.asset.alpha = this._fadeObj.value = e.currentTarget.value;
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		
		
		
		public function onFadeComplete(e:Event):void {
			_numEffects--;
			this._fadeObj.asset.alpha = this._fadeObj.value = e.currentTarget.value;
			this._fadeObj.callBack();
		}
		
		
		
		public function getFadeValue():Number {
			return _fadeObj.value;
		}
	}
}