package game.lays.objects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class HipsterCloud extends Sprite {
		
		private var bm:Bitmap;
		private var speed:Number;
		
		public var _y:Number;
		
		public function HipsterCloud(_bmd:BitmapData, _speed:Number):void {
			bm = new Bitmap(_bmd);
			addChild(bm);
			bm.x = -bm.width / 2;
			bm.y = -bm.height / 2;
			speed = _speed;
		}
		public function step():Boolean {
			this.x -= speed;
			if (this.x <= bm.x) return true;
			else return false;
		}
	}
}
