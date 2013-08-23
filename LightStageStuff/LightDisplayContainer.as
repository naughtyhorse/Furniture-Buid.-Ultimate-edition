package LightStageStuff {
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public class LightDisplayContainer {
		static const SHIT:Shape = new Shape();
		
		public var parents:Vector.<LightDisplayContainer>;
		
		public var stage:LightStage = null;
		
		public var children:Vector.<LightDisplayContainer>;
		
		public var x:Number = 0;
		public var y:Number = 0;
		
		private var _rotation:Number = 0;
		
		public var scaleDeviation:Boolean = false;
		private var scale:Number = 1;
		
		public var alphaDeviation:Boolean = false;
		private var alpha:Number = 1;
		
		public var visible:Boolean = true;
		
		protected var _i:int;
		protected var _i2:int;
		protected var _j:int;
		protected var _j2:int;
		private var _tempChild:LightDisplayContainer;
		private var _matrix:Matrix;
		
		public function LightDisplayContainer():void {
			parents = new Vector.<LightDisplayContainer>;
			children = new Vector.<LightDisplayContainer>;
			_matrix = new Matrix();
		}
		public function addChild(_child:LightDisplayContainer):void {
			if (_child.parents.length > 0)
				if (_child.parents[_child.parents.length - 1] == this) return;
			children[children.length] = _child;
			_child.parents = this.parents.concat(new <LightDisplayContainer>[this]);
			_child.stage = this.stage;
			_child.updateParentChain();
		}
		public function updateParentChain():void {
			_i2 = children.length;
			for (_i = 0; _i < _i2; _i++ )
				children[_i].parents = this.parents.concat(new <LightDisplayContainer>[this]);
		}
		public function removeChild(_child:LightDisplayContainer):void {
			_i2 = children.length;
			for (_i = 0; _i < _i2 ; _i++ ) {
				_tempChild = children[_i];
				if (_tempChild == _child) {
					_tempChild.parents.splice(0, _tempChild.parents.length);
					_tempChild.stage = null;
					children.splice(_i--, 1);
					_i2--;
				}
			}
		}
		public function moveBack(_child:LightDisplayContainer):void {
			_i2 = children.length;
			if (_i2 > 0)
				for (_i = 0; _i < _i2 ; _i++ )
					if (children[_i] == _child)
						changeChildIndex(_i, 0);
		}
		public function moveForward(_child:LightDisplayContainer):void {
			_i2 = children.length;
			if (_i2 > 0)
				for (_i = 0; _i < _i2 ; _i++ )
					if (children[_i] == _child)
						changeChildIndex(_i, children.length - 1);
		}
		private function changeChildIndex(_from:int, _to:int):void {
			_tempChild = children[_to];
			children[_to] = children[_from];
			children[_from] = _tempChild;
		}
		public function updateStage():void {
			_i2 = children.length;
			for (_i = 0; _i < _i2 ; _i++ ) {
				children[_i].stage = this.stage;
				if (children[_i].children)
					updateStageThroughChildren(children[_i].children);
			}
		}
		private function updateStageThroughChildren(_children:Vector.<LightDisplayContainer>):void {
			for (var i:int = 0; i < _children.length; i++ )
				_children[i].stage = this.stage;
		}
		public function selfRemoving():void {
			if (this.parents.length > 0)
				this.parents[this.parents.length - 1].removeChild(this);
			else if (this.stage) this.stage.removeChild(this);
		}
		public function get NearestParent():LightDisplayContainer {
			if (this.parents.length == 0) return null;
			else return this.parents[this.parents.length - 1];
		}
		public function set Scale(value:Number) {
			scale = value;
			scaleDeviation = (scale !== 1);
		}
		public function get Scale():Number { return scale; }
		public function set Alpha(value:Number):void {
			if (value > 1) value = 1;
			if (value < 0) value = 0;
			alpha = value;
			alphaDeviation = (alpha !== 1);
		}
		public function get Alpha():Number { return alpha; }
		public function set rotation(value:Number):void {
			SHIT.rotation = value;
			_rotation = SHIT.rotation;
		}
		public function get rotation():Number { return _rotation; }
		public function localToGlobal(_point:Point):Point {
			var _out:Point = new Point();
			_matrix.identity();
			_matrix.translate(_point.x, _point.y);
			_matrix.scale(Scale, Scale);
			_matrix.rotate(rotation * Math.PI / 180);
			_matrix.translate(x, y);
			for (_i = parents.length - 1; _i >= 0; _i-- ) {
				_matrix.scale(parents[_i].Scale, parents[_i].Scale);
				_matrix.rotate(parents[_i].rotation * Math.PI / 180);
				_matrix.translate(parents[_i].x, parents[_i].y);
			}
			_out.x = _matrix.tx;
			_out.y = _matrix.ty;
			return _out;
		}
	}
}
