package LightStageStuff {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class LightStage extends Bitmap {
		public var children:Vector.<LightDisplayContainer>;
		
		private var _i:int;
		private var _i2:int;
		private var _tempChild;
		private var _j:int;
		private var _j2:int;
		
		private var _matrix:Matrix;
		private var _colorTransform:ColorTransform;
		private var _smoothing:Boolean;
		private var _point:Point;
		
		private var blur:BlurFilter;
		public var applyBlur:Boolean = false;
		
		public function LightStage(_width:Number, _height:Number):void {
			super();
			this.bitmapData = new BitmapData(_width, _height, true, 0x00000000);
			children = new Vector.<LightDisplayContainer>;
			_matrix = new Matrix();
			_colorTransform = new ColorTransform();
			_point = new Point();
			blur = new BlurFilter();
		}
		public function addChild(_child:LightDisplayContainer):void {
			children[children.length] = _child;
			_child.stage = this;
			_child.parents.splice(0, _child.parents.length);
			_child.updateStage();
			_child.updateParentChain();
		}
		public function removeChild(_child:LightDisplayContainer):void {
			_i2 = children.length;
			for (_i = 0; _i < _i2 ; _i++ ) {
				_tempChild = children[_i];
				if (_tempChild == _child) {
					_tempChild.stage = null;
					_tempChild.updateStage();
					children.splice(_i--, 1);
					_i2--;
				}
			}
		}
		public function moveBack(_child:LightDisplayContainer):void {
			_i2 = children.length;
			if (_i2 > 0)
				for (_i = 0; _i < _i2 ; _i++ )
					if (children[_i] == _child) {
						children.splice(_i, 1);
						children.unshift(_child);
					}
		}
		public function moveForward(_child:LightDisplayContainer):void {
			_i2 = children.length;
			if (_i2 > 0)
				for (_i = 0; _i < _i2 ; _i++ )
					if (children[_i] == _child) {
						children.splice(_i, 1);
						children[children.length] = _child;
					}
		}
		public function step():void {
			this.bitmapData.lock();
			this.bitmapData.fillRect(this.bitmapData.rect, 0x00000000);
			_i2 = children.length;
			for (_i = 0; _i < _i2 ; _i++ )
				objectStepLoop(children[_i]);
			if (applyBlur)
				this.bitmapData.applyFilter(this.bitmapData, this.bitmapData.rect, _point, blur);
			this.bitmapData.unlock();
		}
		private function objectStepLoop(_object:LightDisplayContainer):void {
			if (_object.visible) {
				if (_object is LightObject)
					if ((_object as LightObject).bitmapData) {
						_matrix.identity();
						_smoothing = false;
						_colorTransform.alphaMultiplier = _object.Alpha;
						_colorTransform.redOffset = (_object as LightObject).redOffset;
						_colorTransform.greenOffset = (_object as LightObject).greenOffset;
						_colorTransform.blueOffset = (_object as LightObject).blueOffset;
						_matrix.scale(_object.Scale, _object.Scale);
						if (_object.Scale !== 1)_smoothing = true;
						if ((_object as LightObject).centrilised)
							_matrix.translate( -(_object as LightObject).Width / 2, -(_object as LightObject).Height / 2);
						else 
							if ((_object as LightObject).centerXDeviation || (_object as LightObject).centerYDeviation)
								_matrix.translate( (_object as LightObject).CenterX, (_object as LightObject).CenterY);
						_matrix.rotate(_object.rotation * Math.PI / 180);
						_matrix.translate(_object.x, _object.y);
						for (_j = _object.parents.length - 1; _j >= 0; _j-- ) {
							if (_object.parents[_j] is LightObject) {
								_colorTransform.redOffset += (_object.parents[_j] as LightObject).redOffset;
								_colorTransform.greenOffset += (_object.parents[_j] as LightObject).greenOffset;
								_colorTransform.blueOffset += (_object.parents[_j] as LightObject).blueOffset;
							}
							if (_object.parents[_j].alphaDeviation)
								_colorTransform.alphaMultiplier *= _object.parents[_j].Alpha;
							_matrix.scale(_object.parents[_j].Scale, _object.parents[_j].Scale);
							if (_object.parents[_j].Scale !== 1)_smoothing = true;
							_matrix.rotate(_object.parents[_j].rotation * Math.PI / 180);
							_matrix.translate(_object.parents[_j].x, _object.parents[_j].y);
						}
						if (_colorTransform.alphaMultiplier !== 1 || _colorTransform.redOffset !== 0 || _colorTransform.greenOffset !== 0 || _colorTransform.blueOffset !== 0)
							this.bitmapData.draw((_object as LightObject).bitmapData, _matrix, _colorTransform, null, null, _smoothing);
						else this.bitmapData.draw((_object as LightObject).bitmapData, _matrix, null, null, null, _smoothing);
					}
				for (var i:int = 0; i < _object.children.length; i++ )
					objectStepLoop(_object.children[i]);
			}
		}
		public function set BlurX(value:Number):void { blur.blurX = value; }
		public function set BlurY(value:Number):void { blur.blurY = value; }
	}
}
