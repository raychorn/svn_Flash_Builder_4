package com {
	public class FibonacciGenerator	{
		private var a:uint = 0;
		private var b:uint = 1;

		public function FibonacciGenerator ():void {
			a = 0;
			b = 1;
			trace('(###) FibonacciGenerator init() !!!  a='+this.a+', b='+this.b);
		}
		/*
		def fibonacci():
		a, b = 0, 1
		while 1:
		yield a
		a, b = b, a + b
		*/
		
		public function next():uint {
			var value:uint = this.a;
			var a:uint = this.a;
			this.a = this.b;
			this.b = a + this.b;
			trace('(###) FibonacciGenerator.next() !!!  a='+this.a+', b='+this.b+', value='+value);
			return value;
		}
	}
}