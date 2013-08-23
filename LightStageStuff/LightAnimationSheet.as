package LightStageStuff {
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class LightAnimationSheet {
		public var bmds:Vector.<BitmapData>;
		public var speed:Number;
		
		public function LightAnimationSheet(_bmds:Vector.<BitmapData> = null, _speed:Number = 0):void {
			bmds = _bmds;
			speed = _speed;
		}
	}
}
