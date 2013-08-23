package game.factory.struct {
	import nape.geom.Vec2;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class CrateVariantPolygon {
		public static const TYPE_RECTANGLE:String = "tr";
		public static const TYPE_CIRCLE:String = "tc";
		public static const TYPE_CUSTOM:String = "tcu";
		
		public var type:String;
		
		public var x:Number;
		public var y:Number;
		
		public var width:Number;
		public var height:Number;
		
		public var radius:Number;
		
		public var vertex:Vector.<Vec2>;
		
		public function CrateVariantPolygon(_type:String, _x:Number, _y:Number) {
			type = _type;
			x = _x;
			y = _y;
		}
	}
}
