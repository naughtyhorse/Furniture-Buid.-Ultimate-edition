package game.factory {
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class KittyButtonFactory {
		
		private static var copy:KittyButtonFactory;
		
		private var buttons:Vector.<KittyButton>;
		
		private var _i:int;
		
		public function KittyButtonFactory() {
			buttons = new Vector.<KittyButton>;
		}
		public static function initCopy():KittyButtonFactory {
			if (!copy) {
				copy = new KittyButtonFactory();
				return copy;
			} else return null;
		}
		public function getButton(_headBmd:BitmapData):KittyButton {
			var _kb:KittyButton = new KittyButton(_headBmd);
			buttons[buttons.length] = _kb;
			return _kb;
		}
		public static function staticGetButton(_headBmd:BitmapData):KittyButton {
			if (copy) return copy.getButton(_headBmd);
			else return null;
		}
		public function step():void {
			for (_i = 0; _i < buttons.length; _i++ )
				if (buttons[_i].step())
					buttons.splice(_i--, 1);
		}
	}
}
