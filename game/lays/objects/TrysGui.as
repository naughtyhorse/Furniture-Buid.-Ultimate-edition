package game.lays.objects {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.factory.stencil.StencilTitle;
	import game.managing.BitmapStorage;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class TrysGui extends Sprite {
		public static const WID:Number = 175;
		public static const HEI:Number = 40;
		
		private var head:Bitmap;
		
		public var trys:StencilTitle;
		
		public function TrysGui() {
			head = new Bitmap(BitmapStorage.staticGetBitmap("stencil", "hd_trys"));
			addChild(head);
			trys = StencilTitle.getTitle(1);
			addChild(trys);
			trys.Text = "10";
			trys.x = head.width + 3;
			trys.y = 5;
		}
	}
}
