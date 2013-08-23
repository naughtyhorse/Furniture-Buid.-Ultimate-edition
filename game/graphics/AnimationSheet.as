package game.graphics {
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class AnimationSheet {
		public var bmds:Vector.<BitmapData>;
		public var speed:Number;
		
		public function AnimationSheet(_bmds:Vector.<BitmapData> = null, _speed:Number = 0):void {
			bmds = _bmds;
			speed = _speed;
		}
	}
}
