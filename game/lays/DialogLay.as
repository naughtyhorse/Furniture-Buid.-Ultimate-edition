package game.lays {
	import flash.display.Sprite;
	import game.lays.objects.ScrollHint;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class DialogLay extends Sprite {
		
		private var scrollHint:ScrollHint;
		private var scrollHintFlag:Boolean = true;
		
		public function DialogLay() {
			
		}
		public function spawnScrollHint():void {
			if (scrollHintFlag) if (!scrollHint) {
				scrollHint = new ScrollHint();
				addChild(scrollHint);
				scrollHint.x = stage.stageWidth / 2;
				scrollHint.y = 80;
			}
		}
		public function removeScrollHint():void {
			if (scrollHintFlag) if (scrollHint) {
				scrollHintFlag = false;
				removeChild(scrollHint);
				scrollHint = null;
			}
		}
		public function step():void {
			if (scrollHint) scrollHint.step();
		}
	}
}
