package game.lays {
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import game.lays.objects.HeiGui;
	import game.lays.objects.SpawnGui;
	import game.lays.objects.TrysGui;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class GuiLay extends Sprite {
		
		public var spawnGui:SpawnGui;
		public var heiGui:HeiGui;
		public var trysGui:TrysGui;
		
		public var spawnGround:Shape;
		public var heiGround:Shape;
		public var trysGround:Shape;
		
		public function GuiLay() {
			super();
		}
		public function init(_guiCrateBmd:BitmapData):void {
			spawnGround = new Shape();
			addChild(spawnGround);
			heiGround = new Shape();
			addChild(heiGround);
			trysGround = new Shape();
			addChild(trysGround);
			
			spawnGui = new SpawnGui(_guiCrateBmd);
			addChild(spawnGui)
			spawnGui.x = stage.stageWidth - SpawnGui.WID - 10;
			spawnGui.y = 10;
			spawnGui.filters = [new DropShadowFilter(4, 45, 0, .3, 4, 4, 1, 3)];
			
			heiGui = new HeiGui();
			addChild(heiGui);
			heiGui.x = 15;
			heiGui.y = (HeiGui.HEI - heiGui.height) / 2 + 13;
			heiGui.filters = [new DropShadowFilter(4, 45, 0, .3, 4, 4, 1, 3)];
			
			trysGui = new TrysGui();
			addChild(trysGui);
			trysGui.x = 15;
			trysGui.y = HeiGui.HEI + 15 + (TrysGui.HEI - trysGui.height) / 2;
			trysGui.filters = [new DropShadowFilter(4, 45, 0, .3, 4, 4, 1, 3)];
			
			spawnGround.graphics.beginFill(0, .4);
			spawnGround.graphics.drawRect(spawnGui.x, spawnGui.y, SpawnGui.WID, SpawnGui.HEI);
			spawnGround.graphics.endFill();
			heiGround.graphics.beginFill(0, .4);
			heiGround.graphics.drawRect(10, 10, HeiGui.WID, HeiGui.HEI);
			heiGround.graphics.endFill();
			trysGround.graphics.beginFill(0, .4);
			trysGround.graphics.drawRect(10, HeiGui.HEI + 15, TrysGui.WID, TrysGui.HEI);
			trysGround.graphics.endFill();
		}
		public function step():void {
			heiGui.step();
		}
	}
}
