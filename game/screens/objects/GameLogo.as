package game.screens.objects {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.managing.BitmapStorage;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class GameLogo extends Sprite {
		static const MINIMUM_LOGO_SCALE:Number = .95;
		static const MAXIMUM_LOGO_SCALE:Number = 1.05;
		static const LOGO_SCALE_INCREMENT:Number = .0008;
		
		private var bm:Bitmap;
		
		private var jiggleTrigger:Boolean = true;
		
		public function GameLogo() {
			bm = new Bitmap(BitmapStorage.staticGetBitmap("gfx", "game_logo"), "auto", true);
			addChild(bm);
			bm.x = -bm.width / 2;
			bm.y = -bm.height / 2;
		}
		public function step():void {
			if (jiggleTrigger) {
				scaleX += LOGO_SCALE_INCREMENT;
				if (scaleX >= MAXIMUM_LOGO_SCALE) {
					scaleX = MAXIMUM_LOGO_SCALE;
					jiggleTrigger = false;
				}
			} else {
				scaleX -= LOGO_SCALE_INCREMENT;
				if (scaleX <= MINIMUM_LOGO_SCALE) {
					scaleX = MINIMUM_LOGO_SCALE;
					jiggleTrigger = true;
				}
			}
			scaleY = scaleX;
		}
	}
}
