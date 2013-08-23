package game.lays {
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class AllObjectsLay extends Sprite {
		
		public var back:Sprite;
		public var objects:Sprite;
		public var signs:Sprite;
		public var ropes:Sprite;
		
		public function AllObjectsLay(_wid:Number, _hei:Number) {
			back = new Sprite();
			addChild(back);
			objects = new Sprite();
			addChild(objects);
			objects.filters = [new DropShadowFilter(7, 45, 0, .5, 4, 4, 1, 3)];
			ropes = new Sprite();
			addChild(ropes);
			signs = new Sprite();
			addChild(signs);
		}
	}
}
