package social {
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class VkWallPostAnswer {
		public static const PROGRESS:String = "progress";
		public static const ERROR:String = "error";
		public static const PHOTO_UPLOADED:String = "puploaded";
		public static const SUCCESS:String = "success";
		
		public var type:String;
		
		public var leftPhotosCount:int;
		public var bytesLoaded:Number;
		public var bytesTotal:Number;
		
		public var wallPostId:String;
		
		public function VkWallPostAnswer(_type:String, _bytesLoaded:Number = 0, _bytesTotal:Number = 0, _leftPhotosCount:int = 0, _wallPostId:String = null) {
			type = _type;
			bytesLoaded = _bytesLoaded;
			bytesTotal = _bytesTotal;
			leftPhotosCount = _leftPhotosCount;
			wallPostId = _wallPostId;
		}
	}
}
