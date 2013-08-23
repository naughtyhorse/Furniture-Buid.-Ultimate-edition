package game.managing {
	import flash.display.BitmapData;
	import game.managing.struct.BmStorEntry;
	import game.managing.struct.BmStorZone;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class BitmapStorage {
		
		private static var copy:BitmapStorage;
		
		private var bmZones:Vector.<BmStorZone>;
		
		private var _i:int;
		private var _j:int;
		
		public function BitmapStorage() {
			bmZones = new Vector.<BmStorZone>;
		}
		public static function initCopy():void {
			if (!copy) {
				copy = new BitmapStorage();
			}
		}
		public function addZone(_zoneHead:String):void {
			bmZones[bmZones.length] = new BmStorZone(_zoneHead);
		}
		public function addBitmap(_zone:String, _head:String, _bitmap:BitmapData):void {
			for (_i = 0; _i < bmZones.length; _i++ )
				if (bmZones[_i].head == _zone) {
					bmZones[_i].entry.push(new BmStorEntry(_head, _bitmap));
					return;
				}
		}
		public function getBitmap(_zone:String, _head:String):BitmapData {
			for (_i = 0; _i < bmZones.length; _i++ )
				if (bmZones[_i].head == _zone)
					for (_j = 0; _j < bmZones[_i].entry.length; _j++ )
						if (bmZones[_i].entry[_j].head == _head)
							return bmZones[_i].entry[_j].bitmap;
			return null;
		}
		public function clearZone(_zone:String):void {
			for (_i = 0; _i < bmZones.length; _i++ )
				if (bmZones[_i].head == _zone) {
					for (_j = 0; _j < bmZones[_i].entry.length; _j++ )
						bmZones[_i].entry[_j].bitmap.dispose();
					bmZones.splice(_i, 1);
					return;
				}
		}
		public static function staticAddZone(_zoneHead:String):void {
			if (copy) copy.addZone(_zoneHead);
		}
		public static function staticAddBitmap(_zone:String, _head:String, _bitmap:BitmapData):void {
			if (copy) copy.addBitmap(_zone, _head, _bitmap);
		}
		public static function staticGetBitmap(_zone:String, _head:String):BitmapData {
			if (copy) return copy.getBitmap(_zone, _head);
			else return null;
		}
		public static function staticClearZone(_zone:String):void {
			if (copy) copy.clearZone(_zone);
		}
	}
}
