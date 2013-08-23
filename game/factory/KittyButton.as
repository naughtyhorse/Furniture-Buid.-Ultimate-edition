package game.factory {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import game.graphics.CentrilizedBmd;
	import game.managing.BitmapStorage;
	import game.managing.SoundsManager;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class KittyButton extends Sprite {
		static const KITTY_AMPLITUDE:Number = 20;
		static const KITTY_SHAKE_SPEED:Number = .5;
		static const KITTY_DEVIANT:Number = 40;
		
		private var head:Bitmap;
		
		private var kitty:Bitmap;
		
		private var blockedKittyBm:CentrilizedBmd;
		
		public var onClick:Function = null;
		
		private var kittyShakeFlag:Boolean = false;
		private var kittyShakeTrigger:Boolean = true;
		private var blocked:Boolean = false;
		
		private var disposed:Boolean = false;
		
		public function KittyButton(_headBmd:BitmapData):void {
			head = new Bitmap(_headBmd);
			addChild(head);
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, clickEv);
			this.addEventListener(MouseEvent.MOUSE_OVER, overEv);
			this.addEventListener(MouseEvent.MOUSE_OUT, outEv);
			kitty = new Bitmap(BitmapStorage.staticGetBitmap("btns", "ktty_1"));
			blockedKittyBm = new CentrilizedBmd(BitmapStorage.staticGetBitmap("btns", "ktty_2"), -29, -29);
			addChild(blockedKittyBm);
			blockedKittyBm.visible = false;
			blockedKittyBm.x = -KITTY_DEVIANT
			blockedKittyBm.y = head.height / 2;
			
			filters = [new DropShadowFilter(4, 45, 0, .3, 4, 4, 1, 3)];
		}
		private function overEv(e):void {
			if (blocked) return;
			addChild(kitty);
			kitty.x = -KITTY_DEVIANT - kitty.width / 2;
			kitty.y = (head.height - kitty.height) / 2;
			kittyShakeFlag = true;
			kittyShakeTrigger = true;
			SoundsManager.playButtonOverSound();
		}
		private function outEv(e):void {
			if (blocked) return;
			removeChild(kitty);
			kittyShakeFlag = false;
		}
		private function clickEv(e):void {
			if (blocked) return;
			SoundsManager.playButtonClickSound();
			if (onClick !== null) onClick();
		}
		public function dispose():void {
			if (parent) parent.removeChild(this);
			disposed = true;
		}
		public function step():Boolean {
			if (kittyShakeFlag)
				if (kittyShakeTrigger) {
					kitty.x += KITTY_SHAKE_SPEED;
					if (kitty.x >= -KITTY_DEVIANT + KITTY_AMPLITUDE - kitty.width / 2) {
						kitty.x = -KITTY_DEVIANT + KITTY_AMPLITUDE - kitty.width / 2;
						kittyShakeTrigger = false;
					}
				} else {
					kitty.x -= KITTY_SHAKE_SPEED;
					if (kitty.x <= -KITTY_DEVIANT - kitty.width / 2) {
						kitty.x = -KITTY_DEVIANT - kitty.width / 2;
						kittyShakeTrigger = true;
					}
				}
			if (blocked) blockedKittyBm.rotation += 1;
			return disposed;
		}
		public function set Blocked(value:Boolean):void {
			blockedKittyBm.visible = blocked = value;
			head.alpha = blocked ? .7 : 1;
			if (blocked) if(kitty.parent) removeChild(kitty);
		}
		public function get Blocked():Boolean {
			return blocked;
		}
	}
}
