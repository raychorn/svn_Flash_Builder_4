package com.vyperlogix.multitouch
{
	import spark.components.Image;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	
	public class GestureImage extends Image
	{
		private var offsetX:Number;
		private var offsetY:Number;
		
		public function GestureImage()
		{
			if(Multitouch.supportsGestureEvents){
				this.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
				this.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
				this.addEventListener(TransformGestureEvent.GESTURE_ROTATE,
					onGestureRotate);
				this.addEventListener(TransformGestureEvent.GESTURE_ZOOM,
					onGesturePinch);
			}
		}
		
		private function startDragging(event:MouseEvent):void
		{
			setAsCurrentChild();
			offsetX = event.stageX - this.x;
			offsetY = event.stageY - this.y;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, moveImage);
		}
		
		private function stopDragging(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveImage);
		}
		
		private function moveImage(event:MouseEvent):void
		{
			this.x = event.stageX - offsetX;
			this.y = event.stageY - offsetY;
			event.updateAfterEvent();
		}
		
		private function onGesturePinch(pinchEvent:TransformGestureEvent):void{
			setAsCurrentChild();
			var pinchMatrix:Matrix = this.transform.matrix;
			var pinchPoint:Point =
				pinchMatrix.transformPoint(
					new Point((this.width/2), (this.height/2)));
			pinchMatrix.translate(-pinchPoint.x, -pinchPoint.y);
			pinchMatrix.scale(pinchEvent.scaleX, pinchEvent.scaleY);
			pinchMatrix.translate(pinchPoint.x, pinchPoint.y);
			this.transform.matrix = pinchMatrix;
		}
		
		private function onGestureRotate(rotateEvent:TransformGestureEvent):void
		{
			setAsCurrentChild();
			var rotateMatrix:Matrix = this.transform.matrix;
			var rotatePoint:Point =
				rotateMatrix.transformPoint(
					new Point((this.width/2), (this.height/2)));
			rotateMatrix.translate(-rotatePoint.x, -rotatePoint.y);
			rotateMatrix.rotate(rotateEvent.rotation*(Math.PI/180));
			rotateMatrix.translate(rotatePoint.x, rotatePoint.y);
			this.transform.matrix = rotateMatrix ;
			
		}
		
		private function setAsCurrentChild():void{
			this.parent.setChildIndex( this, this.parent.numChildren-1 );
		}
		
	}
}
