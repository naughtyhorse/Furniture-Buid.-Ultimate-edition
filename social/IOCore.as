package social {
	import flash.display.Stage;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class IOCore {
		
		private var stage:Stage;
		
		private var procedures:Array = [];
		
		private var run:Boolean = false;
		
		public function IOCore(_stage:Stage) {
			stage = _stage;
		}
		public function postHei(_hei:int, _vkId:String, _callback:Function):void {
			var _proc:IOPostScoreProcedure = new IOPostScoreProcedure(_hei, _vkId, _callback);
			procedures[procedures.length] = _proc;
			_proc.onComplete = disposeProcedure;
			queue();
		}
		public function getTopScores(_vkId:String, _callback:Function):void {
			var _proc:IOGetScoresProcedure = new IOGetScoresProcedure(_vkId, _callback);
			procedures[procedures.length] = _proc;
			_proc.onComplete = disposeProcedure;
			queue();
		}
		private function disposeProcedure(_proc):void {
			for (var i:int = 0; i < procedures.length; i++ )
				if (procedures[i] == _proc) {
					procedures.splice(i, 1);
					run = false;
					queue();
					return;
				}
		}
		private function queue():void {
			if (!run)
				if (procedures.length > 0) {
					run = true;
					procedures[0].run(stage);
				}
		}
	}
}
