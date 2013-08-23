package social {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class BestScoresGadget extends Sprite {
		static const WID:Number = 200;
		static const HEI:Number = 400;
		static const INDENT:Number = 10;
		static const LINE_INDENT:Number = 4;
		
		private var vkCore:VkCore;
		
		private var title:Bitmap;
		
		private var kittyLoading:CentrilizedBmd;
		
		private var lines:Vector.<BestScoresLine>;
		
		private var _i:int;
		
		public function BestScoresGadget(_vkCore:VkCore) {
			vkCore = _vkCore;
			title = new Bitmap(new BestScoresTitleBmd);
			addChild(title);
			title.x = title.y = INDENT;
			lines = new Vector.<BestScoresLine>;
			for (var i:int = 0; i < 5; i++ ) {
				var line:BestScoresLine = new BestScoresLine(WID - INDENT * 2, (HEI - (title.y + title.height + INDENT * 2) - 4 * LINE_INDENT) / 5);
				addChild(line);
				lines[i] = line;
				line.x = INDENT;
				line.y = title.y + title.height + INDENT + i * (line.hei + LINE_INDENT);
			}
			kittyLoading = new CentrilizedBmd(new GrumpyBmd, "auto", true, -29, -29);
			addChild(kittyLoading);
			kittyLoading.x = WID / 2;
			kittyLoading.y = HEI / 2;
			this.graphics.lineStyle(2, 0xffffff);
			this.graphics.drawRoundRect(0, 0, WID, HEI, 15, 15);
			Supreme.ioCore.getTopScores(vkCore.CurrentPlayerId, implementPrimaryInfo);
		}
		private function implementPrimaryInfo(_ans:IOGetScoresAnswer):void {
			removeChild(kittyLoading);
			kittyLoading = null;
			lines[0].implemetInfo(String(_ans.firstScore.vkId), _ans.firstScore.score, vkCore);
			lines[1].implemetInfo(String(_ans.secondScore.vkId), _ans.secondScore.score, vkCore);
			lines[2].implemetInfo(String(_ans.thirdScore.vkId), _ans.thirdScore.score, vkCore);
			lines[3].implemetInfo(String(_ans.fourthScore.vkId), _ans.fourthScore.score, vkCore);
			lines[4].implemetInfo(String(_ans.fifthScore.vkId), _ans.fifthScore.score, vkCore);
		}
		public function step():void {
			if (kittyLoading) kittyLoading.rotation += 1;
			for (_i = 0; _i < lines.length; _i++ )
				lines[_i].step();
		}
	}
}
