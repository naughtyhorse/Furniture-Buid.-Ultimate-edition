package game.screens.objects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import game.managing.BitmapStorage;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class Background extends Sprite {
		static const MOSAIC_SCROLL_MULTIPLIER:Number = .2;
		static const CLOUD_RELOADING:Number = .1;
		static const CLOUD_SPAWN_CHANCE:int = 10;
		static const CLOUD_PUSHED_CHANCE:int = 50;
		static const CLOUD_X_VECTOR_FROM:Number = .4;
		static const CLOUD_X_VECTOR_TO:Number = 2;
		static const CLOUD_Y_VECTOR:Number = 1;
		static const CLOUDS_MAX:int = 10;
		
		private var tiles:Vector.<Bitmap>;
		private var tileCont:Sprite;
		
		private var sourceTileHei:Number;
		
		private var clouds:Vector.<Bitmap>;
		private var xVectros:Vector.<Number>;
		
		private var cloudReloading:Number = 1;
		
		private var _i:int;
		
		public function Background() {
			super();
			clouds = new Vector.<Bitmap>;
			xVectros = new Vector.<Number>;
		}
		public function init():void {
			tiles = new Vector.<Bitmap>;
			var _source:BitmapData = BitmapStorage.staticGetBitmap("gui", "bgtl");
			sourceTileHei = _source.height;
			tileCont = new Sprite();
			addChild(tileCont);
			var _x:int = Math.ceil(stage.stageWidth / _source.width);
			var _y:int = Math.ceil(stage.stageHeight / _source.height) + 3;
			for (_i = 0; _i < _x * _y; _i++ ) {
				var _bm:Bitmap = new Bitmap(_source);
				tileCont.addChild(_bm);
				tiles[tiles.length] = _bm;
			}
			_x = 0;
			_y = 0;
			for (_i = 0; _i < tiles.length; _i++ ) {
				tiles[_i].x = _x;
				tiles[_i].y = _y;
				_x += tiles[_i].width;
				if (_x > stage.stageWidth) {
					_x = 0;
					_y += tiles[_i].height;
				}
			}
		}
		public function incrementScroll(_increment:Number):void {
			tileCont.y += _increment * MOSAIC_SCROLL_MULTIPLIER;
			while (tileCont.y > 0) tileCont.y -= sourceTileHei;
			while (tileCont.y < stage.stageHeight - tileCont.height) tileCont.y += sourceTileHei;
		}
		private function spawnCloud():void {
			if (clouds.length < CLOUDS_MAX) {
				var _cl:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("gui", "hcl_" + String(Math.ceil(Math.random() * 4))));
				addChild(_cl);
				_cl.filters = [new DropShadowFilter(7, 45, 0, .5, 7, 7, 1, 3)];
				clouds[clouds.length] = _cl;
				xVectros[xVectros.length] = CLOUD_X_VECTOR_FROM + Math.random() * (CLOUD_X_VECTOR_TO - CLOUD_X_VECTOR_FROM);
				if (Math.random() * 100 <= CLOUD_PUSHED_CHANCE) {
					_cl.y = -_cl.height;
					_cl.x = stage.stageWidth / 2 + Math.random() * stage.stageWidth / 2;
				} else {
					_cl.y = Math.random() * stage.stageHeight / 2;
					_cl.x = stage.stageWidth;
				}
			}
		}
		public function step():void {
			cloudReloading += CLOUD_RELOADING;
			if (cloudReloading >= 1) {
				cloudReloading--;
				if (Math.random() * 100 <= CLOUD_SPAWN_CHANCE)
					spawnCloud();
			}
			for (_i = 0; _i < clouds.length; _i++ ) {
				clouds[_i].x -= xVectros[_i];
				clouds[_i].y += CLOUD_Y_VECTOR;
				if (clouds[_i].x <= -clouds[_i].width || clouds[_i].y >= stage.stageHeight) {
					removeChild(clouds[_i]);
					clouds.splice(_i, 1);
					xVectros.splice(_i--, 1);
				}
			}
		}
	}
}
