package game.lays {
	import flash.display.Sprite;
	import game.lays.objects.Particle;
	import game.lays.objects.Poof;
	import game.lays.objects.PoofCloud;
	import game.managing.BitmapStorage;
	import LightStageStuff.LightObjectContainer;
	import LightStageStuff.LightStage;
	
	/**
	 * ...
	 * @author ...
	 */
	public final class GfxLay extends Sprite {
		static const DIRECTION_FROM:Number = -150;
		static const DIRECTION_TO:Number = -30;
		
		static const IMPULSE_FROM:Number = 8;
		static const IMPULSTE_TO:Number = 16;
		
		static const ROTATION_SPEED_FROM:Number = -5;
		static const ROTATION_SPEED_TO:Number = 5;
		
		private var particles:Vector.<Particle>;
		private var clouds:Vector.<PoofCloud>;
		private var poofs:Vector.<Poof>;
		
		private var stg:LightStage;
		public var cont:LightObjectContainer;
		
		private var _i:int;
		
		public function GfxLay(_wid:Number, _hei:Number) {
			stg = new LightStage(_wid, _hei);
			addChild(stg);
			cont = new LightObjectContainer();
			stg.addChild(cont);
			particles = new Vector.<Particle>;
			clouds = new Vector.<PoofCloud>;
			poofs = new Vector.<Poof>;
		}
		public function spawnSparks(_x:Number, _y:Number, _howMuch:int):void {
			var _par:Particle;
			for (var i:int = 0; i < _howMuch; i++ ) {
				_par = new Particle(BitmapStorage.staticGetBitmap("particles", "spark"), 1);
				cont.addChild(_par);
				_par.x = _x;
				_par.y = _y;
				_par.initDirected(Impulse, Direction);
				particles[particles.length] = _par;
			}
		}
		public function spawnStars(_x:Number, _y:Number, _howMuch:int):void {
			var _par:Particle;
			for (var i:int = 0; i < _howMuch; i++ ) {
				_par = new Particle(BitmapStorage.staticGetBitmap("particles", "star"), 1);
				cont.addChild(_par);
				_par.x = _x;
				_par.y = _y;
				_par.initSpinning(Impulse * .7, Direction, RotSpeed * 1.3);
				particles[particles.length] = _par;
			}
		}
		public function spawnDebris(_x:Number, _y:Number, _howMuch:int):void {
			var _par:Particle;
			for (var i:int = 0; i < _howMuch; i++ ) {
				_par = new Particle(BitmapStorage.staticGetBitmap("particles", "de_" + String(1 + Math.floor(Math.random() * 11))), 1);
				cont.addChild(_par);
				_par.x = _x;
				_par.y = _y;
				_par.initSpinning(Impulse, Direction, RotSpeed);
				particles[particles.length] = _par;
			}
		}
		public function spawnPoofCloud(_x:Number, _y:Number):void {
			var _cl:PoofCloud = new PoofCloud();
			cont.addChild(_cl);
			_cl.x = _x;
			_cl.y = _y;
			clouds[clouds.length] = _cl;
		}
		public function spawnPoof(_x:Number, _y:Number):void {
			var _pf:Poof = new Poof(1);
			cont.addChild(_pf);
			_pf.x = _x;
			_pf.y = _y;
			poofs[poofs.length] = _pf;
		}
		public function step():void {
			if (particles.length > 0 || clouds.length > 0 || poofs.length > 0) {
				for (_i = 0 ; _i < particles.length; _i++ )
					if (particles[_i].step()) {
						cont.removeChild(particles[_i]);
						particles.splice(_i--, 1);
					}
				for (_i = 0 ; _i < clouds.length; _i++ )
					if (clouds[_i].step()) {
						cont.removeChild(clouds[_i]);
						clouds.splice(_i--, 1);
					}
				for (_i = 0 ; _i < poofs.length; _i++ )
					if (poofs[_i].step()) {
						cont.removeChild(poofs[_i]);
						poofs.splice(_i--, 1);
					}
				stg.step();
			}
		}
		private function get Impulse():Number {
			return IMPULSE_FROM + Math.random() * (IMPULSTE_TO - IMPULSE_FROM);
		}
		private function get Direction():Number {
			return DIRECTION_FROM + Math.random() * (DIRECTION_TO - DIRECTION_FROM);
		}
		private function get RotSpeed():Number {
			return ROTATION_SPEED_FROM + Math.random() * (ROTATION_SPEED_TO - ROTATION_SPEED_FROM);
		}
	}
}
