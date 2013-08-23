package game.factory.stencil {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class StencilTitle extends Sprite {
		
		static var charVariants:Vector.<StencilCharVariant>;
		
		public var chars:Vector.<StencilChar>;
		
		private var bms:Vector.<Bitmap>;
		
		private var text:String = null;
		
		private var _i:int;
		private var _j:int;
		private var _x:Number;
		private var _tempHei:Number;
		private var _tempBitmap:Bitmap;
		
		public function StencilTitle() {
			chars = new Vector.<StencilChar>;
			bms = new Vector.<Bitmap>;
		}
		public static function init():void {
			charVariants = new Vector.<StencilCharVariant>;
			
			//hei
			charVariants[charVariants.length] = new StencilCharVariant(0, "0", new GoldChar0Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "1", new GoldChar1Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "2", new GoldChar2Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "3", new GoldChar3Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "4", new GoldChar4Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "5", new GoldChar5Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "6", new GoldChar6Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "7", new GoldChar7Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "8", new GoldChar8Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "9", new GoldChar9Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, ".", new GoldCharDotBmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(0, "m", new GoldCharMBmd, 0);
			
			//tools
			charVariants[charVariants.length] = new StencilCharVariant(1, "0", new Char0Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "1", new Char1Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "2", new Char2Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "3", new Char3Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "4", new Char4Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "5", new Char5Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "6", new Char6Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "7", new Char7Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "8", new Char8Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "9", new Char9Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(1, "x", new CharXBmd, 0);
			
			//scores
			charVariants[charVariants.length] = new StencilCharVariant(2, "0", new ScoresChar0Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(2, "1", new ScoresChar1Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(2, "2", new ScoresChar2Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(2, "3", new ScoresChar3Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(2, "4", new ScoresChar4Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(2, "5", new ScoresChar5Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(2, "6", new ScoresChar6Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(2, "7", new ScoresChar7Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(2, "8", new ScoresChar8Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(2, "9", new ScoresChar9Bmd, 0);
			
			//scores gold
			charVariants[charVariants.length] = new StencilCharVariant(3, "0", new ScoresGchar0Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "1", new ScoresGchar1Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "2", new ScoresGchar2Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "3", new ScoresGchar3Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "4", new ScoresGchar4Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "5", new ScoresGchar5Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "6", new ScoresGchar6Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "7", new ScoresGchar7Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "8", new ScoresGchar8Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "9", new ScoresGchar9Bmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, ".", new ScoresGcharDotBmd, 0);
			charVariants[charVariants.length] = new StencilCharVariant(3, "m", new ScoresGcharMBmd, 0);
		}
		public static function getTitle(_charCode:int):StencilTitle {
			var out:StencilTitle = new StencilTitle();
			for (var i:int = 0; i < charVariants.length; i++ )
				if (charVariants[i].code == _charCode)
					out.chars[out.chars.length] = new StencilChar(charVariants[i].value, charVariants[i].bmd, charVariants[i].indent);
			return out;
		}
		private function buildText():void {
			for (_i = 0; _i < bms.length; _i++ )
				removeChild(bms[_i]);
			bms.splice(0, bms.length);
			_tempHei = 0;
			_x = 0;
			for (_i = 0; _i < text.length; _i++ )
				for (_j = 0 ; _j < chars.length; _j++ )
					if (chars[_j].value == text.charAt(_i)) {
						_tempBitmap = new Bitmap(chars[_j].bmd, "auto", true);
						addChild(_tempBitmap);
						if (_tempBitmap.height > _tempHei)
							_tempHei = _tempBitmap.height;
						_tempBitmap.x = _x;
						_x += _tempBitmap.width + chars[_j].indent;
						bms[bms.length] = _tempBitmap;
					}
			align(_tempHei);
			_tempBitmap = null;
		}
		private function align(_hei:Number):void {
			for (_i = 0; _i < bms.length; _i++ )
				bms[_i].y = (_hei - bms[_i].height) / 2;
		}
		public function set Text(value:String):void {
			if (value !== text) {
				text = value;
				buildText();
			}
		}
		public function get Text():String { return text; }
	}
}
