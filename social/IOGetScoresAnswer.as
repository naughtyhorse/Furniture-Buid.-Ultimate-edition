package social {
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class IOGetScoresAnswer {
		public static const SUCCESS:String = "success";
		public static const ERROR:String = "error";
		
		public var type:String;
		
		public var firstScore:IOScoreEntry;
		public var secondScore:IOScoreEntry;
		public var thirdScore:IOScoreEntry;
		public var fourthScore:IOScoreEntry;
		public var fifthScore:IOScoreEntry;
		
		public function IOGetScoresAnswer(_type:String, _firstScore:IOScoreEntry = null,
														_secondScore:IOScoreEntry = null,
														_thirdScore:IOScoreEntry = null,
														_fourthScore:IOScoreEntry = null,
														_fifthScore:IOScoreEntry = null) {
			type = _type;
			firstScore = _firstScore;
			secondScore = _secondScore;
			thirdScore = _thirdScore;
			fourthScore = _fourthScore;
			fifthScore = _fifthScore;
		}
	}
}
