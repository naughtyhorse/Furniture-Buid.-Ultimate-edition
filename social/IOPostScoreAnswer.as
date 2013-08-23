package social {
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class IOPostScoreAnswer {
		public static const SUCCESS:String = "success";
		public static const ERROR:String = "error";
		
		public var type:String;
		
		public function IOPostScoreAnswer(_type:String) {
			type = _type;
		}
	}
}
