﻿package  {	import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;		public class MonthStepper extends Sprite 	{		private var labels:Array = [			"Jan", "Feb", "Mar", "Apr", "May", "Jun",			"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"		];		private var _index:Number = 0;				public function MonthStepper() 		{			super();			addEventListener( Event.ADDED_TO_STAGE, doAdded );		}		protected function doAdded( event:Event ):void		{			up.useHandCursor = false;			up.addEventListener( MouseEvent.CLICK, doUpClick );						down.useHandCursor = false;			down.addEventListener( MouseEvent.CLICK, doDownClick );						field.text = labels[index];		}				protected function doDownClick( event:MouseEvent ):void		{			if( index == 0 )			{				index = labels.length - 1;			} else {				index = index - 1;			}						field.text = labels[index];						dispatchEvent( new StepperEvent( StepperEvent.CHANGE ) );		}				protected function doUpClick( event:MouseEvent ):void		{			if( index == ( labels.length - 1 ) )			{				index = 0;			} else {				index = index + 1;			}						field.text = labels[index];						dispatchEvent( new StepperEvent( StepperEvent.CHANGE ) );					}						public function get index():Number		{			return _index;		}				public function set index( value:Number ):void		{			_index = value;						field.text = labels[index];		}	}}