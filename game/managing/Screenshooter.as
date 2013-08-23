package game.managing {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import game.factory.stencil.StencilTitle;
	import game.lays.objects.HeiGui;
	import game.World;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class Screenshooter {
		
		public static function getBitmap(_world:World, _hei:String):BitmapData {
			var _bmd:BitmapData = new BitmapData(_world.stage.stageWidth, _world.stage.stageHeight);
			
			var _heiShit:Sprite = new Sprite();
			_world.addChild(_heiShit);
			_heiShit.graphics.beginFill(0, .4);
			_heiShit.graphics.drawRect(10, 10, HeiGui.WID, HeiGui.HEI);
			_heiShit.graphics.endFill();
			
			var head:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("stencil", "ghd_hei"));
			_heiShit.addChild(head);
			head.x = 15;
			head.y = (HeiGui.HEI - head.height) / 2 + 8;
			head.filters = [new DropShadowFilter(4, 45, 0, .3, 4, 4, 1, 3)];
			
			var hei:StencilTitle = StencilTitle.getTitle(0);
			hei.Text = _hei;
			_heiShit.addChild(hei)
			hei.x = head.x + head.width + 5;
			hei.y = head.y;
			hei.filters = [new DropShadowFilter(4, 45, 0, .3, 4, 4, 1, 3)];
			
			var _tc:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("gui", "tc"));
			_world.addChild(_tc);
			_tc.x = _world.stage.stageWidth - _tc.width - 6;
			_tc.y = 6;
			_tc.filters = [new DropShadowFilter(4, 45, 0, .3, 4, 4, 1, 3)];
			
			_bmd.draw(_world);
			
			_world.removeChild(_heiShit);
			_world.removeChild(_tc);
			
			return _bmd;
		}
	}
}
