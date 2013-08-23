package social {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.net.navigateToURL;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class BestScoresLine extends Sprite {
		
		public var wid:Number;
		public var hei:Number;
		
		private var loading:CentrilizedBmd;
		
		private var vkId:String;
		private var towerHei:Number;
		
		private var alphaTrigger:Boolean = false;
		
		private var vkCore:VkCore;
		
		private var tf:TextField;
		private var vkPhoto:VKPhoto;
		
		private var link:String = null;
		
		public function BestScoresLine(_wid:Number, _hei:Number) {
			wid = _wid;
			hei = _hei;
		}
		public function implemetInfo(_vkId:String, _hei:Number, _vkCore:VkCore):void {
			vkId = _vkId;
			towerHei = _hei;
			vkCore = _vkCore;
			this.graphics.beginFill(0, .4);
			this.graphics.drawRect(0, 0, wid, hei);
			this.graphics.endFill();
			alpha = 0;
			alphaTrigger = true;
			loading = new CentrilizedBmd(new GrumpyBmd, "auto", true, -29, -29);
			addChild(loading);
			loading.x = wid / 2;
			loading.y = hei / 2;
			tf = new TextField();
			addChild(tf);
			tf.textColor = 0xffffff;
			tf.width = wid;
			tf.height = hei;
			tf.selectable = false;
			if (_vkId !== "0") vkCore.getPersonalInfo(vkId, [VkPersonalInfoFields.PHOTO_100X100, VkPersonalInfoFields.NICKNAME_LINK], loadInfo);
			else {
				tf.appendText("Nope(нету результата)\n");
				removeChild(loading);
				loading = null;
			}
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.mouseChildren = false;
		}
		private function onClick(e):void {
			if (link) navigateToURL(new URLRequest(link));
		}
		private function loadInfo(_ans:VkGetInfoAnswer):void {
			removeChild(loading);
			loading = null;
			var _fn:String = "";
			var _ln:String = "";
			if (_ans.fields) {
				for (var i:int = 0; i < _ans.fields.length; i++ )
					switch(_ans.fields[i]) {
						case VkPersonalInfoFields.PHOTO_100X100:
							tf.x = hei + 3;
							tf.width = wid - tf.x;
							vkPhoto = new VKPhoto(false);
							addChild(vkPhoto);
							vkPhoto.init(_ans.values[i]);
							vkPhoto.Wid = vkPhoto.Hei = hei;
							break;
						case VkPersonalInfoFields.LAST_NAME:
							_ln += _ans.values[i];
							break;
						case VkPersonalInfoFields.FIRST_NAME:
							_fn += _ans.values[i];
							break;
						case VkPersonalInfoFields.NICKNAME_LINK:
							link = "http://vk.com/" + _ans.values[i];
							break;
					}
				tf.appendText(_fn + " " + _ln + "\n");
				tf.appendText("Башня: " + towerHei.toFixed(1) + " м");
			}
		}
		public function step():void {
			if (alphaTrigger) {
				alpha += .05;
				if (alpha >= 1) {
					alpha = 1;
					alphaTrigger = false;
				}
			}
			if (loading) loading.rotation += 1;
		}
	}
}
