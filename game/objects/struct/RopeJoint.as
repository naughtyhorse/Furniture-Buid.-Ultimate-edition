package game.objects.struct {
	import nape.constraint.DistanceJoint;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class RopeJoint {
		
		public var index1:int;
		public var index2:int;
		
		public var joint:DistanceJoint;
		
		public function RopeJoint(_index1:int, _index2:int, _joint:DistanceJoint) {
			index1 = _index1;
			index2 = _index2;
			joint = _joint;
		}
	}
}
