package social {
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class VkGetInfoAnswer {
		public static const SUCCESS:String = "success";
		public static const ERROR:String = "error";
		
		public var type:String;
		
		public var targetId:String;
		
		public var fields:Vector.<String>;
		public var values:Vector.<String>;
		
		public function VkGetInfoAnswer(_type:String, _targetId:String, _fields:Vector.<String> = null, _values:Vector.<String> = null) {
			type = _type;
			targetId = _targetId;
			fields = _fields;
			values = _values;
		}
	}
}
