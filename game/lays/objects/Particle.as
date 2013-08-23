package game.lays.objects {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import LightStageStuff.LightObject;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class Particle extends LightObject {
		static const GRAVITY_VECTOR:Point = new Point(0, .5);
		
		private var currentVector:Point;
		
		private var directed:Boolean;
		private var rotationSpeed:Number;
		
		private var alphaDecrement:Number;
		
		public function Particle(_bmd:BitmapData, _timeLife:Number) {
			super(_bmd);
			this.centrilised = true;
			alphaDecrement = 1 / (60 * _timeLife);
		}
		public function initSpinning(_impulse:Number, _direction:Number, _rotationSpeed:Number):void {
			directed = false;
			rotationSpeed = _rotationSpeed;
			currentVector = new Point(Math.cos(Math.PI * _direction / 180) * _impulse, Math.sin(Math.PI * _direction / 180) * _impulse);
			rotation = Math.random() * 360;
		}
		public function initDirected(_impulse:Number, _direction:Number):void {
			directed = true;
			currentVector = new Point(Math.cos(Math.PI * _direction / 180) * _impulse, Math.sin(Math.PI * _direction / 180) * _impulse);
		}
		public function step():Boolean {
			Alpha -= alphaDecrement;
			if (Alpha <= 0)
				return true;
			else {
				currentVector.x += GRAVITY_VECTOR.x;
				currentVector.y += GRAVITY_VECTOR.y;
				if (directed) this.rotation = getAngle(this.x, this.y, this.x + currentVector.x, this.y + currentVector.y);
				else this.rotation += rotationSpeed;
				this.x += currentVector.x;
				this.y += currentVector.y;
				return false;
			}
		}
		private function getAngle(_x1:Number, _y1:Number, _x2:Number, _y2:Number):Number {
			var _dx:Number = _x2 - _x1;
			var _dy:Number = _y2 - _y1;
			return Math.atan2(_dy, _dx) * 180 / Math.PI;
		}
	}
}
