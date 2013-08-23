package social {
	import vk.APIConnection;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class VkGetInfoPocedure {
		
		private var vk:APIConnection;
		private var targetId:String;
		private var fields:Array;
		private var callback:Function;
		
		public var onComplete:Function = null;
		
		public function VkGetInfoPocedure(_vk:APIConnection, _targetId:String, _fields:Array, _callback:Function) {
			vk = _vk;
			targetId = _targetId;
			fields = _fields;
			callback = _callback;
		}
		public function run():void {
			vk["api"]("users.get", { uids:targetId, fields:fields }, getInfoAnswer, callError);
		}
		private function getInfoAnswer(_ans):void {
			if (callback !== null) {
				var _flds:Vector.<String> = new Vector.<String>;
				var _values:Vector.<String> = new Vector.<String>;
				for (var s in _ans[0]) {
					_flds[_flds.length] = s;
					_values[_values.length] = _ans[0][s];
				}
				callback(new VkGetInfoAnswer(VkGetInfoAnswer.SUCCESS, targetId, _flds, _values));
			}
			if (onComplete !== null) onComplete(this);
		}
		private function callError(er):void {
			if (callback !== null)
				callback(new VkGetInfoAnswer(VkGetInfoAnswer.ERROR, targetId));
			if (onComplete !== null) onComplete(this);
		}
	}
}
