/*
 * @description This interface is designed for the
 * ChannelDispatch class
 * @see ChannelDispatch.as
 * @author Ryan C. Knaggs
 * @date 04/30/2007
 */ 


package eventexchange {
	public interface IEventDispatch {
		function addObserver (obj:IEventListener):void;
		function notifyObserver (e:Object):void;
	}
}
