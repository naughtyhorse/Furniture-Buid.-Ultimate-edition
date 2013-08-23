package game.lays.objects {
	import game.managing.BitmapStorage;
	import LightStageStuff.LightObject;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class Poof extends LightObject {
		static const VECTOR_Y:Number = .8;
		static const ROTATION_FROM:Number = -10;
		static const ROTATION_TO:Number = 10;
		
		private var alphaDecrement:Number;
		
		public function Poof(_tileLife:Number) {
			super(BitmapStorage.staticGetBitmap("stencil", "hd_poof"));
			centrilised = true;
			alphaDecrement = 1 / (60 * _tileLife);
			rotation = ROTATION_FROM + Math.random() * (ROTATION_TO - ROTATION_FROM);
		}
		public function step():Boolean {
			y -= VECTOR_Y;
			Alpha -= alphaDecrement;
			return (Alpha <= 0);
		}
	}
}
