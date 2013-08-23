package game.objects {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import game.factory.CubicBezier;
	import game.factory.MathStuff;
	import game.graphics.CentrilizedBmd;
	import game.managing.BitmapStorage;
	import game.objects.struct.RopeJoint;
	import nape.callbacks.CbType;
	import nape.constraint.DistanceJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class RopeObject {
		public static const MAX_ROPE_LENGTH:Number = 225;
		static const LINK_WID:Number = 18;
		static const LINK_HEI:Number = 4;
		static const LINK_DEPTH:Number = 2;
		
		public var beginPipeGrphcs:CentrilizedBmd;
		public var endPipeGrphcs:CentrilizedBmd;
		public var circle:Shape;
		
		public var targetBody1:Body;
		public var targetBody2:Body;
		
		private var links:Vector.<Body>;
		private var linkJoints:Vector.<RopeJoint>;
		private var body1Joints:Vector.<DistanceJoint>;
		private var body2Joints:Vector.<DistanceJoint>;
		private var body1StoneJoints:Vector.<DistanceJoint>;
		private var body2StoneJoints:Vector.<DistanceJoint>;
		private var anchs:Array;
		
		public var ropeLay:Shape;
		
		private var phase:int = 0;
		
		private var _i:int;
		private var _tempPnt1:Point = new Point();
		private var _tempPnt2:Point;
		private var _btFlag:Boolean = false;
		
		public function RopeObject() {
			beginPipeGrphcs = new CentrilizedBmd(BitmapStorage.staticGetBitmap("tls", "pipe"));
		}
		public function reifyBegining(_signsCont:Sprite, _objContScroll:Number, _targetBody:Body):void {
			phase = 1;
			endPipeGrphcs = new CentrilizedBmd(BitmapStorage.staticGetBitmap("tls", "pipe"));
			endPipeGrphcs.alpha = .5;
			circle = new Shape();
			_signsCont.addChild(circle);
			circle.graphics.beginFill(0xffffff, .2);
			circle.graphics.drawCircle(0, 0, MAX_ROPE_LENGTH);
			circle.graphics.endFill();
			_tempPnt2 = beginPipeGrphcs.localToGlobal(_tempPnt1);
			circle.x = _tempPnt2.x;
			circle.y = _tempPnt2.y + _objContScroll;
			targetBody1 = _targetBody;
		}
		public function reifyEnding(_targetBody:Body):Boolean {
			var _p1:Point = beginPipeGrphcs.localToGlobal(new Point());
			var _p2:Point = endPipeGrphcs.localToGlobal(new Point());
			if (circle) {
				circle.parent.removeChild(circle);
				circle = null;
			}
			if (MathStuff.getDistance(_p1.x, _p1.y, _p2.x, _p2.y) <= MAX_ROPE_LENGTH && _targetBody !== targetBody1) {
				targetBody2 = _targetBody;
				return true;
			} else {
				dropPipe();
				return false;
			}
		}
		public function initRope(_cb:CbType, _ghostCb:CbType):void {
			endPipeGrphcs.alpha = 1;
			phase = 2;
			links = new Vector.<Body>;
			linkJoints = new Vector.<RopeJoint>;
			body1Joints = new Vector.<DistanceJoint>;
			body2Joints = new Vector.<DistanceJoint>;
			anchs = [];
			
			var _p1:Point = beginPipeGrphcs.localToGlobal(new Point());
			var _p2:Point = endPipeGrphcs.localToGlobal(new Point());
			
			var i:int;
			var j:int;
			var m:Material = Material.ice();
			for (i = 0; i < MathStuff.getDistance(_p1.x, _p1.y, _p2.x, _p2.y) / (LINK_WID - LINK_DEPTH * 2); i++ ) {
				var b:Body = new Body(BodyType.DYNAMIC);
				b.shapes.add(new Polygon(Polygon.rect(targetBody1.position.x, targetBody1.position.y, LINK_WID, LINK_HEI), m));
				b.cbTypes.add(_cb);
				links[i] = b;
				anchs[i] = new Point();
				b.align();
				b.space = targetBody1.space;
			}
			
			var anch1:Vec2 = Vec2.get(LINK_WID / 2 - LINK_DEPTH);
			var anch2:Vec2 = Vec2.get(LINK_DEPTH - LINK_WID / 2);
			for (i = 0 ; i < links.length - 1; i++ )
				for (j = i + 1; j < links.length; j++ ) {
					var dj:DistanceJoint = new DistanceJoint(links[i], links[j], anch2, anch1, 0, 1 + (j - i - 1) * (LINK_WID - LINK_DEPTH * 2));
					dj.ignore = true;
					dj.space = targetBody1.space;
					linkJoints[linkJoints.length] = new RopeJoint(i, j, dj);
				}
			for (i = links.length - 1; i >= 0; i-- ) {
				var dj:DistanceJoint = new DistanceJoint(targetBody1, links[i], Vec2.get(beginPipeGrphcs.x, beginPipeGrphcs.y), anch1, 0, 1 + i * (LINK_WID - LINK_DEPTH * 2));
				dj.ignore = true;
				dj.space = targetBody1.space;
				body1Joints[body1Joints.length] = dj;
			}
			for (i = 0 ; i < links.length; i++ ) {
				var dj:DistanceJoint = new DistanceJoint(targetBody2, links[i], Vec2.get(endPipeGrphcs.x, endPipeGrphcs.y), anch2, 0, 1 + (links.length - i - 1) * (LINK_WID - LINK_DEPTH * 2));
				dj.ignore = true;
				dj.space = targetBody2.space;
				body2Joints[body2Joints.length] = dj;
			}
			if ((targetBody1.userData[0] as CrateObject).stoned || (targetBody2.userData[0] as CrateObject).stoned) {
				var _stp:Point = beginPipeGrphcs.parent.parent.globalToLocal(beginPipeGrphcs.parent.localToGlobal(new Point(beginPipeGrphcs.x, beginPipeGrphcs.y)));
				var _stvec1:Vec2 = Vec2.get(_stp.x, _stp.y);
				_stp = endPipeGrphcs.parent.parent.globalToLocal(endPipeGrphcs.parent.localToGlobal(new Point(endPipeGrphcs.x, endPipeGrphcs.y)));
				var _stvec2:Vec2 = Vec2.get(_stp.x, _stp.y);
				if ((targetBody1.userData[0] as CrateObject).stoned) {
					body1StoneJoints = new Vector.<DistanceJoint>;
					for (i = links.length - 1; i >= 0; i-- ) {
						var dj:DistanceJoint = new DistanceJoint(targetBody1.space.world, links[i], _stvec1, anch1, 0, 1 + i * (LINK_WID - LINK_DEPTH * 2));
						dj.ignore = true;
						dj.space = targetBody1.space;
						body1StoneJoints[body1StoneJoints.length] = dj;
					}
					var dj:DistanceJoint = new DistanceJoint(targetBody1.space.world, targetBody2, _stvec1, Vec2.get(beginPipeGrphcs.x, beginPipeGrphcs.y), 0, links.length * LINK_WID);
					dj.ignore = true;
					dj.space = targetBody1.space;
					body1StoneJoints[body1StoneJoints.length] = dj;
				}
				if ((targetBody2.userData[0] as CrateObject).stoned) {
					body2StoneJoints = new Vector.<DistanceJoint>;
					for (i = 0 ; i < links.length; i++ ) {
						var dj:DistanceJoint = new DistanceJoint(targetBody2.space.world, links[i], _stvec2, anch2, 0, 1 + (links.length - i - 1) * (LINK_WID - LINK_DEPTH * 2));
						dj.ignore = true;
						dj.space = targetBody2.space;
						body2StoneJoints[body2StoneJoints.length] = dj;
					}
					var dj:DistanceJoint = new DistanceJoint(targetBody2.space.world, targetBody1, _stvec2, Vec2.get(endPipeGrphcs.x, endPipeGrphcs.y), 0, links.length * LINK_WID);
					dj.ignore = true;
					dj.space = targetBody2.space;
					body2StoneJoints[body2StoneJoints.length] = dj;
				}
			}
			targetBody1.allowMovement = false;
			targetBody2.allowMovement = false;
		}
		public function stoneTargetBody(_body:Body):void {
			var i:int;
			var anch1:Vec2 = Vec2.get(LINK_WID / 2 - LINK_DEPTH);
			var anch2:Vec2 = Vec2.get(LINK_DEPTH - LINK_WID / 2);
			var _stp:Point = beginPipeGrphcs.parent.parent.globalToLocal(beginPipeGrphcs.parent.localToGlobal(new Point(beginPipeGrphcs.x, beginPipeGrphcs.y)));
			var _stvec1:Vec2 = Vec2.get(_stp.x, _stp.y);
			_stp = endPipeGrphcs.parent.parent.globalToLocal(endPipeGrphcs.parent.localToGlobal(new Point(endPipeGrphcs.x, endPipeGrphcs.y)));
			var _stvec2:Vec2 = Vec2.get(_stp.x, _stp.y);
			if (targetBody1 == _body) {
				body1StoneJoints = new Vector.<DistanceJoint>;
				for (i = links.length - 1; i >= 0; i-- ) {
					var dj:DistanceJoint = new DistanceJoint(targetBody1.space.world, links[i], _stvec1, anch1, 0, 1 + i * (LINK_WID - LINK_DEPTH * 2));
					dj.ignore = true;
					dj.space = targetBody1.space;
					body1StoneJoints[body1StoneJoints.length] = dj;
				}
				var dj:DistanceJoint = new DistanceJoint(targetBody1.space.world, targetBody2, _stvec1, Vec2.get(beginPipeGrphcs.x, beginPipeGrphcs.y), 0, links.length * LINK_WID);
				dj.ignore = true;
				dj.space = targetBody1.space;
				body1StoneJoints[body1StoneJoints.length] = dj;
			}
			if (targetBody2 == _body) {
				body2StoneJoints = new Vector.<DistanceJoint>;
				for (i = 0 ; i < links.length; i++ ) {
					var dj:DistanceJoint = new DistanceJoint(targetBody2.space.world, links[i], _stvec2, anch2, 0, 1 + (links.length - i - 1) * (LINK_WID - LINK_DEPTH * 2));
					dj.ignore = true;
					dj.space = targetBody2.space;
					body2StoneJoints[body2StoneJoints.length] = dj;
				}
				var dj:DistanceJoint = new DistanceJoint(targetBody2.space.world, targetBody1, _stvec2, Vec2.get(endPipeGrphcs.x, endPipeGrphcs.y), 0, links.length * LINK_WID);
				dj.ignore = true;
				dj.space = targetBody2.space;
				body2StoneJoints[body2StoneJoints.length] = dj;
			}
		}
		public function dropPipe():void {
			if (endPipeGrphcs) {
				endPipeGrphcs.parent.removeChild(endPipeGrphcs);
				endPipeGrphcs = null;
			}
			if (circle) {
				circle.parent.removeChild(circle);
				circle = null;
			}
			targetBody1 = null;
			phase = 0;
			if (beginPipeGrphcs)
				beginPipeGrphcs.alpha = .5;
		}
		public function dispose():void {
			if (beginPipeGrphcs) {
				beginPipeGrphcs.parent.removeChild(beginPipeGrphcs);
				beginPipeGrphcs = null;
			}
			if (phase == 2) {
				var i:int;
				for (i = 0; i < body1Joints.length; i++ )
					body1Joints[i].space = null;
				for (i = 0; i < body2Joints.length; i++ )
					body2Joints[i].space = null;
				for (i = 0; i < linkJoints.length; i++ )
					linkJoints[i].joint.space = null;
				for (i = 0; i < links.length; i++ )
					links[i].space = null;
				if (body1StoneJoints)
					for (i = 0; i < body1StoneJoints.length; i++ )
						body1StoneJoints[i].space = null;
				if (body2StoneJoints)
					for (i = 0; i < body2StoneJoints.length; i++ )
						body2StoneJoints[i].space = null;
				ropeLay.parent.removeChild(ropeLay);
				ropeLay = null;
			}
			dropPipe();
		}
		public function step(_objContScroll:Number):void {
			switch(phase) {
				case 0:
					beginPipeGrphcs.x = beginPipeGrphcs.stage.mouseX;
					beginPipeGrphcs.y = beginPipeGrphcs.stage.mouseY - _objContScroll;
					break;
				case 1:
					endPipeGrphcs.x = endPipeGrphcs.stage.mouseX;
					endPipeGrphcs.y = endPipeGrphcs.stage.mouseY - _objContScroll;
					_tempPnt2 = beginPipeGrphcs.localToGlobal(_tempPnt1);
					circle.x = _tempPnt2.x;
					circle.y = _tempPnt2.y - _objContScroll;
					break;
				case 2:
					for (_i = 0; _i < anchs.length; _i++ ) {
						anchs[_i].x = links[_i].position.x;
						anchs[_i].y = links[_i].position.y;
					}
					ropeLay.graphics.clear();
					ropeLay.graphics.lineStyle(4, 0);
					CubicBezier.curveThroughPoints(ropeLay.graphics, anchs);
					if (!_btFlag) {
						_btFlag = true;
						targetBody1.allowMovement = true;
						targetBody2.allowMovement = true;
					}
					break;
			}
		}
	}
}
