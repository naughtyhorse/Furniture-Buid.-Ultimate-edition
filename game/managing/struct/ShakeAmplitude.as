package game.managing.struct {
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class ShakeAmplitude {
		
		public var amplitude:Number;
		public var decrement:Number;
		
		public function ShakeAmplitude(_amplitude:Number, _time:Number):void {
			amplitude = _amplitude;
			decrement = -_amplitude / (60 * _time);
		}
	}
}
