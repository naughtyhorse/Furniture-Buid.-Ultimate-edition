package game.screens {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.factory.KittyButton;
	import game.factory.KittyButtonFactory;
	import game.managing.BitmapStorage;
	import game.screens.objects.Background;
	import game.screens.objects.ScoresTable;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class ScoresScreen extends Sprite {
		
		private var bg:Background;
		private var table:ScoresTable;
		
		public var replayBtn:KittyButton;
		public var mmBtn:KittyButton;
		
		public function ScoresScreen() {
			super();
		}
		public function init(_furnCount:int, _glueCount:int, _bombsCount:int, _ropesCount:int, _hei:String):void {
			bg = new Background();
			addChild(bg);
			bg.init();
			table = new ScoresTable(_furnCount, _glueCount, _bombsCount, _ropesCount, _hei);
			addChild(table);
			table.x = 20;
			table.y = (stage.stageHeight - table.height) / 2;
			replayBtn = KittyButtonFactory.staticGetButton(BitmapStorage.staticGetBitmap("btns", "hd_rply"));
			addChild(replayBtn);
			replayBtn.x = table.x + table.width + 150;
			replayBtn.y = stage.stageHeight / 3;
			mmBtn = KittyButtonFactory.staticGetButton(BitmapStorage.staticGetBitmap("btns", "hd_mm"));
			addChild(mmBtn);
			mmBtn.x = table.x + table.width + 150;
			mmBtn.y = stage.stageHeight / 2;
		}
		public function step():void {
			bg.incrementScroll(3);
			bg.step();
		}
	}
}
