package game.factory {
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class MathStuff {
		
		public static function getDistance(_x1:Number, _y1:Number, _x2:Number, _y2:Number):Number {
			return Math.sqrt((_x2 - _x1) * (_x2 - _x1) + (_y2 - _y1) * (_y2 - _y1));
		}
		public static function randomFromTo(_from:Number, _to:Number):Number {
			return _from + Math.random() * (_to - _from);
		}
	}
}
