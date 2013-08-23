package game.objects {
	import flash.display.Sprite;
	import game.graphics.CentrilizedBmd;
	import game.managing.BitmapStorage;
	import nape.phys.Body;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class ThermiteBomb {
		
		public var body:Body;
		
		public var graphics:CentrilizedBmd;
		
		public var banSign:CentrilizedBmd;
		
		public function ThermiteBomb(_body:Body) {
			body = _body;
			graphics = new CentrilizedBmd(BitmapStorage.staticGetBitmap("tls", "bomb"));
		}
		public function reify(_container:Sprite):void {
			banSign = new CentrilizedBmd(BitmapStorage.staticGetBitmap("sign", "ban"));
			banSign.alpha = .4;
			banSign.visible = false;
			_container.addChild(banSign);
		}
		public function dispose():void {
			if (graphics.parent) graphics.parent.removeChild(graphics);
			if (banSign)
				if (banSign.parent) banSign.parent.removeChild(banSign);
		}
		public function step():void {
			graphics.x = body.position.x;
			graphics.y = body.position.y;
			graphics.rotation = body.rotation * 180 / Math.PI;
			if (banSign) {
				banSign.x = graphics.x;
				banSign.y = graphics.y;
			}
		}
	}
}
