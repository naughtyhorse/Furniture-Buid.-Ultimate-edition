package game.managing.struct {
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class Shake {
		
		public var object;
		
		private var originalX:Number;
		private var originalY:Number;
		
		public var amplitudes:Vector.<ShakeAmplitude>;
		
		public var onCmplt:Function;
		
		private var _tempAmplitude:Number = 0;
		private var _i:int
		
		public function Shake(_object):void {
			object = _object;
			originalX = object.x;
			originalY = object.y;
			amplitudes = new Vector.<ShakeAmplitude>;
		}
		public function onComplete(_function:Function):void {
			onCmplt = _function;
		}
		public function cancel():void {
			object.x = originalX;
			object.y = originalY;
		}
		public function step():Boolean {
			for (_i = 0; _i < amplitudes.length; _i++ ) {
				if (amplitudes[_i].amplitude > _tempAmplitude)
					_tempAmplitude = amplitudes[_i].amplitude;
				amplitudes[_i].amplitude += amplitudes[_i].decrement;
			}
			if (_tempAmplitude <= 0) {
				object.x = originalX;
				object.y = originalY;
				_tempAmplitude = 0;
				return true;
			} else {
				object.x = -_tempAmplitude + Math.random() * (_tempAmplitude * 2) + originalX;
				object.y = -_tempAmplitude + Math.random() * (_tempAmplitude * 2) + originalY;
				_tempAmplitude = 0;
				return false;
			}
		}
	}
}
