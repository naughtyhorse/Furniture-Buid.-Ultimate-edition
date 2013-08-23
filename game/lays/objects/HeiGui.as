package game.lays.objects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import game.factory.stencil.StencilTitle;
	import game.graphics.AnimationPack;
	import game.managing.BitmapStorage;
	import game.managing.Shaker;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public class HeiGui extends Sprite {
		public static const WID:Number = 275;
		public static const HEI:Number = 50;
		
		private var head:Bitmap;
		
		private var hei:StencilTitle;
		private var checkAnim:AnimationPack;
		
		public function HeiGui() {
			head = new Bitmap(BitmapStorage.staticGetBitmap("stencil", "ghd_hei"));
			addChild(head);
			
			hei = StencilTitle.getTitle(0);
			hei.Text = "0.0m";
			addChild(hei)
			hei.x = head.width + 5;
			hei.y = head.height - hei.height + 3;
			checkAnim = new AnimationPack();
			checkAnim.addAnimationSheet(new < BitmapData > [BitmapStorage.staticGetBitmap("stencil", "ghd_ch_1"),
															BitmapStorage.staticGetBitmap("stencil", "ghd_ch_2"),
															BitmapStorage.staticGetBitmap("stencil", "ghd_ch_3")], "main", 10);
			checkAnim.CurrentSheet = "main";
			checkAnim.x = head.width + checkAnim.width / 2 + 5;
			checkAnim.y = head.height - checkAnim.height / 4 - 1;
			addChild(checkAnim);
			checkAnim.visible = false;
		}
		public function step():void {
			if (checkAnim.visible) checkAnim.step();
		}
		public function set Hei(value:Number):void {
			hei.Text = value.toFixed(1) + "m";
			Shaker.staticAddShake(hei, 2, .5);
		}
		public function get HeiS():String {
			return hei.Text;
		}
		public function set ShowCheck(value:Boolean):void {
			checkAnim.visible = value;
			hei.visible = !value;
		}
	}
}
