package game.factory {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class ExchangeScreenFactory {
		
		public static var copy:ExchangeScreenFactory;
		
		private var exs:Vector.<ExchangeScreen>;
		
		private var _i:int;
		
		public function ExchangeScreenFactory():void {
			exs = new Vector.<ExchangeScreen>;
		}
		public static function initCopy():ExchangeScreenFactory {
			if (!copy) {
				copy = new ExchangeScreenFactory();
				return copy;
			} else return null;
		}
		public static function addExchange(_parent:DisplayObjectContainer, _prevDO:DisplayObject, _nextDO:DisplayObject, _callback:Function):ExchangeScreen {
			if (copy) {
				var _ex:ExchangeScreen = new ExchangeScreen(_parent, _prevDO, _nextDO, _callback);
				copy.exs[copy.exs.length] = _ex;
				return _ex;
			} else return null;
		}
		public function step():void {
			for (_i = 0; _i < exs.length; _i++ )
				if (exs[_i].step())
					exs.splice(_i--, 1);
		}
	}
}
