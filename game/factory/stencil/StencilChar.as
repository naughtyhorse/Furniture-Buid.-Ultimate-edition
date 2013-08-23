package game.factory.stencil {
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class StencilChar {
		
		public var value:String;
		public var bmd:BitmapData;
		public var indent:Number;
		
		public function StencilChar(_value:String, _bmd:BitmapData, _indent:Number):void {
			value = _value;
			bmd = _bmd;
			indent = _indent;
		}
	}
}
