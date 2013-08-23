package game.screens.objects {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import game.factory.stencil.StencilTitle;
	import game.managing.BitmapStorage;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class ScoresTable extends Sprite {
		static const WID:Number = 509;
		static const HEI:Number = 540;
		
		private var furnitureHead:Bitmap;
		private var furnitureCount:StencilTitle;
		
		private var glueHead:Bitmap;
		private var glueCount:StencilTitle;
		
		private var bombsHead:Bitmap;
		private var bombsCount:StencilTitle;
		
		private var ropesHead:Bitmap;
		private var ropesCount:StencilTitle;
		
		private var heiHead:Bitmap;
		private var heiCount:StencilTitle;
		
		public function ScoresTable(_furnCount:int, _glueCount:int, _bombsCount:int, _ropesCount:int, _hei:String) {
			var _shadow:DropShadowFilter = new DropShadowFilter(6, 45, 0, .5, 6, 6, 1, 3);
			
			furnitureHead = new Bitmap(BitmapStorage.staticGetBitmap("scores", "furn"));
			addChild(furnitureHead);
			furnitureCount = StencilTitle.getTitle(2);
			furnitureCount.Text = String(_furnCount);
			addChild(furnitureCount);
			furnitureHead.x = 14;
			furnitureHead.y = 4;
			furnitureCount.x = 291
			furnitureCount.y = 38;
			furnitureHead.filters = [_shadow];
			furnitureCount.filters = [_shadow];
			
			glueHead = new Bitmap(BitmapStorage.staticGetBitmap("scores", "glue"));
			addChild(glueHead);
			glueCount = StencilTitle.getTitle(2);
			glueCount.Text = String(_glueCount);
			addChild(glueCount);
			glueHead.x = 14;
			glueHead.y = 123;
			glueCount.x = 257
			glueCount.y = 155;
			glueHead.filters = [_shadow];
			glueCount.filters = [_shadow];
			
			bombsHead = new Bitmap(BitmapStorage.staticGetBitmap("scores", "bomb"));
			addChild(bombsHead);
			bombsCount = StencilTitle.getTitle(2);
			bombsCount.Text = String(_bombsCount);
			addChild(bombsCount);
			bombsHead.x = 14;
			bombsHead.y = 243;
			bombsCount.x = 266
			bombsCount.y = 267;
			bombsHead.filters = [_shadow];
			bombsCount.filters = [_shadow];
			
			ropesHead = new Bitmap(BitmapStorage.staticGetBitmap("scores", "rope"));
			addChild(ropesHead);
			ropesCount = StencilTitle.getTitle(2);
			ropesCount.Text = String(_ropesCount);
			addChild(ropesCount);
			ropesHead.x = 14;
			ropesHead.y = 343;
			ropesCount.x = 307
			ropesCount.y = 373;
			ropesHead.filters = [_shadow];
			ropesCount.filters = [_shadow];
			
			heiHead = new Bitmap(BitmapStorage.staticGetBitmap("scores", "hei"));
			addChild(heiHead);
			heiCount = StencilTitle.getTitle(3);
			heiCount.Text = _hei ;
			addChild(heiCount);
			heiHead.x = 14;
			heiHead.y = 482;
			heiCount.x = 305
			heiCount.y = 483;
			heiHead.filters = [_shadow];
			heiCount.filters = [_shadow];
			
			this.graphics.beginFill(0, .5);
			this.graphics.drawRect(0, 0, WID, HEI);
			this.graphics.endFill();
		}
	}
}
