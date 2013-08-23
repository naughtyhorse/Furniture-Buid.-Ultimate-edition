package game.managing {
	import flash.display.DisplayObject;
	import game.lays.AllObjectsLay;
	import game.lays.BackgroundLay;
	import game.lays.GfxLay;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class WorldMover {
		static const MAXIMUM_MOVE_SPEED:Number = 40;
		static const MOVE_EASING:Number = 2;
		static const MOVE_ACCELERATION:Number = .4;
		
		private var background:BackgroundLay;
		private var allObjectsLay:AllObjectsLay;
		private var gfxLay:GfxLay;
		
		public var upBtnOn:Boolean = false;
		public var downBtnOn:Boolean = false;
		
		private var targetMoveSpeed:Number;
		private var moveSpeed:Number = 0;
		
		public var upperMoveLimit:Number = 10000;
		
		private var _tempChild:DisplayObject;
		private var _tempDifference:Number;
		private var _i:int;
		
		public function WorldMover(_background:BackgroundLay, _allObjectsLay:AllObjectsLay, _gfxLay:GfxLay) {
			background = _background;
			allObjectsLay = _allObjectsLay;
			gfxLay = _gfxLay;
		}
		public function updateUpperLimit():void {
			upperMoveLimit = allObjectsLay.objects.height - allObjectsLay.stage.stageHeight * .5 - 204;
			if (upperMoveLimit < 0) upperMoveLimit = 0;
			if (allObjectsLay.y > upperMoveLimit) {
				allObjectsLay.y = upperMoveLimit;
				gfxLay.cont.y = allObjectsLay.y;
			}
			background.setUpperLimit(upperMoveLimit);
		}
		public function step():void {
			if (upBtnOn && !downBtnOn) {
				stepMoveSpeed();
				_tempDifference = allObjectsLay.y;
				allObjectsLay.y += moveSpeed;
				if (allObjectsLay.y > upperMoveLimit)
					allObjectsLay.y = upperMoveLimit;
				if (allObjectsLay.y < 0)
					allObjectsLay.y = 0;
				background.incrementScroll(allObjectsLay.y - _tempDifference);
				gfxLay.cont.y = allObjectsLay.y;
			} else if (downBtnOn && !upBtnOn) {
				stepMoveSpeed();
				_tempDifference = allObjectsLay.y;
				allObjectsLay.y -= moveSpeed;
				if (allObjectsLay.y < 0)
					allObjectsLay.y = 0;
				background.incrementScroll(allObjectsLay.y - _tempDifference);
				gfxLay.cont.y = allObjectsLay.y;
			} else moveSpeed = 0;
			stepVisible();
		}
		private function stepMoveSpeed():void {
			targetMoveSpeed = (MAXIMUM_MOVE_SPEED - moveSpeed) / MOVE_EASING;
			moveSpeed += MOVE_ACCELERATION;
			if (moveSpeed > targetMoveSpeed)
				moveSpeed = targetMoveSpeed;
		}
		private function stepVisible():void {
			for (_i = 0 ; _i < allObjectsLay.objects.numChildren; _i++ ) {
				_tempChild = allObjectsLay.objects.getChildAt(_i);
				_tempChild.visible = (_tempChild.y + _tempChild.height + allObjectsLay.y > 0 && _tempChild.y - _tempChild.height + allObjectsLay.y < allObjectsLay.stage.stageHeight);
			}
		}
	}
}
