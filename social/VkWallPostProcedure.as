package social {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import vk.api.serialization.json.JSON;
	import vk.APIConnection;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class VkWallPostProcedure {
		
		private var vk:APIConnection;
		
		private var targetId:String;
		private var message:String;
		private var photoAttachments:Vector.<BitmapData>;
		
		private var callback:Function;
		
		private var _uploadServer:String;
		private var _uploadedAttachments:Vector.<String>;
		
		private var loader:URLLoader;
		
		public var onComplete:Function = null;
		
		public function VkWallPostProcedure(_vk:APIConnection, _targetId:String, _message:String, _photoAttachments:Vector.<BitmapData>, _callback:Function) {
			vk = _vk;
			targetId = _targetId;
			message = _message;
			photoAttachments = _photoAttachments;
			callback = _callback;
		}
		public function run():void {
			if (photoAttachments)
				vk["api"]("photos.getWallUploadServer", { uid:targetId }, getUploadServer, callError);
			else runPosting();
		}
		private function getUploadServer(_ans):void {
			_uploadServer = _ans["upload_url"];
			_uploadedAttachments = new Vector.<String>;
			uploadingPhotoLoop();
		}
		private function uploadingPhotoLoop():void {
			var url:URLRequest = new URLRequest(_uploadServer);
			url.method = "POST";
			url.requestHeaders.push(new URLRequestHeader("Content-type", "multipart/form-data; boundary=" + VkMultipartData.BOUNDARY));
			var data:VkMultipartData = new VkMultipartData();
			data.addFile((new JPGEncoder(80)).encode(photoAttachments.shift()), "photo");
			url.data = data.Data;
			loader = new URLLoader();
			loader.addEventListener(ProgressEvent.PROGRESS, loadingProgress);
			loader.addEventListener(Event.COMPLETE, loadingComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, callError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, callError);
			loader.load(url);
		}
		private function loadingProgress(e:ProgressEvent):void {
			if (callback !== null)
				callback(new VkWallPostAnswer(VkWallPostAnswer.PROGRESS, e.bytesLoaded, e.bytesTotal, photoAttachments.length));
		}
		private function loadingComplete(e):void {
			var objAns:Object = JSON.decode(loader.data);
			loader.removeEventListener(ProgressEvent.PROGRESS, loadingProgress);
			loader.removeEventListener(Event.COMPLETE, loadingComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, callError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, callError);
			loader.close();
			loader = null;
			vk["api"]("photos.saveWallPhoto", { server:objAns["server"], photo:objAns["photo"], hash:objAns["hash"], uid:targetId }, attachmentLoaded, callError);
		}
		private function attachmentLoaded(_ans):void {
			_uploadedAttachments[_uploadedAttachments.length] = _ans["0"]["id"];
			if (callback !== null)
				callback(new VkWallPostAnswer(VkWallPostAnswer.PHOTO_UPLOADED, 0, 0, photoAttachments.length));
			if (photoAttachments.length > 0)
				uploadingPhotoLoop();
			else runPosting();
		}
		private function runPosting():void {
			var _attchs:String = null;
			if (_uploadedAttachments) {
				_attchs = "";
				for (var i:int = 0; i < _uploadedAttachments.length; i++ )
					_attchs += _uploadedAttachments[i] + ",";
				vk["api"]("wall.post", { message:message, attachments:_attchs, owner_id:targetId }, wallPosted, callError);
			} else vk["api"]("wall.post", { message:message, owner_id:targetId }, wallPosted, callError);
		}
		private function wallPosted(_ans):void {
			if (callback !== null)
				callback(new VkWallPostAnswer(VkWallPostAnswer.SUCCESS, 0, 0, 0, _ans["post_id"]));
			if (onComplete !== null) onComplete(this);
		}
		private function callError(er):void {
			if (callback !== null)
				callback(new VkWallPostAnswer(VkWallPostAnswer.ERROR));
			if (onComplete !== null) onComplete(this);
		}
	}
}
