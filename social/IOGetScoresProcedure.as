package social {
	import flash.display.Stage;
	import playerio.*;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class IOGetScoresProcedure {
		
		private var callback:Function;
		private var vkId:String;
		
		public var onComplete:Function = null;
		
		private var disposed:Boolean = false;
		
		private var _firstScore:IOScoreEntry;
		private var _secondScore:IOScoreEntry;
		private var _thirdScore:IOScoreEntry;
		private var _fourthScore:IOScoreEntry;
		private var _fifthScore:IOScoreEntry;
		
		public function IOGetScoresProcedure(_vkId:String, _callback:Function) {
			vkId = _vkId;
			callback = _callback;
		}
		public function run(_stage:Stage):void {
			PlayerIO.connect(_stage, "furniture-build-vk-hxe4gjez5kivrm23mtua", "public", "vk" + vkId, null, null, connected, callError);
		}
		public function connected(_client:Client):void {
			_client.multiplayer.developmentServer = "localhost:8184";
			_client.bigDB.load("Scores", "scr_1", scoreLoaded, scoreError);
			_client.bigDB.load("Scores", "scr_2", scoreLoaded, scoreError);
			_client.bigDB.load("Scores", "scr_3", scoreLoaded, scoreError);
			_client.bigDB.load("Scores", "scr_4", scoreLoaded, scoreError);
			_client.bigDB.load("Scores", "scr_5", scoreLoaded, scoreError);
		}
		private function scoreLoaded(_obj:DatabaseObject):void {
			if (disposed) return;
			switch(_obj.key) {
				case "scr_1": _firstScore = new IOScoreEntry(_obj["vkid"], _obj["hei"] / 10); break;
				case "scr_2": _secondScore = new IOScoreEntry(_obj["vkid"], _obj["hei"] / 10); break;
				case "scr_3": _thirdScore = new IOScoreEntry(_obj["vkid"], _obj["hei"] / 10); break;
				case "scr_4": _fourthScore = new IOScoreEntry(_obj["vkid"], _obj["hei"] / 10); break;
				case "scr_5": _fifthScore = new IOScoreEntry(_obj["vkid"], _obj["hei"] / 10); break;
			}
			if (_firstScore && _secondScore && _thirdScore && _fourthScore && _fifthScore) {
				if (callback !== null)
					callback(new IOGetScoresAnswer(IOGetScoresAnswer.SUCCESS, _firstScore, _secondScore, _thirdScore, _fourthScore, _fifthScore));
				if (onComplete !== null) onComplete(this);
			}
		}
		private function scoreError(er):void {
			disposed = true;
			if (callback !== null)
				callback(new IOGetScoresAnswer(IOGetScoresAnswer.ERROR));
			if (onComplete !== null) onComplete(this);
		}
		private function callError(er):void {
			if (callback !== null)
				callback(new IOGetScoresAnswer(IOGetScoresAnswer.ERROR));
			if (onComplete !== null) onComplete(this);
		}
	}
}
