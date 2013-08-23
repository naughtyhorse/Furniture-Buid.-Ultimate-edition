package game.factory.stencil {
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class StencilCharVariant {
		
		public var code:int;
		public var value:String;
		
		public var bmd:BitmapData;
		public var indent:Number;
		
		public function StencilCharVariant(_code:int, _value:String, _bmd:BitmapData, _indent:Number):void {
			code = _code;
			value = _value;
			bmd = _bmd;
			indent = _indent;
		}
	}
}
