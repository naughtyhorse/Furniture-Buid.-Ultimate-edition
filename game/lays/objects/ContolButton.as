package game.lays.objects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import game.graphics.CentrilizedBmd;
	import game.managing.BitmapStorage;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class ContolButton extends Sprite {
		private static const PEND_MAX_DEV:Number = 20;
		private static const PEND_SPEED:Number = .9;
		
		private var kruzhok:Bitmap;
		private var head:CentrilizedBmd;
		
		private var pend:Boolean = false;
		
		private var _pendTrigger:Boolean = false;
		
		public function ContolButton(_headBmd:BitmapData) {
			kruzhok = new Bitmap(BitmapStorage.staticGetBitmap("btns", "krzhk"));
			addChild(kruzhok);
			kruzhok.x = -kruzhok.width * .5;
			kruzhok.y = -kruzhok.height * .5;
			
			head = new CentrilizedBmd(_headBmd);
			addChild(head);
			
			alpha = .85;
			
			this.buttonMode = true;
			this.mouseChildren = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, mOv);
			addEventListener(MouseEvent.MOUSE_OUT, mOu);
		}
		private function mOv(e:MouseEvent):void {
			pend = true;
			alpha = 1;
		}
		private function mOu(e:MouseEvent):void {
			pend = false;
			head.rotation = 0;
			alpha = .85;
		}
		public function step():void {
			if (pend) {
				if (_pendTrigger) {
					head.rotation += PEND_SPEED;
					if (head.rotation > PEND_MAX_DEV)
						_pendTrigger = false;
				} else {
					head.rotation -= PEND_SPEED;
					if (head.rotation < -PEND_MAX_DEV)
						_pendTrigger = true;
				}
			}
		}
	}
}
