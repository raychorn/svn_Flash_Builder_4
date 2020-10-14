package utils.math {
	public class MathUtils {
		public static function randomRange(iMin:uint,iMax:uint):uint {
		    return ((Math.random()*iMax)-(Math.random()*iMin)+1)+(Math.random()*iMin); 
		} 

		public static function randomNumberRange(aMin:Number,aMax:Number):Number {
		    return ((Math.random()*aMax)-(Math.random()*aMin))+(Math.random()*aMin); 
		} 
	}
}