package game.graphics {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class CentrilizedBmd extends Sprite {
		
		public var bitmap:Bitmap;
		
		public function CentrilizedBmd(_bmd:BitmapData, _deviantX:Number = 0, _deviantY:Number = 0) {
			bitmap = new Bitmap(_bmd, "auto", true);
			addChild(bitmap);
			bitmap.x = -bitmap.width / 2 + _deviantX;
			bitmap.y = -bitmap.height / 2 + _deviantY;
		}
	}
}
