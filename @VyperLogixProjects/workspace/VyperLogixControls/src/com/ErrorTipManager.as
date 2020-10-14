package com
{
    import controls.ErrorPanel;
    import controls.SpeechBubble;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    
    import mx.controls.ToolTip;
    import mx.core.IChildList;
    import mx.core.IInvalidating;
    import mx.core.IToolTip;
    import mx.core.UIComponent;
    import mx.events.MoveEvent;
    import mx.events.ResizeEvent;
    import mx.events.ToolTipEvent;
    import mx.events.ValidationResultEvent;
    import mx.managers.SystemManager;
    import mx.managers.ToolTipManager;
    import mx.styles.IStyleClient;
    import mx.utils.DisplayUtil;
    import mx.validators.Validator;
    
    import spark.components.Button;
    import spark.components.HGroup;
    import spark.core.SpriteVisualElement;

    /**
     * This class makes the error ToolTip shown up all the time instead of 
     * just when the mouse is over the target component.
     * It is designed to work with a Validator control, but you can manually use this class
     * by calling the showErrorTip() and hideErrorTip() functions too.
     * <br>
     * When the showErrorTip(target:Object, error:String) function is called, if the error String is null and
     * the target is a UIComponent then the UIComponent.errorString property is used in the error tip.
     * <br>
     * Here are some more resources on the issue:<br>
     * <li><a href="http://bugs.adobe.com/jira/browse/SDK-11256">Adobe Bug Tracker</a></li>
     * <li><a href="http://aralbalkan.com/1125">Aral Balkan - Better form validation in Flex</a></li>
     * <li><a href="http://blog.flexmonkeypatches.com/2007/09/17/using-the-flex-tooltip-manager-to-create-error-tooltips-and-position-them/">Creating Error Tooltips</a></li>
     * 
     * @author Chris Callendar
     * @date August 5th, 2009
     */
    public class ErrorTipManager
    {
        
        // maps the target components to the error IToolTip components
        private static var errorTips:Dictionary = new Dictionary(); 
        // maps the validators to a boolean indicating whether the toolTipShown even listener has been
        // added to the validator source property.
        private static var validators:Dictionary = new Dictionary();
        // maps the popUps to an Array of validators
        private static var popUps:Dictionary = new Dictionary();
        // maps the parent containers to an Array of validator source components
        private static var containersToTargets:Dictionary = new Dictionary();
        
		private static var siblings:Dictionary = new Dictionary();
		
		public static const ERROR_TIP_ABOVE:String = 'errorTipAbove';
		public static const ERROR_TIP_RIGHT:String = 'errorTipRight';
		public static const ERROR_TIP_LEFT:String = '';
		public static const ERROR_TIP_BELOW:String = 'errorTipBelow';
		
		private static var tip_orientations:Array = [ERROR_TIP_ABOVE,ERROR_TIP_BELOW,ERROR_TIP_LEFT,ERROR_TIP_RIGHT];
		
        /**
         * Adds "invalid" and "valid" event listeners which show and hide the error tooltips.
         */
        public static function registerValidator(validator:Validator,siblings:Array=null):void {
            validator.addEventListener(ValidationResultEvent.VALID, validHandler);
            validator.addEventListener(ValidationResultEvent.INVALID, invalidHandler);
            validators[validator] = false;
			if (siblings is Array) {
				var aSibiling:*;
				for (var i:String in siblings) {
					aSibiling = siblings[i];
					ErrorTipManager.siblings[aSibiling] = siblings;
				}
			}
            
            // Also listen for when the real mouse over error tooltip is shown 
            addValidatorSourceListeners(validator);
        }
        
        /**
         * Removes the "invalid" and "valid" event listeners from the validator.
         * Also removes the error tip.
         */
        public static function unregisterValidator(validator:Validator):void {
            validator.removeEventListener(ValidationResultEvent.VALID, validHandler);
            validator.removeEventListener(ValidationResultEvent.INVALID, invalidHandler);
            // make sure our error tooltip is hidden
            removeErrorTip(validator.source);
            // stop listening for events on the validator's source
            removeValidatorSourceListeners(validator);
        }
        
        /**
         * Registers the validator (see registerValidator), and adds MOVE and RESIZE listeners
         * on the popUp component to keep the error tip positioned properly.
         * It can also hide all existing error tips which is a good idea when showing a popUp
         * because the error tips will appear on top of the popUp window.
         * @param validator the validator to register
         * @param popUp the popUp component which will have move and resize listeners added to
         * @param hideExistingErrorTips if true then all existing error tips will be hidden
         */
        public static function registerValidatorOnPopUp(validator:Validator, popUp:UIComponent, 
                                hideExistingErrorTips:Boolean = false):void {
            // hide all existing error tips to prevent them from being on top of the popUp
            if (hideExistingErrorTips) {
                hideAllErrorTips();
            }
            registerValidator(validator);
            if (popUps[popUp] == null) {
                popUps[popUp] = [];
                // add move/resize listeners on the popUp to keep the error tip positioned properly
                popUp.addEventListener(MoveEvent.MOVE, targetMoved);
                popUp.addEventListener(ResizeEvent.RESIZE, targetMoved);
            }
            var validators:Array = (popUps[popUp] as Array);
            if (validators.indexOf(validator) == -1) { 
                validators.push(validator);
            }
        }
        
        /**
         * Unregisters all the validators that are associated with the given popup.
         * Also removes the MOVE and RESIZE listeners on the popUp.
         * It can also re-validate all existing validators which will show the error tips if necessary. 
         * @param popUp the popUp component which will have move and resize listeners added to
         * @param validateExistingErrorTips if true then all other validators will be validated
         */
        public static function unregisterPopUpValidators(popUp:UIComponent, validateExistingErrorTips:Boolean = false):void {
            if (popUps[popUp] != null) {
                var validators:Array = (popUps[popUp] as Array);
                for each (var validator:Validator in validators) {
                    unregisterValidator(validator);
                }
                delete popUps[popUp];
                // remove the move/resize listeners on the popUp
                popUp.removeEventListener(MoveEvent.MOVE, targetMoved);
                popUp.removeEventListener(ResizeEvent.RESIZE, targetMoved);
            }
            // show any error tips that were showing before the popUp was shown
            if (validateExistingErrorTips) {
                validateAll();
            }
        }
        
        /**
         * Adds the ToolTipEvent.TOOL_TIP_SHOW event listener on the validator's source
         * only if it hasn't already been added.
         */
        private static function addValidatorSourceListeners(validator:Validator):void {
            // make sure the listeners have been added
            if (validator) {
                var alreadyAdded:Boolean = validators[validator];
                if (!alreadyAdded && (validator.source is IEventDispatcher)) {
                    var ed:IEventDispatcher = (validator.source as IEventDispatcher);
                    // need to listener for when the real tooltip gets shown 
                    // we'll hide it if is an error tooltip since we are already showing it 
                    ed.addEventListener(ToolTipEvent.TOOL_TIP_SHOWN, toolTipShown);
                    // also need to listen for move and resize events to keep the error tip positioned correctly
                    ed.addEventListener(MoveEvent.MOVE, targetMoved);
                    ed.addEventListener(ResizeEvent.RESIZE, targetMoved);
                    validators[validator] = true;
                    
                    // listen for scroll events on the parent containers
                    if (validator.source is DisplayObject) {
                        var obj:DisplayObject = (validator.source as DisplayObject);
                        var parent:DisplayObjectContainer = obj.parent;
                        while (parent) {
                            if (parent) {
                                //parent.addEventListener(ScrollEvent.SCROLL, parentContainerScrolled);
                                if (!(containersToTargets[parent] is Array)) {
                                    containersToTargets[parent] = [];
                                }
                                var array:Array = (containersToTargets[parent] as Array);
                                if (array.indexOf(obj) == -1) {
                                    array.push(obj);
                                }
                            }
                            parent = parent.parent;
                        }
                    }
                }
            }
        }
        
        /**
         * Removes the event listeners that were added to the validator's source.
         */
        private static function removeValidatorSourceListeners(validator:Validator):void {
            if (validator && (validators[validator] == true)) {
                if (validator.source is IEventDispatcher) {
                    var ed:IEventDispatcher = (validator.source as IEventDispatcher);
                    ed.removeEventListener(ToolTipEvent.TOOL_TIP_SHOWN, toolTipShown);
                    ed.removeEventListener(MoveEvent.MOVE, targetMoved);
                    ed.removeEventListener(ResizeEvent.RESIZE, targetMoved);
                    
                    if (validator.source is DisplayObject) {
                        var obj:DisplayObject = (validator.source as DisplayObject);
                        var parent:DisplayObjectContainer = obj.parent;
                        while (parent) {
                            if (parent) {
                                //parent.removeEventListener(ScrollEvent.SCROLL, parentContainerScrolled);
                                if (containersToTargets[parent] is Array) {
                                    var array:Array = (containersToTargets[parent] as Array);
                                    var index:int = array.indexOf(obj);
                                    if (index != -1) {
                                        array.splice(index, 1);
                                        containersToTargets[parent] = array;
                                    }
                                }
                            }
                            parent = parent.parent;
                        }
                    }
                }
                delete validators[validator];
            }
        }
        
        /**
         * Called when the validator fires the valid event.
         * Hides the error tooltip if it is visible.
         */
        public static function validHandler(event:ValidationResultEvent):void {
            // the target component is valid, so hide the error tooltip
            var validator:Validator = Validator(event.target); 
            hideErrorTip(validator.source);
            // ensure that the source listeners were added 
            addValidatorSourceListeners(validator);
        }

        /**
         * Called when the validator fires an invalid event.
         * Shows the error tooltip with the ValidatorResultEvent.message as the error String.
         */
        public static function invalidHandler(event:ValidationResultEvent):void {
            // the target component is invalid, so show the error tooltip 
            var validator:Validator = Validator(event.target); 
            showErrorTip(validator.source, event.message);
            // ensure that the source listeners were added 
            addValidatorSourceListeners(validator);
        }
        
//        private static function parentContainerScrolled(event:ScrollEvent):void {
//            var parent:DisplayObjectContainer = (event.target as DisplayObjectContainer);
//            if (parent && (containersToTargets[parent] is Array)) {
//                var targets:Array = (containersToTargets[parent] as Array);
//                if (targets && (targets.length > 0)) {
//                    for each (var target:DisplayObject in targets) {
//                        // make sure the source target is actually visible (not scrolled out of the view)
//                        var pt:Point = target.localToGlobal(new Point());
//                        pt = parent.globalToLocal(pt);
//                        if ((pt.x < 0) || (pt.y < 0) || 
//                            ((pt.x + target.width) > parent.width) || 
//                            ((pt.y + target.height) > parent.height)) {
//                            // the source component isn't fully visible, so hide the error tip 
//                            hideErrorTip(target);
//                        } else {
//                            // re-position the error tip, also will make it visible if it was hidden
//                            updateErrorTipPosition(target, true);
//                        }
//                    }
//                }
//            }
//        }
        
        /**
         * When the target component moves or is resized we need to keep the 
         * error tip in the correct position.
         */
        private static function targetMoved(event:Event):void {
            var target:DisplayObject = (event.target as DisplayObject);
            // check if the target is actually a popUp, in which case we get the real
            // target from the validator source
            if (popUps[target] != null) {
                var validators:Array = (popUps[target] as Array);
                for each (var validator:Validator in validators) { 
                    var source:DisplayObject = (validator.source as DisplayObject);
                    handleTargetMoved(source);
                }
            } else {
                handleTargetMoved(target);
            }
        }
        
        private static function handleTargetMoved(target:DisplayObject):void {
            if (target is UIComponent) {
                // need to wait for move/resize to finish
                UIComponent(target).callLater(updateErrorTipPosition, [ target ]);
            } else {
                updateErrorTipPosition(target);
            }
        }
        
        /**
         * Moves the error tip for the given target.
         * It can also make it visible if the error tip exists but is hidden. 
         */
        public static function updateErrorTipPosition(target:Object, makeVisible:Boolean = false):void {
            var errorTip:IToolTip = getErrorTip(target);
            if (errorTip) {
                if (makeVisible && !errorTip.visible) {
                    errorTip.visible = true;
                }
                positionErrorTip(errorTip, target as DisplayObject);
            }
        }
		
		public static function get count_errorTips():int {
			return ObjectUtils.keys(errorTips).length;
		}
		
		public static function refresh_button_target_state(target:*):void {
			var i:String;
			var aDisplayObject:DisplayObject;
			var _children:Array = ErrorTipManager.siblings[target];
			var children:Array = [];
			var btn_targets:Array = [];
			var aBtn_target:DisplayObject;
			try {
				for (i in _children) {
					aDisplayObject = _children[i];
					try {aBtn_target = aDisplayObject['parentDocument']['btn_target'];} 
					catch (err:Error) {
						aBtn_target=null;
					}
					if ( (aBtn_target is Button) && (children.indexOf(aDisplayObject) == -1) ) {
						if (btn_targets.indexOf(aBtn_target) == -1) {
							btn_targets.push(aBtn_target);
						}
						children.push(aDisplayObject);
					}
				}
			} catch (err:Error) {trace(DebuggerUtils.getFunctionName(new Error())+'.ERROR.1 --> aDisplayObject.id='+aDisplayObject['id']+', '+err.getStackTrace());}
			//trace(DebuggerUtils.getFunctionName(new Error())+'.1 --> children.length='+children.length);
			if (children.length > 0) {
				var aBool:Boolean;
				var is_validated:Boolean = false;
				for (i in children) {
					aDisplayObject = children[i];
					try {
						aBool = aDisplayObject['parentDocument']['is_validated'];
					} catch (err:Error) {aBool = false;}
					//trace(DebuggerUtils.getFunctionName(new Error())+'.2 --> aDisplayObject='+aDisplayObject.toString()+', aBool='+aBool);
					if (aBool is Boolean) {
						is_validated = aBool;
						if (!aBool) {
							//trace(DebuggerUtils.getFunctionName(new Error())+'.3 --> aDisplayObject='+aDisplayObject.toString()+', aBool='+aBool);
							break; // bail on the first false - any false make the whole thing false !
						}
					}
				}
				//trace(DebuggerUtils.getFunctionName(new Error())+'.4 --> is_validated='+is_validated);
				for (i in btn_targets) {
					aBtn_target = btn_targets[i];
					aBtn_target['enabled'] = is_validated;
					//trace(DebuggerUtils.getFunctionName(new Error())+'.5 --> aBtn_target='+aBtn_target.toString());
				}
			}
//			var _keys_:Array = ObjectUtils.keys(errorTips);
//			trace('_keys_.length='+_keys_.length+', '+DebuggerUtils.explainThis(_keys_));
//			if (_keys_.length > 1) {
//				var ii:int = -1;
//			}
		}
        
        /**
         * This gets called when the mouse hovers over the target component 
         * and a tooltip is shown - either a normal tooltip or an error tooltip.
         * If the tooltip is an error tooltip and our error tooltip is already showing
         * then we hide this new tooltip immediately.
         */
        private static function toolTipShown(event:ToolTipEvent):void {
            // hide our error tip until this tooltip is hidden
            var style:Object = ToolTip(event.toolTip).styleName;
			//trace(DebuggerUtils.getFunctionName(new Error())+'.1 --> event.currentTarget='+event.currentTarget.id+', event.toolTip="'+event.toolTip+'"');
            if ((style == "errorTip") && (getErrorTip(event.target) != null)) {
                // hide this tooltip, ours is already displaying (or is about to display)
                event.toolTip.visible = false;
                event.toolTip.width = 0;
                event.toolTip.height = 0;
				//trace(DebuggerUtils.getFunctionName(new Error())+'.2 --> event.currentTarget='+event.currentTarget.id+', event.toolTip="'+event.toolTip+'"');
                event.currentTarget.dispatchEvent(new ToolTipEvent(ToolTipEvent.TOOL_TIP_HIDE, false, false, event.toolTip)); 
            }
        }
                
        /**
         * Gets the cached IToolTip object for the given target.
         */
        public static function getErrorTip(target:Object):IToolTip {
            return (target ? errorTips[target] as IToolTip : null);
        }
        
        /**
         * Determines if the error tooltip exists and if it is visible.
         */
        public static function isErrorTipVisible(target:Object):Boolean {
            var errorTip:IToolTip = getErrorTip(target);
            return (errorTip && errorTip.visible);
        }

		private static function target_alternate_error_panel(target:*,errorString:String):Boolean {
			var is_using_alternate_error:Boolean = false;
//			try {
//				var errorPanel:ErrorPanel = target.parentDocument['errorPanel'] as ErrorPanel;
//				if (errorPanel) {
//					errorPanel.text = errorString;
//					errorPanel.visible = ( (errorString is String) && (errorString.length > 0) );
//					errorPanel.title = 'WARNING...';
//					errorPanel.width = target.parentDocument.width;
//					errorPanel.height = target.parentDocument.height;
//					is_using_alternate_error = true;
//				}
//			} catch (err:Error) {}
			return is_using_alternate_error;
		}
		
        /**
         * Creates the error IToolTip object if one doesn't already exist for the given target.
         * If the error tooltip already exists then the error string is updated on the existing tooltip.
         * The tooltip will not be shown if the error (or errorString) is blank. 
         * @param target the target component (usually a UIComponent)
         * @param error the optional error String, if null and the target is a UIComponent then 
         *  the target.errorString property is used.
         */
        public static function createErrorTip(target:Object, error:String = null):IToolTip {
            var errorTip:IToolTip = null;
            var position:Point;
			trace(DebuggerUtils.getFunctionName(new Error())+'.1 --> target='+target.id+', error="'+error+'"');
            if (target) {
                // use the errorString property on the target
                if ((error == null) && (target is UIComponent)) {
                    error = (target as UIComponent).errorString;
                }
//				try {
//					if (target.parentDocument['errorTipContainer_sprite']) {
//						var sprite:SpriteVisualElement = target.parentDocument['errorTipContainer_sprite'] as SpriteVisualElement;
//						SpeechBubble.drawSpeechBubble(sprite, new Rectangle(0,0,100,50), 10, new Point(100, 50));
//						var ii:int = -1;
//					}
//				} catch (err:Error) {}
                errorTip = getErrorTip(target);
                if (!errorTip) {
                    if ((error != null) && (error.length > 0)) {
                        position = getErrorTipPosition(target as DisplayObject);
						var orientation:String = ERROR_TIP_BELOW; //(((count_errorTips % 2) || (siblings.length == 2)) ? ERROR_TIP_ABOVE : ERROR_TIP_BELOW);
                        errorTip = ToolTipManager.createToolTip(error, position.x, position.y,orientation);
						trace(DebuggerUtils.getFunctionName(new Error())+'.1 --> orientation='+orientation);
                        errorTips[target] = errorTip;
						
						sizeErrorTip(errorTip);
                        // update the position (handles the tooltip going offscreen
                        positionErrorTip(errorTip, target as DisplayObject);

                        // set the styles to match the real error tooltip 
                        var tt:ToolTip = ToolTip(errorTip);
                        tt.styleName = "errorTip";
                    } 
                   } else if ((error != null) && (error != errorTip.text)) {
                       // update the error tooltip text
                       errorTip.text = error;
                       // update the position too
                       //position = getErrorTipPosition(target as DisplayObject);
                    //errorTip.move(position.x, position.y);
                    positionErrorTip(errorTip, target as DisplayObject);
                   }
            }
            return errorTip;
        }
        
        /**
         * Gets the position for the tooltip in global coordinates.
         */
        private static function getErrorTipPosition(target:DisplayObject):Point {
            // position the error tip to be in the exact same position as the real error tooltip
            var pt:Point = new Point();
            if (target) {
                // need to get the position of the target in global coordinates 
                var global:Point = target.localToGlobal(new Point(0, 0));
                // position on the right side of the target
                pt.x = global.x + target.width + 4;
                pt.y = global.y - 1;
            } 
            return pt;
        }
        
        /**
         * Gets the position for the error tip. 
         * Copied from ToolTipManagerImpl.positionTip()
         */
        private static function positionErrorTip(errorTip:IToolTip, target:DisplayObject, bringInFront:Boolean = true):void {
            if (!errorTip || !target) {
                return;
            }
            var x:Number;
            var y:Number;
    
            var screenWidth:Number = errorTip.screen.width;
            var screenHeight:Number = errorTip.screen.height;
              var upperLeft:Point = new Point(0, 0);
            upperLeft = target.localToGlobal(upperLeft);
            upperLeft = errorTip.root.globalToLocal(upperLeft);
            var targetGlobalBounds:Rectangle = new Rectangle(upperLeft.x, upperLeft.y, target.width, target.height);
            x = targetGlobalBounds.right + 4;
            y = targetGlobalBounds.top - 1;
            var above:Boolean = false;
    
            // If there's no room to the right of the control, put it above or below, 
            // with the left edge of the error tip aligned with the left edge of the target.
            if (x + errorTip.width > screenWidth) {
                var newWidth:Number = NaN;
                var oldWidth:Number = NaN;
                x = targetGlobalBounds.left - 2;

                // If the error tip would be too wide for the stage, reduce the maximum width to fit onstage. 
                // Note that we have to reassign the text in order to get the tip to relayout after changing 
                // the border style and maxWidth.
                if (x + errorTip.width + 4 > screenWidth) {
                    newWidth = screenWidth - x - 4;
                    oldWidth = errorTip.maxWidth;
                    setMaxWidth(errorTip, newWidth);
                    if (errorTip is IStyleClient) {
                        IStyleClient(errorTip).setStyle("borderStyle", "errorTipAbove");
                    }
                    errorTip["text"] = errorTip["text"];
                    setMaxWidth(errorTip, oldWidth);
                } else {
                    // Even if the error tip will fit onstage, we still need to change the border style 
                    // and get the error tip to relayout.
                    if (errorTip is IStyleClient) {
                        IStyleClient(errorTip).setStyle("borderStyle", "errorTipAbove");
                    }
                    errorTip["text"] = errorTip["text"];
                }

                if (errorTip.height + 2 < targetGlobalBounds.top) {
                    // There's room to put it above the control.
                    above = true; //(count_errorTips % 2) ? true : false;    // wait for the errorTip to be sized before setting y
					trace(DebuggerUtils.getFunctionName(new Error())+'.1 --> above='+above);
                } else {
                    // No room above, put it below the control.
                    y = targetGlobalBounds.bottom + 2;
                    setMaxWidth(errorTip, newWidth);
                    if (errorTip is IStyleClient) {
                        IStyleClient(errorTip).setStyle("borderStyle", "errorTipBelow");
                    }
                    errorTip["text"] = errorTip["text"];
                    setMaxWidth(errorTip, oldWidth);
                }
            } else {
                if (errorTip is IStyleClient) {
                    IStyleClient(errorTip).clearStyle("borderStyle");
                }
            }

            // Since the border style of the error tip may have changed, we have to force a remeasurement and change 
            // its size. This is because objects in the toolTips layer don't undergo normal measurement and layout.
            sizeErrorTip(errorTip);

            // need to do this after the error tip has been sized since the height might have changed
            if (above) {
                y = targetGlobalBounds.top - (errorTip.height + 2);
            } else {
				y = targetGlobalBounds.top + (errorTip.height + 2);
			}

            errorTip.move(x, y);
            
            // move this error tip on top of other error tips
            if (bringInFront) {
                bringToFront(errorTip);
            }
			
        }
        
        private static function setMaxWidth(errorTip:IToolTip, width:Number):void {
            if (!isNaN(width) && (errorTip is UIComponent)) {
                (errorTip as UIComponent).maxWidth = width;
            }
        }
        
        /**
         * Moves the given error tip in front of any other error tips.
         */
        public static function bringToFront(errorTip:IToolTip):void {
            var parent:IChildList = (errorTip.parent as IChildList);
            if (parent is SystemManager) {
                parent = (parent as SystemManager).rawChildren;
            }
            var index:int = parent.getChildIndex(errorTip as DisplayObject);
            var children:int = parent.numChildren;
            if (index < (children - 1)) {
                parent.setChildIndex(errorTip as DisplayObject, children - 1);
            }
        }
        
        /**
         * Copied from ToolTipManagerImpl.sizeTip()
         * Objects added to the SystemManager's ToolTip layer don't get automatically measured or sized, 
         * so ToolTipManager has to measure it and set its size.
         */
        private static function sizeErrorTip(errorTip:IToolTip):void {
            // Force measure() to be called on the tooltip.  Otherwise, its measured size will be 0.
            if (errorTip is IInvalidating) {
                IInvalidating(errorTip).validateNow();
            }
            errorTip.setActualSize(errorTip.getExplicitOrMeasuredWidth(),
                                   errorTip.getExplicitOrMeasuredHeight());
        }
        
		private static function clear_all_tips_other_than_this(target:*):void {
			for (var aTarget:* in errorTips) {
				if (aTarget != target) {
					hideErrorTip(aTarget,true);
				}
			}
		}
		
        /**
         * Creates the error tooltip if it doesn't already exist, and makes it visible.
         */
        public static function showErrorTip(target:Object, error:String = null):void {
			var is_using_alternate:Boolean = target_alternate_error_panel(target,error);;
			if (!is_using_alternate) {
				var errorTip:IToolTip = createErrorTip(target, error);
				if (errorTip) {
					errorTip.visible = true;
					clear_all_tips_other_than_this(target);
				}
			}
        }
        
        /**
         * Hides the existing error tooltip for the target if one exists.
         */ 
        public static function hideErrorTip(target:Object, clearErrorString:Boolean = false):void {
            var errorTip:IToolTip = getErrorTip(target);
            if (errorTip) {
                errorTip.visible = false;
				target_alternate_error_panel(target,'');
			}
            // clear the errorString property to remove the red border around the target control
            if (clearErrorString && target && target.hasOwnProperty("errorString")) {
                target.errorString = "";
            }
        }
        
        /**
         * Hides the error tooltip for the target AND removes it from the
         * ToolTipManager (by calling ToolTipManager.destroyToolTip).
         */
        public static function removeErrorTip(target:Object):void {
            var errorTip:IToolTip = getErrorTip(target);
            if (errorTip) {
                errorTip.visible = false;
				target_alternate_error_panel(target,'');
                delete errorTips[target];
            }
        } 
        
        /**
         * Hides all the error tips.
         */
        public static function hideAllErrorTips():void {
            for (var target:Object in errorTips) {
                hideErrorTip(target, true);
            }
        }
        
        /**
         * Shows all the error tips - doesn't check to see if an error string is set!
         */
        public static function showAllErrorTips():void {
            for (var target:Object in errorTips) {
                showErrorTip(target);
            }
        }
        
        /**
         * Calls validate() on all the validators.
         */
        public static function validateAll():void {
            // need to validator to figure out which error tips should be shown
            for (var validator:Object in validators) {
                validator.validate();
            }
        }
        
    }
}