package game.screens {
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import game.factory.KittyButton;
	import game.factory.KittyButtonFactory;
	import game.managing.BitmapStorage;
	import game.screens.objects.Background;
	import game.screens.objects.GameLogo;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class MainMenuScreen extends Sprite {
		
		private var bg:Background;
		private var logo:GameLogo;
		
		public var playButton:KittyButton;
		
		public function MainMenuScreen() {
			super();
		}
		public function init():void {
			bg = new Background();
			addChild(bg);
			bg.init();
			logo = new GameLogo();
			addChild(logo);
			logo.x = stage.stageWidth / 2;
			logo.y = 100;
			logo.filters = [new DropShadowFilter(7, 45, 0, .5, 4, 4, 1, 3)];
			playButton = KittyButtonFactory.staticGetButton(BitmapStorage.staticGetBitmap("btns", "hd_ply"));
			addChild(playButton);
			playButton.x = stage.stageWidth / 2 - 90;
			playButton.y = stage.stageHeight / 1.8;
		}
		public function step():void {
			bg.incrementScroll(3);
			bg.step();
			logo.step();
		}
	}
}
