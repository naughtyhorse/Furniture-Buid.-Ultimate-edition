package social {
	import flash.display.BitmapData;
	import flash.display.Stage;
	import vk.APIConnection;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class VkCore {
		
		private var vk:APIConnection;
		
		private var params:Object;
		
		private var procedures:Array = [];
		
		private var run:Boolean = false;
		
		public function VkCore(_stage:Stage) {
			params = _stage.loaderInfo.parameters
			vk = new APIConnection(params);
		}
		public function wallPost(_targetId:String, _message:String, _photoAttachments:Vector.<BitmapData>, _callback:Function):void {
			var _proc:VkWallPostProcedure = new VkWallPostProcedure(vk, _targetId, _message, _photoAttachments, _callback);
			procedures[procedures.length] = _proc;
			_proc.onComplete = disposeProcedure;
			queue();
		}
		public function getPersonalInfo(_targetId:String, _fields:Array, _callback:Function):void {
			var _proc:VkGetInfoPocedure = new VkGetInfoPocedure(vk, _targetId, _fields, _callback);
			procedures[procedures.length] = _proc;
			_proc.onComplete = disposeProcedure;
			queue();
		}
		public function inviteFriends(_callback:Function):void {
			var _proc:VkInviteProcedure = new VkInviteProcedure(vk, _callback);
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
					procedures[0].run();
				}
		}
		public function get CurrentPlayerId():String {
			return params["viewer_id"];
		}
	}
}
