package game.lays {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import game.lays.objects.ContolButton;
	import game.managing.BitmapStorage;
	import game.managing.SoundsManager;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class ControlButtonsLay extends Sprite {
		
		private var screenshotBtn:ContolButton;
		private var muteBtn:ContolButton;
		private var mmBtn:ContolButton;
		
		public var onBackToMM:Function = null;
		public var onScreenshot:Function = null;
		
		public function ControlButtonsLay() {
			screenshotBtn = new ContolButton(BitmapStorage.staticGetBitmap("btns", "scrnsht"));
			addChild(screenshotBtn);
			screenshotBtn.addEventListener(MouseEvent.CLICK, cl);
			
			muteBtn = new ContolButton(BitmapStorage.staticGetBitmap("btns", "mt"));
			addChild(muteBtn);
			muteBtn.x = 47;
			muteBtn.addEventListener(MouseEvent.CLICK, cl);
			
			mmBtn = new ContolButton(BitmapStorage.staticGetBitmap("btns", "mm"));
			addChild(mmBtn);
			mmBtn.x = 94;
			mmBtn.addEventListener(MouseEvent.CLICK, cl);
		}
		private function cl(e:MouseEvent):void {
			switch(e.target) {
				case screenshotBtn:
					onScreenshot();
					break;
				case muteBtn:
					SoundsManager.Mute = !SoundsManager.Mute;
					break;
				case mmBtn:
					onBackToMM();
					break;
			}
		}
		public function step():void {
			screenshotBtn.step();
			muteBtn.step();
			mmBtn.step();
		}
	}
}
