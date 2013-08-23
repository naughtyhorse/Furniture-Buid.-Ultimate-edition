package game.lays.objects {
	import com.mindgame.tweener.MFTween;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import game.factory.stencil.StencilTitle;
	import game.managing.BitmapStorage;
	import game.managing.Shaker;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class SpawnGui extends Sprite {
		public static const WID:Number = 225;
		public static const HEI:Number = 100;
		
		private var strip:Sprite;
		private var stripMask:Shape;
		
		private var furnitureCont:Sprite;
		private var glueCont:Sprite;
		private var bombCont:Sprite;
		private var ropeCont:Sprite;
		
		private var glueCounter:StencilTitle;
		private var bombCounter:StencilTitle;
		private var ropeCounter:StencilTitle;
		
		private var furnitureBm:Bitmap;
		
		private var leftArrowCont:Sprite;
		private var leftArrow:Bitmap;
		
		private var rightArrowCont:Sprite;
		private var rightArrow:Bitmap;
		
		public var onLeft:Function = null;
		public var onRight:Function = null;
		
		public function SpawnGui(_guiCrateBmd:BitmapData) {
			
			strip = new Sprite();
			addChild(strip);
			
			furnitureCont = new Sprite();
			strip.addChild(furnitureCont);
			
			furnitureBm = new Bitmap(_guiCrateBmd);
			furnitureCont.addChild(furnitureBm);
			furnitureBm.x = -furnitureBm.width / 2;
			var _furnitureHead:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("stencil", "hd_frntr"));
			furnitureCont.addChild(_furnitureHead);
			_furnitureHead.x = -_furnitureHead.width / 2;
			furnitureCont.x = 50;
			
			glueCont = new Sprite();
			strip.addChild(glueCont);
			
			var _glueBm:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("gui_obj", "glue"));
			glueCont.addChild(_glueBm);
			_glueBm.x = -_glueBm.width / 2;
			var _glueHead:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("stencil", "hd_glue"));
			glueCont.addChild(_glueHead);
			_glueHead.x = -_glueHead.width / 2;
			glueCont.x = 150;
			glueCounter = StencilTitle.getTitle(1);
			glueCounter.Text = "x1";
			glueCont.addChild(glueCounter);
			glueCounter.x = -glueCounter.width / 2;
			glueCounter.y = _glueBm.height - glueCounter.height;
			
			bombCont = new Sprite();
			strip.addChild(bombCont);
			
			var _bombBm:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("gui_obj", "bomb"));
			bombCont.addChild(_bombBm);
			_bombBm.x = -_bombBm.width / 2;
			var _bombHead:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("stencil", "hd_bomb"));
			bombCont.addChild(_bombHead);
			_bombHead.x = -_bombHead.width / 2;
			bombCont.x = 250;
			bombCounter = StencilTitle.getTitle(1);
			bombCounter.Text = "x1";
			bombCont.addChild(bombCounter);
			bombCounter.x = -bombCounter.width / 2;
			bombCounter.y = _bombBm.height - bombCounter.height;
			
			ropeCont = new Sprite();
			strip.addChild(ropeCont);
			
			var _ropeBm:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("gui_obj", "rope"));
			ropeCont.addChild(_ropeBm);
			_ropeBm.x = -_ropeBm.width / 2;
			var _ropeHead:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("stencil", "hd_rope"));
			ropeCont.addChild(_ropeHead);
			_ropeHead.x = -_ropeHead.width / 2;
			ropeCont.x = 350;
			ropeCounter = StencilTitle.getTitle(1);
			ropeCounter.Text = "x1";
			ropeCont.addChild(ropeCounter);
			ropeCounter.x = -ropeCounter.width / 2;
			ropeCounter.y = _ropeBm.height - ropeCounter.height;
			
			stripMask = new Shape();
			addChild(stripMask);
			stripMask.graphics.beginFill(0);
			stripMask.graphics.drawRect(0, 0, 100, 75);
			stripMask.graphics.endFill();
			strip.mask = stripMask;
			
			stripMask.x = (WID - stripMask.width) / 2;
			stripMask.y = (HEI - stripMask.height) / 2;
			
			strip.x = WID / 2 - 50;
			strip.y = (HEI - strip.height) / 2;
			
			leftArrowCont = new Sprite();
			addChild(leftArrowCont);
			leftArrow = new Bitmap(BitmapStorage.staticGetBitmap("gui", "l_ar"));
			leftArrowCont.addChild(leftArrow);
			leftArrowCont.buttonMode = true;
			leftArrowCont.x = 10;
			leftArrowCont.y = (HEI - leftArrowCont.height) / 2;
			leftArrowCont.addEventListener(MouseEvent.CLICK, function():void { if (onLeft !== null) onLeft(); } );
			
			rightArrowCont = new Sprite();
			addChild(rightArrowCont);
			rightArrow = new Bitmap(BitmapStorage.staticGetBitmap("gui", "r_ar"));
			rightArrowCont.addChild(rightArrow);
			rightArrowCont.buttonMode = true;
			rightArrowCont.x = WID - rightArrowCont.width - 10;
			rightArrowCont.y = (HEI - rightArrowCont.height) / 2;
			rightArrowCont.addEventListener(MouseEvent.CLICK, function():void { if (onRight !== null) onRight(); } );
		}
		public function setGuiCrateBmd(_guiCrateBmd:BitmapData):void {
			furnitureBm.bitmapData = _guiCrateBmd;
			furnitureBm.x = -furnitureBm.width / 2;
		}
		public function set GlueCount(value:int):void {
			glueCounter.Text = "x" + value;
			glueCounter.x = -glueCounter.width / 2;
			Shaker.staticAddShake(glueCounter, 2, .5);
		}
		public function set BombCount(value:int):void {
			bombCounter.Text = "x" + value;
			bombCounter.x = -bombCounter.width / 2;
			Shaker.staticAddShake(bombCounter, 2, .5);
		}
		public function set RopeCount(value:int):void {
			ropeCounter.Text = "x" + value;
			ropeCounter.x = -ropeCounter.width / 2;
			Shaker.staticAddShake(ropeCounter, 2, .5);
		}
		public function onFurniture():void {
			MFTween.tween(strip, .25, { x:WID / 2 - 50 } );
		}
		public function onGlue():void {
			MFTween.tween(strip, .25, { x:WID / 2 - 150 } );
		}
		public function onBomb():void {
			MFTween.tween(strip, .25, { x:WID / 2 - 250 } );
		}
		public function onRope():void {
			MFTween.tween(strip, .25, { x:WID / 2 - 350 } );
		}
	}
}
