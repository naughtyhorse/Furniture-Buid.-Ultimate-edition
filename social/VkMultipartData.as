package social {
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class VkMultipartData {
		public static const BOUNDARY:String = "----------cH2gL6ei4Ef1gL6GI3Ij5Ef1Ef1Ef1";
        private static const CRLF:String = "\r\n";
        private static const HYPHENS:String = "--";
		
		private var data:ByteArray;
		
		public function VkMultipartData() {
			data = new ByteArray();
		}
		public function addFile(_file:ByteArray, _name:String, _fileName:String = "name.jpg"):void{
            data.writeUTFBytes(HYPHENS + BOUNDARY + CRLF);
            data.writeUTFBytes("Content-Disposition: form-data; name=" + _name + "; filename=" + _fileName + CRLF);
            data.writeUTFBytes("Content-Type: application/octet-stream" + CRLF + CRLF);
            data.writeBytes(_file);
            data.writeUTFBytes(CRLF);
        }
		public function clear():void {
			data.clear();
		}
		public function get Data():ByteArray{
            var d:ByteArray = new ByteArray();
            d.writeBytes(data);
            d.writeUTFBytes(HYPHENS + BOUNDARY + HYPHENS);
            return d;
        }
	}
}
