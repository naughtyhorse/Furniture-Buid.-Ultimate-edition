package game.factory.struct {
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class CrateVariant {
		
		public var bitmapData:BitmapData;
		public var bitmapDataGui:BitmapData;
		
		public var centerDeviantX:Number;
		public var centerDeviantY:Number;
		
		public var spawnChance:int;
		
		public var polygons:Vector.<CrateVariantPolygon>;
		
		public function CrateVariant(_centerDeviantX:Number, _centerDeviantY:Number, _bitmapData:BitmapData, _bitmapDataGui:BitmapData, _spawnChance:int = 100) {
			bitmapData = _bitmapData;
			bitmapDataGui = _bitmapDataGui;
			centerDeviantX = _centerDeviantX;
			centerDeviantY = _centerDeviantY;
			spawnChance = _spawnChance;
			polygons = new Vector.<CrateVariantPolygon>;
		}
	}
}
