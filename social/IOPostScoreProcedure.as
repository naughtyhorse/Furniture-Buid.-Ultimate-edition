package social {
	import flash.display.Stage;
	import playerio.*;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class IOPostScoreProcedure {
		
		private var score:int;
		private var vkId:String;
		private var callback:Function;
		
		public var onComplete:Function = null;
		
		public function IOPostScoreProcedure(_score:int, _vkId:String, _callback:Function) {
			score = _score;
			vkId = _vkId;
			callback = _callback;
		}
		public function run(_stage:Stage):void {
			PlayerIO.connect(_stage, "furniture-build-vk-hxe4gjez5kivrm23mtua", "public", "vk" + vkId, null, null, connected, callError);
		}
		public function connected(_client:Client):void {
			//_client.multiplayer.developmentServer = "localhost:8184";
			_client.multiplayer.createJoinRoom(null, "FBScoreboard", false, { }, { cal:"post", id:String(vkId), hei:String(score) }, joined, callError);
		}
		private function joined(_con:Connection):void {
			_con.addMessageHandler("res", received);
		}
		private function received(_mes:Message):void {
			if (callback !== null) {
				if (_mes.getBoolean(0)) callback(new IOPostScoreAnswer(IOPostScoreAnswer.SUCCESS));
				else callback(new IOPostScoreAnswer(IOPostScoreAnswer.ERROR));
			}
			if (onComplete !== null) onComplete(this);
		}
		private function callError(er):void {
			if (callback !== null)
				callback(new IOPostScoreAnswer(IOPostScoreAnswer.ERROR));
			if (onComplete !== null) onComplete(this);
		}
	}
}
