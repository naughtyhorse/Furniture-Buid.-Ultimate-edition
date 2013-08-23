package LightStageStuff {
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public class LightObject extends LightDisplayContainer {
		public var centerXDeviation:Boolean = false;
		private var centerX:Number = 0;
		public var centerYDeviation:Boolean = false;
		private var centerY:Number = 0;
		public var centrilised:Boolean = false;
		
		public var redOffset:Number = 0;
		public var greenOffset:Number = 0;
		public var blueOffset:Number = 0;
		
		public var smoothing:String = "auto";
		
		public var bitmapData:BitmapData;
		
		public function LightObject(_bitmapData:BitmapData = null):void {
			bitmapData = _bitmapData;
			super();
		}
		public function set CenterX(value:Number):void {
			centerX = -value;
			centerXDeviation = (centerX !== 0);
		}
		public function set CenterY(value:Number):void {
			centerY = -value;
			centerYDeviation = (centerY !== 0);
		}
		public function get CenterX():Number { return centerX; }
		public function get CenterY():Number { return centerY; }
		public function get Width():Number {
			if (bitmapData) {
				return bitmapData.width * Scale;
			} else return 0;
		}
		public function get Height():Number {
			if (bitmapData) {
				return bitmapData.height * Scale;
			} else return 0;
		}
	}
}
