package game.factory {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class ExchangeScreen extends Sprite {
		static const MODES:Vector.<String> = new < String > ["T", "B", "L", "R"];
		static const EXCHANGE_SPEED:Number = 40;
		
		private var prevDO:DisplayObject;
		private var prevDOMask:Shape;
		
		private var nextDO:DisplayObject;
		private var nextDOMask:Shape;
		
		private var callback:Function;
		
		private var mode:String;
		
		public function ExchangeScreen(_parent:DisplayObjectContainer, _prevDO:DisplayObject, _nextDO:DisplayObject, _callback:Function) {
			prevDO = _prevDO;
			nextDO = _nextDO;
			callback = _callback;
			_parent.addChild(this);
			mode = MODES[Math.floor(Math.random() * MODES.length)];
			run();
		}
		private function run():void {
			addChild(prevDO);
			addChild(nextDO);
			prevDOMask = new Shape();
			addChild(prevDOMask);
			prevDOMask.graphics.beginFill(0);
			prevDOMask.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			prevDOMask.graphics.endFill();
			prevDO.mask = prevDOMask;
			nextDOMask = new Shape();
			addChild(nextDOMask);
			nextDOMask.graphics.beginFill(0);
			nextDOMask.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			nextDOMask.graphics.endFill();
			nextDO.mask = nextDOMask;
			switch(mode) {
				case "T": nextDO.y = nextDOMask.y = -stage.stageHeight; break;
				case "B": nextDO.y = nextDOMask.y = stage.stageHeight; break;
				case "L": nextDO.x = nextDOMask.x = -stage.stageWidth; break;
				case "R": nextDO.x = nextDOMask.x = stage.stageWidth; break;
			}
		}
		public function step():Boolean {
			switch(mode) {
				case "T":
					prevDO.y += EXCHANGE_SPEED;
					nextDO.y += EXCHANGE_SPEED;
					prevDOMask.y += EXCHANGE_SPEED;
					nextDOMask.y += EXCHANGE_SPEED;
					if (nextDO.y >= 0) {
						nextDO.y = 0;
						removeChild(prevDO);
						prevDO.mask = null;
						nextDO.mask = null;
						if (callback !== null) callback();
						return true;
					} else return false;
				case "B":
					prevDO.y -= EXCHANGE_SPEED;
					nextDO.y -= EXCHANGE_SPEED;
					prevDOMask.y -= EXCHANGE_SPEED;
					nextDOMask.y -= EXCHANGE_SPEED;
					if (nextDO.y <= 0) {
						nextDO.y = 0;
						removeChild(prevDO);
						prevDO.mask = null;
						nextDO.mask = null;
						if (callback !== null) callback();
						return true;
					} else return false;
				case "L":
					prevDO.x += EXCHANGE_SPEED;
					nextDO.x += EXCHANGE_SPEED;
					prevDOMask.x += EXCHANGE_SPEED;
					nextDOMask.x += EXCHANGE_SPEED;
					if (nextDO.x >= 0) {
						nextDO.x = 0;
						removeChild(prevDO);
						prevDO.mask = null;
						nextDO.mask = null;
						if (callback !== null) callback();
						return true;
					} else return false;
				case "R":
					prevDO.x -= EXCHANGE_SPEED;
					nextDO.x -= EXCHANGE_SPEED;
					prevDOMask.x -= EXCHANGE_SPEED;
					nextDOMask.x -= EXCHANGE_SPEED;
					if (nextDO.x <= 0) {
						nextDO.x = 0;
						removeChild(prevDO);
						prevDO.mask = null;
						nextDO.mask = null;
						if (callback !== null) callback();
						return true;
					} else return false;
				default: return true;
			}
		}
	}
}
