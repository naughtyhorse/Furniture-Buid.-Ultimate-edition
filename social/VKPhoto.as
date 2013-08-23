package social {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class VKPhoto extends Sprite {
		
		private var back:Boolean;
		
		private var wid:Number = 100;
		private var hei:Number = 100;
		
		private var bm:Bitmap;
		
		public function VKPhoto(_back:Boolean = false) {
			back = _back;
			if (back) {
				this.graphics.beginFill(0, .4);
				this.graphics.drawRect(0, 0, wid, hei);
				this.graphics.endFill();
			}
		}
		public function init(_url:String):void {
			var _cont:Sprite = new Sprite();
			var _loader:Loader = new Loader();
			_cont.addChild(_loader);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			var _lc:LoaderContext = new LoaderContext(true);
			_loader.load(new URLRequest(_url), _lc);
		}
		private function loaded(e):void {
			var _path:String = (e.target as LoaderInfo).url;
			var _loader:Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, reallyLoaded);
			(e.target as LoaderInfo).loader.parent.addChild(_loader);
			(e.target as LoaderInfo).loader.parent.removeChild((e.target as LoaderInfo).loader);
			var _lc:LoaderContext = new LoaderContext(true);
			_loader.load(new URLRequest(_path), _lc);
		}
		private function reallyLoaded(e):void {
			bm = new Bitmap(((e.target as LoaderInfo).content as Bitmap).bitmapData, "auto", true);
			addChild(bm);
			bm.width = wid;
			bm.height = hei;
		}
		public function set Wid(value:Number):void {
			wid = value;
			if (back) {
				this.graphics.beginFill(0, .4);
				this.graphics.drawRect(0, 0, wid, hei);
				this.graphics.endFill();
			}
			if (bm) {
				bm.width = wid;
			}
		}
		public function set Hei(value:Number):void {
			hei = value;
			if (back) {
				this.graphics.beginFill(0, .4);
				this.graphics.drawRect(0, 0, wid, hei);
				this.graphics.endFill();
			}
			if (bm) {
				bm.height = hei;
			}
		}
	}
}
