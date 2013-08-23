package {
	import flash.display.Sprite;
	import flash.events.Event;
	import game.factory.ExchangeScreen;
	import game.factory.ExchangeScreenFactory;
	import game.factory.KittyButtonFactory;
	import game.factory.stencil.StencilTitle;
	import game.managing.BitmapStorage;
	import game.managing.Shaker;
	import game.managing.SoundsManager;
	import game.screens.MainMenuScreen;
	import game.screens.ScoresScreen;
	import game.World;
	import social.VkCore;

	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	[Frame(factoryClass="Preloader")]
	public class Supreme extends Sprite {
		
		private var world:World;
		private var worldWorkFlag:Boolean = false;
		
		private var mainMenu:MainMenuScreen;
		private var mainMenuWorkFlag:Boolean = true;
		
		private var scores:ScoresScreen;
		private var scoresWorkFlag:Boolean = false;
		
		private var shaker:Shaker;
		private var buttons:KittyButtonFactory;
		private var exchanges:ExchangeScreenFactory;
		
		public static var vk:VkCore;

		public function Supreme():void {
			if (stage) init(null);
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void {
			if (e) removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initGraphics();
			StencilTitle.init();
			shaker = Shaker.init();
			buttons = KittyButtonFactory.initCopy();
			exchanges = ExchangeScreenFactory.initCopy();
			SoundsManager.init(stage.stageWidth);
			
			mainMenu = new MainMenuScreen();
			addChild(mainMenu);
			mainMenu.init();
			mainMenu.playButton.onClick = fromMMToWorld;
			
			SoundsManager.playSoundtrack();
			
			vk = new VkCore(stage);
			
			addEventListener(Event.ENTER_FRAME, ef);
		}
		private function fromMMToWorld():void {
			SoundsManager.setSoundtrackVolume(.35);
			mainMenu.playButton.onClick = null;
			mainMenuWorkFlag = false;
			world = new World();
			addChild(world);
			world.init();
			var _exch:ExchangeScreen = ExchangeScreenFactory.addExchange(this, mainMenu, world, function():void {
				removeChild(_exch);
				mainMenu = null;
				addChild(world);
				world.initListeners();
				world.onGameOver = fromWorldToScores;
				world.controlLay.onBackToMM = fromWorldToMM;
				worldWorkFlag = true;
			});
		}
		private function fromWorldToMM():void {
			SoundsManager.Mute = false;
			SoundsManager.setSoundtrackVolume(1);
			SoundsManager.playButtonClickSound();
			world.onGameOver = null;
			world.controlLay.onBackToMM = null;
			worldWorkFlag = false;
			world.disposeListeners();
			mainMenu = new MainMenuScreen();
			addChild(mainMenu);
			mainMenu.init();
			var _exch:ExchangeScreen = ExchangeScreenFactory.addExchange(this, world, mainMenu, function():void {
				removeChild(_exch);
				world = null;
				addChild(mainMenu);
				mainMenu.playButton.onClick = fromMMToWorld;
				mainMenuWorkFlag = true;
			});
		}
		private function fromWorldToScores(_furnCount:int, _glueCount:int, _bombsCount:int, _ropesCount:int, _hei:String):void {
			SoundsManager.Mute = false;
			world.onGameOver = null;
			world.controlLay.onBackToMM = null;
			worldWorkFlag = false;
			world.disposeListeners();
			scores = new ScoresScreen();
			addChild(scores);
			scores.init(_furnCount, _glueCount, _bombsCount, _ropesCount, _hei);
			var _exch:ExchangeScreen = ExchangeScreenFactory.addExchange(this, world, scores, function():void {
				removeChild(_exch);
				world = null;
				addChild(scores);
				scores.replayBtn.onClick = fromScoresToWorld;
				scores.mmBtn.onClick = fromScoresToMM;
				scoresWorkFlag = true;
			});
		}
		private function fromScoresToWorld():void {
			scoresWorkFlag = false;
			scores.replayBtn.onClick = null;
			scores.mmBtn.onClick = null;
			world = new World();
			addChild(world);
			world.init();
			var _exch:ExchangeScreen = ExchangeScreenFactory.addExchange(this, scores, world, function():void {
				removeChild(_exch);
				scores = null;
				addChild(world);
				world.initListeners();
				world.onGameOver = fromWorldToScores;
				world.controlLay.onBackToMM = fromWorldToMM;
				worldWorkFlag = true;
			});
		}
		private function fromScoresToMM():void {
			SoundsManager.setSoundtrackVolume(1);
			scoresWorkFlag = false;
			scores.replayBtn.onClick = null;
			scores.mmBtn.onClick = null;
			mainMenu = new MainMenuScreen();
			addChild(mainMenu);
			mainMenu.init();
			var _exch:ExchangeScreen = ExchangeScreenFactory.addExchange(this, scores, mainMenu, function():void {
				removeChild(_exch);
				scores = null;
				addChild(mainMenu);
				mainMenu.playButton.onClick = fromMMToWorld;
				mainMenuWorkFlag = true;
			});
		}
		private function initGraphics():void {
			BitmapStorage.initCopy();
			
			BitmapStorage.staticAddZone("obj");
			BitmapStorage.staticAddBitmap("obj", "cr_1", new Crate1Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_2", new Crate2Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_3", new Crate3Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_4", new Crate4Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_5", new Crate5Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_6", new Crate6Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_7", new Crate7Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_8", new Crate8Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_9", new Crate9Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_10", new Crate10Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_11", new Crate11Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_12", new Crate12Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_13", new Crate13Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_14", new Crate15Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_15", new Crate16Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_16", new Crate17Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_17", new Crate18Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_18", new Crate19Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_19", new Crate20Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_20", new Crate21Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_21", new Crate22Bmd);
			BitmapStorage.staticAddBitmap("obj", "cr_22", new Crate23Bmd);
			
			BitmapStorage.staticAddZone("gui_obj");
			BitmapStorage.staticAddBitmap("gui_obj", "bomb", new GuiObjBombBmd);
			BitmapStorage.staticAddBitmap("gui_obj", "rope", new GuiObjRopeBmd);
			BitmapStorage.staticAddBitmap("gui_obj", "glue", new GuiObjGlueBmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_1", new GuiObjCrate1Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_2", new GuiObjCrate2Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_3", new GuiObjCrate3Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_4", new GuiObjCrate4Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_5", new GuiObjCrate5Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_6", new GuiObjCrate6Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_7", new GuiObjCrate7Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_8", new GuiObjCrate8Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_9", new GuiObjCrate9Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_10", new GuiObjCrate10Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_11", new GuiObjCrate11Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_12", new GuiObjCrate12Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_13", new GuiObjCrate13Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_14", new GuiObjCrate15Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_15", new GuiObjCrate16Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_16", new GuiObjCrate17Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_17", new GuiObjCrate18Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_18", new GuiObjCrate19Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_19", new GuiObjCrate20Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_20", new GuiObjCrate21Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_21", new GuiObjCrate22Bmd);
			BitmapStorage.staticAddBitmap("gui_obj", "cr_22", new GuiObjCrate23Bmd);
			
			BitmapStorage.staticAddZone("tls");
			BitmapStorage.staticAddBitmap("tls", "bomb", new ThermiteBombBmd);
			BitmapStorage.staticAddBitmap("tls", "glue", new GlueBmd);
			BitmapStorage.staticAddBitmap("tls", "pipe", new RopePipeBmd);
			BitmapStorage.staticAddBitmap("tls", "pckup_rp", new PickupRopeBmd);
			BitmapStorage.staticAddBitmap("tls", "hrt", new HeartBmd);
			
			BitmapStorage.staticAddZone("sign");
			BitmapStorage.staticAddBitmap("sign", "ban", new BanSignBmd);
			
			BitmapStorage.staticAddZone("gui");
			BitmapStorage.staticAddBitmap("gui", "bgtl", new BgTileBmd);
			BitmapStorage.staticAddBitmap("gui", "pltfrm", new PlatformBmd);
			BitmapStorage.staticAddBitmap("gui", "mnt", new MauntBmd);
			BitmapStorage.staticAddBitmap("gui", "hcl_1", new HipsterCloud1Bmd);
			BitmapStorage.staticAddBitmap("gui", "hcl_2", new HipsterCloud2Bmd);
			BitmapStorage.staticAddBitmap("gui", "hcl_3", new HipsterCloud3Bmd);
			BitmapStorage.staticAddBitmap("gui", "hcl_4", new HipsterCloud4Bmd);
			BitmapStorage.staticAddBitmap("gui", "l_ar", new LeftArrowBmd);
			BitmapStorage.staticAddBitmap("gui", "r_ar", new RightArrowBmd);
			BitmapStorage.staticAddBitmap("gui", "tc", new GuiTerryBmd);
			
			BitmapStorage.staticAddZone("stencil");
			BitmapStorage.staticAddBitmap("stencil", "hd_bomb", new HeadBombBmd);
			BitmapStorage.staticAddBitmap("stencil", "hd_frntr", new HeadFurnitureBmd);
			BitmapStorage.staticAddBitmap("stencil", "hd_glue", new HeadGlueBmd);
			BitmapStorage.staticAddBitmap("stencil", "hd_rope", new HeadRopeBmd);
			BitmapStorage.staticAddBitmap("stencil", "hd_poof", new HeadPoofBmd);
			BitmapStorage.staticAddBitmap("stencil", "hd_trys", new HeadTrysBmd);
			BitmapStorage.staticAddBitmap("stencil", "hd_schnt", new HeadScrollHintBmd);
			
			BitmapStorage.staticAddBitmap("stencil", "ghd_hei", new GoldHeadHeiBmd);
			BitmapStorage.staticAddBitmap("stencil", "ghd_ch_1", new GoldHeadCheck1Bmd);
			BitmapStorage.staticAddBitmap("stencil", "ghd_ch_2", new GoldHeadCheck2Bmd);
			BitmapStorage.staticAddBitmap("stencil", "ghd_ch_3", new GoldHeadCheck3Bmd);
			
			BitmapStorage.staticAddZone("particles");
			BitmapStorage.staticAddBitmap("particles", "de_1", new ParticleDeb1Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_2", new ParticleDeb2Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_3", new ParticleDeb3Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_4", new ParticleDeb4Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_5", new ParticleDeb5Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_6", new ParticleDeb6Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_7", new ParticleDeb7Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_8", new ParticleDeb8Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_9", new ParticleDeb9Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_10", new ParticleDeb10Bmd);
			BitmapStorage.staticAddBitmap("particles", "de_11", new ParticleDeb11Bmd);
			BitmapStorage.staticAddBitmap("particles", "spark", new ParticleSparkBmd);
			BitmapStorage.staticAddBitmap("particles", "cloud", new ParticlePoofCloudBmd);
			BitmapStorage.staticAddBitmap("particles", "star", new ParticleStarBmd);
			
			BitmapStorage.staticAddZone("gfx");
			BitmapStorage.staticAddBitmap("gfx", "flash_r", new FlashRedBmd);
			BitmapStorage.staticAddBitmap("gfx", "flash_y", new FlashYelBmd);
			BitmapStorage.staticAddBitmap("gfx", "game_logo", new GameLogoBmd);
			
			BitmapStorage.staticAddZone("scores");
			BitmapStorage.staticAddBitmap("scores", "furn", new ScoresFurnitureBmd);
			BitmapStorage.staticAddBitmap("scores", "glue", new ScoresGlueBmd);
			BitmapStorage.staticAddBitmap("scores", "bomb", new ScoresBombsBmd);
			BitmapStorage.staticAddBitmap("scores", "rope", new ScoresRopesBmd);
			BitmapStorage.staticAddBitmap("scores", "hei", new ScoresHeiBmd);
			
			BitmapStorage.staticAddZone("btns");
			BitmapStorage.staticAddBitmap("btns", "ktty_1", new KittyButtonBmd);
			BitmapStorage.staticAddBitmap("btns", "ktty_2", new BlockedKittyBmd);
			BitmapStorage.staticAddBitmap("btns", "hd_rply", new ButtonHeadReplayBmd);
			BitmapStorage.staticAddBitmap("btns", "hd_mm", new ButtonHeadMMBmd);
			BitmapStorage.staticAddBitmap("btns", "hd_ply", new ButtonHeadPlayBmd);
			BitmapStorage.staticAddBitmap("btns", "krzhk", new KruzhokBmd);
			BitmapStorage.staticAddBitmap("btns", "scrnsht", new ScreenshotBmd);
			BitmapStorage.staticAddBitmap("btns", "mm", new BackMMBmd);
			BitmapStorage.staticAddBitmap("btns", "mt", new MuteBmd);
		}
		private function ef(e:Event):void {
			shaker.step();
			buttons.step();
			exchanges.step();
			if (worldWorkFlag) world.step();
			if (scoresWorkFlag) scores.step();
			if (mainMenuWorkFlag) mainMenu.step();
		}
	}
}
