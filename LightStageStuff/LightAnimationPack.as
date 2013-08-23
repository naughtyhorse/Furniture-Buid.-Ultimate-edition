package LightStageStuff {
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class LightAnimationPack extends LightObject {
		private var animSheets:Object = { };
		
		private var currentSheet:LightAnimationSheet = null;
		private var currentName:String = null;
		private var currentFrame:int;
		private var currentReloading:Number = 0;
		private var speedMul:Number;
		private var intIterator:int;
		
		public var userTag:String = null;
		
		public var onAnimationEnd:Function = null;
		
		public function LightAnimationPack():void {
			super();
		}
		public function addAnimationSheet(_bmds:Vector.<BitmapData>, _name:String, _speed:Number = 25):void {
			var _sheet:LightAnimationSheet = new LightAnimationSheet(_bmds, _speed);
			animSheets[_name] = _sheet;
		}
		public function removeAnimationSheet(_name:String):void {
			if (currentName !== _name)
				animSheets[_name] = undefined;
		}
		public function initSheet():void {
			this.bitmapData = currentSheet.bmds[0];
			currentFrame = 0;
			speedMul = currentSheet.speed / 60;
		}
		public function step():void {
			if (currentSheet) {
				currentReloading += speedMul;
				if (currentReloading >= 1) {
					intIterator = int(currentReloading);
					currentFrame += intIterator;
					currentReloading -= intIterator;
					if (currentFrame > currentSheet.bmds.length - 1) {
						currentFrame -= (currentSheet.bmds.length);
						if (onAnimationEnd !== null) onAnimationEnd(this);
					}
					this.bitmapData = currentSheet.bmds[currentFrame];
				}
			}
		}
		public function set CurrentSheet(value:String):void {
			if (animSheets[value]) if (animSheets[value].bmds.length > 0) {
				currentSheet = animSheets[value];
				currentName = value;
				initSheet();
			}
		}
		public function set CurrentSheetSpeed(value:Number):void {
			if (currentSheet) {
				currentSheet.speed = value;
				speedMul = currentSheet.speed / 60;
			}
		}
		public function get CurrentSheet():String { return currentName; }
	}
}
