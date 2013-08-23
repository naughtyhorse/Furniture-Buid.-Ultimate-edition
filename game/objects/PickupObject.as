package game.objects {
	import flash.display.Sprite;
	import nape.phys.Body;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class PickupObject {
		public static const TOOL_TYPE_GLUE:int = 1;
		public static const TOOL_TYPE_BOMB:int = 2;
		public static const TOOL_TYPE_ROPE:int = 3;
		public static const TOOL_TYPE_HEART:int = 4;
		
		static const ROTATION_SPEED_1:Number = -1.6;
		static const ROTATION_SPEED_2:Number = .8;
		
		static const MINIMUM_LOGO_SCALE:Number = .9;
		static const MAXIMUM_LOGO_SCALE:Number = 1.1;
		static const LOGO_SCALE_INCREMENT:Number = .003;
		
		private var redFlash:Sprite;
		private var yellowFlash:Sprite;
		
		public var tool:Sprite;
		
		public var toolType:int;
		
		private var logoScaleTrigger:Boolean = true;
		
		public function PickupObject(_redFlash:Sprite, _yellowFlash:Sprite, _tool:Sprite) {
			redFlash = _redFlash;
			yellowFlash = _yellowFlash;
			tool = _tool;
		}
		public function dispose():void {
			redFlash.parent.removeChild(redFlash);
			yellowFlash.parent.removeChild(yellowFlash);
			tool.parent.removeChild(tool);
		}
		public function step():void {
			yellowFlash.rotation += ROTATION_SPEED_1;
			redFlash.rotation += ROTATION_SPEED_2;
			if (logoScaleTrigger) {
				tool.scaleX += LOGO_SCALE_INCREMENT;
				if (tool.scaleX >= MAXIMUM_LOGO_SCALE) {
					tool.scaleX = MAXIMUM_LOGO_SCALE;
					logoScaleTrigger = false;
				}
			} else {
				tool.scaleX -= LOGO_SCALE_INCREMENT;
				if (tool.scaleX <= MINIMUM_LOGO_SCALE) {
					tool.scaleX = MINIMUM_LOGO_SCALE;
					logoScaleTrigger = true;
				}
			}
			tool.scaleY = tool.scaleX;
		}
	}
}
