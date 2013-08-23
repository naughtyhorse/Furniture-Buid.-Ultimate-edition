package game.graphics {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class AnimationPack extends Sprite {
		
		private var animSheets:Object = { };
		
		private var bm:Bitmap;
		public var centralAlign:Boolean = true;
		
		private var currentSheet:AnimationSheet = null;
		private var currentName:String = null;
		private var currentFrame:int;
		private var currentReloading:Number = 0;
		private var speedMul:Number;
		private var intIterator:int;
		
		public var posX:Number = 0;
		public var posY:Number = 0;
		
		public var userTag:String = null;
		
		public var onAnimationEnd:Function = null;
		
		public function AnimationPack(_smooth:Boolean = true):void {
			init(_smooth);
		}
		private function init(_smooth:Boolean):void {
			bm = new Bitmap(null, "auto", _smooth);
			addChild(bm);
		}
		public function addAnimationSheet(_bmds:Vector.<BitmapData>, _name:String, _speed:Number = 2):void {
			var _sheet:AnimationSheet = new AnimationSheet(_bmds, _speed);
			animSheets[_name] = _sheet;
		}
		public function removeAnimationSheet(_name:String):void {
			if (currentName !== _name)
				animSheets[_name] = undefined;
		}
		public function initSheet():void {
			bm.bitmapData = currentSheet.bmds[0];
			currentFrame = 0;
			speedMul = currentSheet.speed / 60;
			if (centralAlign) {
				bm.x = -bm.bitmapData.width / 2;
				bm.y = -bm.bitmapData.height / 2
			} else {
				bm.x = posX;
				bm.y = posY;
			}
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
					bm.bitmapData = currentSheet.bmds[currentFrame];
					if (centralAlign) {
						bm.x = -bm.bitmapData.width / 2;
						bm.y = -bm.bitmapData.height / 2;
					} else {
						bm.x = posX;
						bm.y = posY;
					}
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
