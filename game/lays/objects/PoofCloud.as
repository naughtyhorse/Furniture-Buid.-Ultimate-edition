package game.lays.objects {
	import game.managing.BitmapStorage;
	import LightStageStuff.LightDisplayContainer;
	import LightStageStuff.LightObject;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class PoofCloud extends LightDisplayContainer {
		static const MINIMUM_CLOUDS:int = 6;
		static const MAXIMUM_CLOUDS:int = 6;
		static const START_VECTOR_SPEED:Number = 6;
		static const VECTOR_SPEED_DECREASE:Number = .5;
		static const START_SIZE_SPEED:Number = .095;
		static const SIZE_SPEED_DECREASE:Number = .0095;
		static const ROTATION_SPEED:Number = .3;
		static const ALPHA_DECREASE:Number = .025;
		static const CLOUD_VECTOR_Y:Number = .5;
		
		private var clouds:Vector.<LightObject>;
		private var cloudDirections:Vector.<Number>;
		private var alphaTrigger:Boolean = false;
		private var vectorSpeed:Number = START_VECTOR_SPEED;
		private var size:Number = .23;
		private var sizeSpeed:Number = START_SIZE_SPEED;
		
		private var sizeFlag:Boolean = false;
		private var vectorFlag:Boolean = false;
		
		private var _ii:int;
		
		public function PoofCloud() {
			clouds = new Vector.<LightObject>;
			cloudDirections = new Vector.<Number>;
			for (_ii = 0; _ii < MINIMUM_CLOUDS + Math.random() * (MAXIMUM_CLOUDS - MINIMUM_CLOUDS); _ii++ ) {
				var _lo:LightObject = new LightObject(BitmapStorage.staticGetBitmap("particles", "cloud"));
				_lo.centrilised = true;
				addChild(_lo);
				_lo.rotation = Math.random() * 360;
				clouds[clouds.length] = _lo;
				cloudDirections[cloudDirections.length] = Math.random() * 360;
			}
		}
		public function step():Boolean {
			if (!sizeFlag) {
				size += sizeSpeed;
				sizeSpeed -= SIZE_SPEED_DECREASE;
				if (sizeSpeed <= 0) {
					sizeSpeed = 0;
					sizeFlag = true;
				}
			}
			for (_ii = 0; _ii < clouds.length; _ii++ ) {
				clouds[_ii].rotation += ROTATION_SPEED;
				if (!sizeFlag || !vectorFlag) {
					clouds[_ii].x += Math.cos(Math.PI * cloudDirections[_ii] / 180) * vectorSpeed;
					clouds[_ii].y += Math.sin(Math.PI * cloudDirections[_ii] / 180) * vectorSpeed;
					clouds[_ii].Scale = size;
				} else {
					clouds[_ii].Alpha -= ALPHA_DECREASE;
					if (clouds[_ii].Alpha <= 0) return true;
				}
				clouds[_ii].y -= CLOUD_VECTOR_Y;
			}
			if (!vectorFlag) {
				vectorSpeed -= VECTOR_SPEED_DECREASE;
				if (vectorSpeed <= 0) {
					vectorSpeed = 0;
					vectorFlag = true;
				}
			}
			return false;
		}
	}
}
