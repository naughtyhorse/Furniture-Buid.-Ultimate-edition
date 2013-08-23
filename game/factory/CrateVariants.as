package game.factory {
	import game.factory.struct.CrateVariant;
	import game.factory.struct.CrateVariantPolygon;
	import game.managing.BitmapStorage;
	import nape.geom.Vec2;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class CrateVariants {
		
		private var crateVariants:Vector.<CrateVariant>;
		
		public var currentVariant:CrateVariant;
		
		public function CrateVariants() {
			initVariants();
		}
		public function generateRandomCrateVariant():void {
			currentVariant = null;
			while (!currentVariant) {
				currentVariant = crateVariants[Math.floor(Math.random() * crateVariants.length)];
				if (Math.random() * 100 > currentVariant.spawnChance)
					currentVariant = null;
			}
		}
		private function initVariants():void {
			crateVariants = new Vector.<CrateVariant>;
			var tempVariant:CrateVariant;
			var tempPolygon:CrateVariantPolygon;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_1"), BitmapStorage.staticGetBitmap("gui_obj", "cr_1"));
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 54;
			tempPolygon.height = 39;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_2"), BitmapStorage.staticGetBitmap("gui_obj", "cr_2"), 60);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 43;
			tempPolygon.height = 25;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_3"), BitmapStorage.staticGetBitmap("gui_obj", "cr_3"), 90);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 62;
			tempPolygon.height = 56;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_4"), BitmapStorage.staticGetBitmap("gui_obj", "cr_4"), 85);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 43;
			tempPolygon.height = 82;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_5"), BitmapStorage.staticGetBitmap("gui_obj", "cr_5"), 90);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 61;
			tempPolygon.height = 94;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_6"), BitmapStorage.staticGetBitmap("gui_obj", "cr_6"), 80);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 45;
			tempPolygon.height = 79;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 5, BitmapStorage.staticGetBitmap("obj", "cr_7"), BitmapStorage.staticGetBitmap("gui_obj", "cr_7"), 50);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 131;
			tempPolygon.height = 46;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 2, 46);
			tempPolygon.width = 5;
			tempPolygon.height = 12;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 125, 46);
			tempPolygon.width = 5;
			tempPolygon.height = 12;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_8"), BitmapStorage.staticGetBitmap("gui_obj", "cr_8"), 65);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 21;
			tempPolygon.height = 75;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 5, BitmapStorage.staticGetBitmap("obj", "cr_9"), BitmapStorage.staticGetBitmap("gui_obj", "cr_9"), 45);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 75;
			tempPolygon.height = 57;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 57);
			tempPolygon.width = 4;
			tempPolygon.height = 13;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 71, 57);
			tempPolygon.width = 5;
			tempPolygon.height = 13;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_10"), BitmapStorage.staticGetBitmap("gui_obj", "cr_10"), 80);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_RECTANGLE, 0, 0);
			tempPolygon.width = 64;
			tempPolygon.height = 54;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_11"), BitmapStorage.staticGetBitmap("gui_obj", "cr_11"), 15);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CIRCLE, 0, 0);
			tempPolygon.radius = 28;
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, -2, BitmapStorage.staticGetBitmap("obj", "cr_12"), BitmapStorage.staticGetBitmap("gui_obj", "cr_12"), 10);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(0,10),Vec2.get(21,0),Vec2.get(34,0),Vec2.get(57,10),Vec2.get(57,66),Vec2.get(0,66)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(0,66),Vec2.get(8,66),Vec2.get(8,69),Vec2.get(0,69)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(45,66),Vec2.get(57,66),Vec2.get(57,69),Vec2.get(45,69)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(8, -6, BitmapStorage.staticGetBitmap("obj", "cr_13"), BitmapStorage.staticGetBitmap("gui_obj", "cr_13"), 15);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(0,0),Vec2.get(62,0),Vec2.get(62,95),Vec2.get(0,95)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(62,39),Vec2.get(125,39),Vec2.get(125,95),Vec2.get(62,95)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(4,95),Vec2.get(10,95),Vec2.get(10,102),Vec2.get(4,102)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(53,95),Vec2.get(70,95),Vec2.get(70,102),Vec2.get(53,102)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(114,95),Vec2.get(125,95),Vec2.get(125,102),Vec2.get(114,102)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 2, BitmapStorage.staticGetBitmap("obj", "cr_14"), BitmapStorage.staticGetBitmap("gui_obj", "cr_14"), 10);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(5,3),Vec2.get(22,0),Vec2.get(46,0),Vec2.get(62,3),Vec2.get(69,24),Vec2.get(65,54),Vec2.get(1,54),Vec2.get(0,25)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(7,54),Vec2.get(14,54),Vec2.get(14,64),Vec2.get(7,64)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(54,54),Vec2.get(62,54),Vec2.get(62,64),Vec2.get(54,64)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 5, BitmapStorage.staticGetBitmap("obj", "cr_15"), BitmapStorage.staticGetBitmap("gui_obj", "cr_15"), 30);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(0,0),Vec2.get(54,0),Vec2.get(54,46),Vec2.get(0,46)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(1,46),Vec2.get(6,46),Vec2.get(6,58),Vec2.get(1,58)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(48,46),Vec2.get(52,46),Vec2.get(52,58),Vec2.get(48,58)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, -10, BitmapStorage.staticGetBitmap("obj", "cr_16"), BitmapStorage.staticGetBitmap("gui_obj", "cr_16"), 10);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(22,0),Vec2.get(28,0),Vec2.get(40,60),Vec2.get(9,60)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(0,60),Vec2.get(51,60),Vec2.get(51,64),Vec2.get(0,64)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 8, BitmapStorage.staticGetBitmap("obj", "cr_17"), BitmapStorage.staticGetBitmap("gui_obj", "cr_17"), 10);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(17,11),Vec2.get(38,0),Vec2.get(101,0),Vec2.get(117,6),Vec2.get(136,28),Vec2.get(138,57),Vec2.get(136,86),Vec2.get(89,141),Vec2.get(71,152),Vec2.get(63,152),
																			   Vec2.get(43, 141), Vec2.get(5, 97), Vec2.get(0, 50), Vec2.get(4, 29)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(-1, 10, BitmapStorage.staticGetBitmap("obj", "cr_18"), BitmapStorage.staticGetBitmap("gui_obj", "cr_18"), 15);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(0,0),Vec2.get(105,0),Vec2.get(105,2),Vec2.get(0,2)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(10,2),Vec2.get(95,2),Vec2.get(95,10),Vec2.get(10,10)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(10,10),Vec2.get(15,10),Vec2.get(15,43),Vec2.get(10,43)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(89,10),Vec2.get(95,10),Vec2.get(95,43),Vec2.get(89,43)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_19"), BitmapStorage.staticGetBitmap("gui_obj", "cr_19"), 30);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(0,2),Vec2.get(2,0),Vec2.get(22,0),Vec2.get(23,1),Vec2.get(23,49),Vec2.get(21,54),Vec2.get(3,54),Vec2.get(0,51)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_20"), BitmapStorage.staticGetBitmap("gui_obj", "cr_20"), 45);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(0,0),Vec2.get(45,0),Vec2.get(45,109),Vec2.get(0,109)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 18, BitmapStorage.staticGetBitmap("obj", "cr_21"), BitmapStorage.staticGetBitmap("gui_obj", "cr_21"), 15);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(8,0),Vec2.get(20,0),Vec2.get(27,20),Vec2.get(0,20)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(13,20),Vec2.get(15,20),Vec2.get(15,92),Vec2.get(13,92)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(8,92),Vec2.get(19,92),Vec2.get(22,96),Vec2.get(4,96)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
			
			tempVariant = new CrateVariant(0, 0, BitmapStorage.staticGetBitmap("obj", "cr_22"), BitmapStorage.staticGetBitmap("gui_obj", "cr_22"), 10);
			tempPolygon = new CrateVariantPolygon(CrateVariantPolygon.TYPE_CUSTOM, 0, 0);
			tempPolygon.vertex = new <Vec2>[Vec2.get(4,3),Vec2.get(34,0),Vec2.get(65,2),Vec2.get(70,16),Vec2.get(64,31),Vec2.get(6,31),Vec2.get(0,17)];
			tempVariant.polygons[tempVariant.polygons.length] = tempPolygon;
			crateVariants[crateVariants.length] = tempVariant;
		}
	}
}
