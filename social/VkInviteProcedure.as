package social {
	import vk.APIConnection;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class VkInviteProcedure {
		
		private var callback:Function;
		
		private var vk:APIConnection;
		
		public var onComplete:Function = null;
		
		public function VkInviteProcedure(_vk:APIConnection, _callback:Function) {
			callback = _callback;
			vk = _vk;
		}
		public function run():void {
			vk["addEventListener"]("onWindowFocus", afterBox);
			vk["callMethod"]("showInviteBox");
		}
		private function afterBox(e):void {
			vk["removeEventListener"]("onWindowFocus", afterBox);
			if (callback !== null)
				callback(new VkInviteAnswer(VkInviteAnswer.DONE));
			if (onComplete !== null) onComplete(this);
		}
	}
}
