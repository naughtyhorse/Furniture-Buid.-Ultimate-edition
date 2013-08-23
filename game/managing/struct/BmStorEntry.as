package game.managing.struct {
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class BmStorEntry {
		
		public var head:String;
		public var bitmap:BitmapData;
		
		public function BmStorEntry(_head:String, _bitmap:BitmapData) {
			head = _head;
			bitmap = _bitmap;
		}
	}
}
