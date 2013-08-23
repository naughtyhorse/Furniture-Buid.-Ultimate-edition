package game.lays {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import game.lays.objects.HipsterCloud;
	import game.managing.BitmapStorage;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class BackgroundLay extends Sprite {
		static const MOSAIC_SCROLL_MULTIPLIER:Number = .2;
		static const OBJECTS_SCROLL_MULTIPLIER:Number = .4;
		static const LOWER_CLOUDS_BORDER:Number = 50;
		static const CLOUD_EXTRA_BORDER:Number = 100;
		static const CLOUD_LOADING_SPEED:Number = .05;
		static const CLOUD_CHANCE:int = 5;
		static const CLOUD_SPEED_FROM:Number = .5;
		static const CLOUD_SPEED_TO:Number = 2;
		static const CLOUD_SECTOR:Number = 50;
		static const MAXIMUM_CLOUDS_PER_SECTOR:int = 2;
		
		private var tiles:Vector.<Bitmap>;
		private var tileCont:Sprite;
		
		private var maunt:Bitmap;
		private var objScroll:Number = 0;
		
		private var sourceTileHei:Number;
		public var upperLimit:Number;
		
		private var cloudSpawnLoading:Number = 0;
		private var cloudSpawningFlag:Boolean = false;
		
		private var clouds:Vector.<HipsterCloud>;
		
		private var currentMaximumClouds:int = 0;
		
		private var hipsterCloudBmds:Vector.<BitmapData>;
		
		private var _i:int;
		
		public function BackgroundLay() {
			super();
		}
		public function init():void {
			tiles = new Vector.<Bitmap>;
			clouds = new Vector.<HipsterCloud>;
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
			maunt = new Bitmap(BitmapStorage.staticGetBitmap("gui", "mnt"));
			addChild(maunt);
			maunt.y = stage.stageHeight - maunt.height;
		}
		public function incrementScroll(_increment:Number):void {
			tileCont.y += _increment * MOSAIC_SCROLL_MULTIPLIER;
			objScroll += _increment * OBJECTS_SCROLL_MULTIPLIER;
			while (tileCont.y > 0) tileCont.y -= sourceTileHei;
			while (tileCont.y < stage.stageHeight - tileCont.height) tileCont.y += sourceTileHei;
			updateObjects();
		}
		private function updateObjects():void {
			maunt.y = stage.stageHeight - maunt.height + objScroll;
			for (_i = 0; _i < clouds.length; _i++ )
				clouds[_i].y = clouds[_i]._y + objScroll;
		}
		public function setUpperLimit(_limit:Number):void {
			upperLimit = _limit * OBJECTS_SCROLL_MULTIPLIER;
			cloudSpawningFlag = (upperLimit >= LOWER_CLOUDS_BORDER);
			if (cloudSpawningFlag)
				currentMaximumClouds = Math.ceil((upperLimit - LOWER_CLOUDS_BORDER) / CLOUD_SECTOR) * MAXIMUM_CLOUDS_PER_SECTOR;
		}
		private function spawnHipsterCloud():void {
			if (currentMaximumClouds > clouds.length) {
				var hc:HipsterCloud = new HipsterCloud(BitmapStorage.staticGetBitmap("gui", "hcl_" + Math.floor(Math.random() * 4)), CLOUD_SPEED_FROM + Math.random() * (CLOUD_SPEED_TO - CLOUD_SPEED_FROM));
				addChild(hc);
				hc.filters = [new DropShadowFilter(7, 45, 0, .5, 7, 7, 1, 3)];
				hc.x = stage.stageWidth + hc.width / 2;
				hc._y = LOWER_CLOUDS_BORDER + Math.random() * (upperLimit - CLOUD_EXTRA_BORDER - LOWER_CLOUDS_BORDER) - hc.height / 2;
				hc.y = hc._y + objScroll;
				clouds[clouds.length] = hc;
			}
		}
		public function restart():void {
			tileCont.y = 0;
			objScroll = 0;
			for (_i = 0; _i < clouds.length; _i++ )
				removeChild(clouds[_i]);
			clouds.splice(0, clouds.length);
			cloudSpawnLoading = 0;
			maunt.y = stage.stageHeight - maunt.height + objScroll;
			currentMaximumClouds = 0;
			cloudSpawningFlag = false;
		}
		public function step():void {
			cloudSpawnLoading += CLOUD_LOADING_SPEED;
			if (cloudSpawnLoading >= 1) {
				if (int(Math.random() * 100) <= CLOUD_CHANCE)
					spawnHipsterCloud();
				cloudSpawnLoading--;
			}
			for (_i = 0; _i < clouds.length; _i++ )
				if (clouds[_i].step()) {
					removeChild(clouds[_i]);
					clouds.splice(_i--, 1);
				}
		}
	}
}
