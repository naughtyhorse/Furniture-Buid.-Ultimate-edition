package game.managing {
	import game.managing.struct.Shake;
	import game.managing.struct.ShakeAmplitude;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class Shaker {
		
		private static var copy:Shaker;
		
		private var shakes:Vector.<Shake>;
		
		private var _i:int;
		
		public function Shaker():void {
			shakes = new Vector.<Shake>;
		}
		public static function init():Shaker {
			copy = new Shaker();
			return copy;
		}
		public function addShake(_object, _amplitude:Number, _time:Number):Shake {
			for (_i = 0; _i < shakes.length; _i++ )
				if (shakes[_i].object == _object) {
					shakes[_i].amplitudes[shakes[_i].amplitudes.length] = new ShakeAmplitude(_amplitude, _time);
					return null;
				}
			var _s:Shake = new Shake(_object);
			_s.amplitudes[0] = new ShakeAmplitude(_amplitude, _time);
			shakes[shakes.length] = _s;
			return _s;
		}
		public function cancelShake(_object):void {
			for (_i = 0; _i < shakes.length; _i++ )
				if (shakes[_i].object == _object) {
					shakes[_i].cancel();
					shakes.splice(_i--, 1);
					return;
				}
		}
		public static function staticAddShake(_object, _amplitude:Number, _time:Number):Shake {
			if (copy) return copy.addShake(_object, _amplitude, _time);
			else return null;
		}
		public static function staticCancelShake(_object):void {
			if (copy) copy.cancelShake(_object);
		}
		public static function staticStep():void {
			if (copy) copy.step();
		}
		public function step():void {
			for (_i = 0; _i < shakes.length; _i++ )
				if (shakes[_i].step()) {
					if (shakes[_i].onCmplt !== null) shakes[_i].onCmplt();
					shakes.splice(_i--, 1);
				}
		}
	}
}
