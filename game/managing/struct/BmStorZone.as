package game.managing.struct {
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class BmStorZone {
		
		public var head:String;
		public var entry:Vector.<BmStorEntry>;
		
		public function BmStorZone(_head:String) {
			head = _head;
			entry = new Vector.<BmStorEntry>;
		}
	}
}
