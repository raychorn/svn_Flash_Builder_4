/* Class: MenuEffectController
 * @author Ryan C. Knaggs
 * @date 10/13/2009
 * @version 1.0
 * @description: The class was designed to contain
 * the different effect behaviors for the created menu(s).
 * When a menu is created, by the CreateMenu_View
 * factory class, the menu will know if it is a category
 * menu, or a sub- menu that should appear on the right or left.
 * The new menu will get an effectType that will be
 * passed to this class, to determine which effect
 * should be used for the parent class method showMenu()
 */



package controller
{
	import flash.display.Sprite;
	
	import libs.effects.EffectManager;
	import libs.vo.GlobalsVO;
	
	import mx.controls.Image;
	
	import mxml.Menu;
	
	
	
	
	public class MenuEffectController
	{
		
		
		private var _menu:Menu;
		private var _effectManager:EffectManager;
		private var _effectMask:*;
		private var _callBack:Function;
		private var _css:Function;
		
		private const P1:String = "menuFadeInSpeed";
		private const P2:String = "menuFadeAlphaStart";
		private const P3:String = "menuFadeAlphaEnd";
		private const P4:String = "menuFadeInStep";
		private const P5:String = "menuResizeWidthSpeed";
		private const P6:String = "menuResizeWidthStep";
		private const P7:String = "menuResizeHeightSpeed";
		private const P8:String = "menuResizeHeightStep";
		private const P9:String = "menuFadeOutSpeed";
		private const P10:String = "menuFadeOutStep";
		
		
		
		public function MenuEffectController(menu:Menu) {
			this._menu = menu;
			this._css = GlobalsVO.getCSSProperty;
		}
		
		
		
		
		/**
		 * Create a new graphic and mask 
		 * @param maskContainer
		 * @param effectContainer
		 * @return 
		 */
		 		
		private function createMask(maskContainer:*,effectContainer:*):Image {
			var square:Sprite = new Sprite();
			square.graphics.beginFill(0x0000FF);
			square.graphics.drawRect(0,0,100,100);
			square.graphics.endFill();
			
			/* Convert the sprite to an image
			 * so it will import into the maskContainer */
			var img:Image = new Image();
			img.source = square;
			maskContainer.addChild(img);
			effectContainer.mask = maskContainer;
			return img;
		}
		
		
		
		public function showMenuEffects(effectType:int,callBack:Function):void {
			this._callBack = callBack;
			
			// Setup new effect manager for show menu
			_effectManager = new EffectManager();
			
      		/* Display the proper menu effect
      		 * based on the type of menu condition
      		 * the condition is based on if the menu
      		 * is a category menu or a sub-menu that
      		 * was display either from the right or left */
      		
      		switch(effectType) {
      			case 0:
      				// Fade Effect
	          		_effectManager.setFadeAsset({asset:_menu.effectContainer,
	          									 speed:int(_css(P1)),
	          									 from:Number(_css(P2)),
	          									 _to:Number(_css(P3)),
	          									 step:Number(_css(P4))});
	          									 
	          		_effectManager.runFadeEffect(endShowEffects);
      			break;
      			
      			case 1:
					// Fade Effect
	          		_effectManager.setFadeAsset({asset:_menu.effectContainer,
	          									 speed:int(_css(P1)),
	          									 from:Number(_css(P2)),
	          									 _to:Number(_css(P3)),
	          									 step:Number(_css(P4))});
          			
          			// Mask the effect container with the flash mask asset
					_effectMask = createMask(_menu.maskContainer,_menu.effectContainer);
	          									 
	          		_effectManager.runFadeEffect(endShowEffects);
	          		
	          		// Resize masking width
	          		_effectManager.setWResizeAsset({asset:_effectMask,
	          										speed:int(_css(P5)),
	          										from:0,
	          										_to:_menu.container.width,
	          										step:Number(_css(P6))});
	          										
	          		_effectManager.runWResizeEffect(endShowEffects);
	          		
	          		// Resize masking height
	          		_effectManager.setHResizeAsset({asset:_effectMask,
									          		speed:int(_css(P7)),
									          		from:0,
									          		_to:_menu.container.height,
									          		step:Number(_css(P8))});
	          		
	          		_effectManager.runHResizeEffect(endShowEffects);
      			break;
      			
      			
      			
      			case 2:
					// Fade Effect
	          		_effectManager.setFadeAsset({asset:_menu.effectContainer,
	          									 speed:int(_css(P1)),
	          									 from:Number(_css(P2)),
	          									 _to:Number(_css(P3)),
	          									 step:Number(_css(P4))});
	          									 
	          		_effectManager.runFadeEffect(endShowEffects);
					
          			// Mask the effect container with the flash mask asset
					_effectMask = createMask(_menu.maskContainer,_menu.effectContainer);

					// Re-Position the mask		          		
	          		_effectMask.x = _menu.container.width;
	          		
	          		
	          		// Resize masking width
	          		_effectManager.setWResizeAsset({asset:_effectMask,
	          										speed:int(_css(P5)),
	          										from:0,
	          										_to:-_menu.container.width,
	          										step:Number(_css(P6))});
	          										
	          		_effectManager.runWResizeEffect(endShowEffects);
	          		
	          		// Resize masking height
	          		_effectManager.setHResizeAsset({asset:_effectMask,
									          		speed:int(_css(P7)),
									          		from:0,
									          		_to:_menu.container.height,
									          		step:Number(_css(P8))});
	          		
	          		_effectManager.runHResizeEffect(endShowEffects);
      			break;
      		}
		}
		
		
		
		
		private function endShowEffects():void {
	   		if(_effectManager.numEffects <= 0) {
	   			_callBack();
	   		}
		}
				
			
			
		
		public function hideMenuEffects(effectType:int, callBack:Function):void {
			this._callBack = callBack;
			
			/* Display the proper menu effect
      		 * based on the type of menu condition
      		 * the condition is based on if the menu
      		 * is a category menu or a sub-menu that
      		 * was display either from the right or left */
      		
      		var effectValueObj:Object = new Object();		// Needed to get the previous effect values
      		
      		switch(effectType) {
      			case 0:
      			
      				try {
						effectValueObj.e1 = _effectManager.getFadeValue();
					} catch(e:Error) {
						_menu.removeMenu();
						return;
					}
					
					// Setup new effect manager for show menu
      				_effectManager = new EffectManager();
      				
					// Fade Effect
	          		_effectManager.setFadeAsset({asset:_menu.effectContainer,
	          									 speed:int(_css(P9)),
	          									 from:effectValueObj.e1,
	          									 _to:Number(_css(P2)),
	          									 step:Number(_css(P10))});
	          									 
	          		_effectManager.runFadeEffect(endHideEffects);
      			break;

      			case 1:
      				try {
						effectValueObj.e1 = _effectManager.getFadeValue();
						effectValueObj.e2 = _effectManager.getWResizeValue();
						effectValueObj.e3 = _effectManager.getHResizeValue();
					} catch(e:Error) {
						_menu.removeMenu();
						return;
					}
					
					// Setup new effect manager for show menu
      				_effectManager = new EffectManager();
					
					// Fade Effect
	          		_effectManager.setFadeAsset({asset:_menu.effectContainer,
	          									 speed:int(_css(P9)),
	          									 from:effectValueObj.e1,
	          									 _to:Number(_css(P2)),
	          									 step:Number(_css(P10))});
	          									 
	          		_effectManager.runFadeEffect(endHideEffects);
	          		
	          		
	          		// Resize masking width
	          		_effectManager.setWResizeAsset({asset:_effectMask,
	          										speed:int(_css(P5)),
	          										from:effectValueObj.e2,
	          										_to:0,
	          										step:Number(_css(P6))});
	          										
	          		_effectManager.runWResizeEffect(endShowEffects);
	          		
	          		// Resize masking height
	          		_effectManager.setHResizeAsset({asset:_effectMask,
									          		speed:int(_css(P7)),
									          		from:effectValueObj.e3,
									          		_to:0,
									          		step:Number(_css(P8))});
	          		
	          		_effectManager.runHResizeEffect(endShowEffects);
      			break;
      			
      			
      			case 2:
      				try {
						effectValueObj.e1 = _effectManager.getFadeValue();
						effectValueObj.e2 = _effectManager.getWResizeValue();
						effectValueObj.e3 = _effectManager.getHResizeValue();
					} catch(e:Error) {
						_menu.removeMenu();
						return;
					}
					
					// Setup new effect manager for show menu
      				_effectManager = new EffectManager();
					
					// Fade Effect
	          		_effectManager.setFadeAsset({asset:_menu.effectContainer,
	          									 speed:int(_css(P9)),
	          									 from:effectValueObj.e1,
	          									 _to:Number(_css(P2)),
	          									 step:Number(_css(P10))});
	          									 
	          		_effectManager.runFadeEffect(endHideEffects);
	          		
	          		// Re-Position the mask		          		
	          		_effectMask.x = _menu.container.width;
	          		
	          		
	          		
	          		
	          		// Resize masking width
	          		_effectManager.setWResizeAsset({asset:_effectMask,
	          										speed:int(_css(P5)),
	          										from:effectValueObj.e2,
	          										_to:0,
	          										step:Number(_css(P6))});
	          										
	          		_effectManager.runWResizeEffect(endShowEffects);
	          		
	          		// Resize masking height
	          		_effectManager.setHResizeAsset({asset:_effectMask,
									          		speed:int(_css(P7)),
									          		from:effectValueObj.e3,
									          		_to:0,
									          		step:Number(_css(P8))});
	          		
	          		_effectManager.runHResizeEffect(endShowEffects);
      			break;
      		}
		}
		
		
		
		
		private function endHideEffects():void {
	   		if(_effectManager.numEffects <= 0) {
	   			_callBack();
	   		}
		}
	}
}