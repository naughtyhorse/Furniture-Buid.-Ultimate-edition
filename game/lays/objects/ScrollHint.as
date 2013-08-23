package game.lays.objects {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.managing.BitmapStorage;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class ScrollHint extends Sprite {
		static const SCALE_PULSE_FROM:Number = .95;
		static const SCALE_PULSE_TO:Number = 1.05;
		static const SCALE_PULSE_INCREMENT:Number = .005;
		
		private var bm:Bitmap;
		
		private var scalePulseTrigger:Boolean = true;
		
		public function ScrollHint() {
			bm = new Bitmap(BitmapStorage.staticGetBitmap("stencil", "hd_schnt"), "auto", true);
			addChild(bm);
			bm.x = -bm.width / 2;
			bm.y = -bm.height / 2;
		}
		public function step():void {
			if (scalePulseTrigger) {
				this.scaleX += SCALE_PULSE_INCREMENT;
				if (this.scaleX >= SCALE_PULSE_TO) {
					this.scaleX = SCALE_PULSE_TO;
					scalePulseTrigger = false;
				}
			} else {
				this.scaleX -= SCALE_PULSE_INCREMENT;
				if (this.scaleX <= SCALE_PULSE_FROM) {
					this.scaleX = SCALE_PULSE_FROM;
					scalePulseTrigger = true;
				}
			}
			this.scaleY = this.scaleX;
		}
	}
}
