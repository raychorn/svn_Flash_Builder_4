package com {
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextLineMetrics;
	
	import mx.core.UITextFormat;
	import mx.managers.ISystemManager;
	
	public class Misc {
		public static var systemManager:ISystemManager;

		public static function computeTextMetricsForString(str:String):TextLineMetrics {
			var ut:UITextFormat = new UITextFormat(Misc.systemManager, str);
			ut.antiAliasType = AntiAliasType.NORMAL;
			ut.gridFitType = GridFitType.PIXEL;
			var lineMetrics:TextLineMetrics = ut.measureText(str);
			return lineMetrics;
		}
		
		public static function computeTextWidthForString(str:String):Number {
			var m:TextLineMetrics = computeTextMetricsForString(str);
			return m.width + m.leading;
		}

		public static function measure_text_for(container:*,text:String):int {
			var lineMetrics:TextLineMetrics = container.measureText(text);
			return lineMetrics.width;      
		}			
		
		public static function fit_text_into(target:*,aspect:String):void {
			try {
				var toks:Array = target[aspect].split('\n').join(' ').split(' ');
				var tokens:Array = [];
				var word:String;
				var wText:int;
				var phrase:String;
				var phrases:Array = [];
				for (var i:int = 0; i < toks.length; i++) {
					word = toks[i];
					tokens.push(word);
					phrase = tokens.join(' ')
					wText = Misc.measure_text_for(target,phrase);
					if (wText > target.width) {
						phrases.push(phrase);
						tokens = [];
					}
				}
				phrases.push(phrase);
				target[aspect] = phrases.join('\n');
			} catch (err:Error) {}
		}
	}
}