package game.objects {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import game.factory.struct.CrateVariant;
	import game.graphics.CentrilizedBmd;
	import game.managing.BitmapStorage;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class CrateObject {
		
		public var crateVariant:CrateVariant;
		public var body:Body;
		public var stoneJoint:PivotJoint;
		
		public var ropes:Vector.<RopeObject>;
		
		public var graphics:CentrilizedBmd;
		
		public var banSign:CentrilizedBmd;
		
		public var stoned:Boolean = false;
		
		public function CrateObject(_crateVariant:CrateVariant, _body:Body) {
			crateVariant = _crateVariant;
			body = _body;
			graphics = new CentrilizedBmd(crateVariant.bitmapData, _crateVariant.centerDeviantX, _crateVariant.centerDeviantY);
		}
		public function reify(_container:Sprite):void {
			banSign = new CentrilizedBmd(BitmapStorage.staticGetBitmap("sign", "ban"));
			banSign.alpha = .4;
			banSign.visible = false;
			_container.addChild(banSign);
			ropes = new Vector.<RopeObject>;
		}
		public function freeze():void {
			stoned = true;
			body.type = BodyType.STATIC;
			var v:Vec2 = Vec2.get();
			stoneJoint = new PivotJoint(body, body.space.world, v, body.localPointToWorld(v));
			stoneJoint.maxForce = Number.MAX_VALUE;
			stoneJoint.space = body.space;
			body.allowRotation = false;
			body.type = BodyType.DYNAMIC;
			for (var i:int = 0; i < ropes.length; i++ )
				ropes[i].stoneTargetBody(body);
			graphics.transform.colorTransform = new ColorTransform(0, 1, 0);
		}
		public function dispose():void {
			if (stoneJoint) stoneJoint.space = null;
			graphics.parent.removeChild(graphics);
			if (banSign)
				banSign.parent.removeChild(banSign);
		}
		public function step():void {
			graphics.x = body.position.x;
			graphics.y = body.position.y;
			graphics.rotation = body.rotation * 180 / Math.PI;
			if (banSign) {
				banSign.x = graphics.x;
				banSign.y = graphics.y;
			}
		}
	}
}
