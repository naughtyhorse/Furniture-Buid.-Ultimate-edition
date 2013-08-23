package game {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import game.factory.CrateVariants;
	import game.factory.struct.CrateVariant;
	import game.factory.struct.CrateVariantPolygon;
	import game.lays.AllObjectsLay;
	import game.lays.BackgroundLay;
	import game.lays.ControlButtonsLay;
	import game.lays.DialogLay;
	import game.lays.GfxLay;
	import game.lays.GuiLay;
	import game.managing.BitmapStorage;
	import game.managing.Screenshooter;
	import game.managing.Shaker;
	import game.managing.SoundsManager;
	import game.managing.WorldMover;
	import game.objects.CrateObject;
	import game.objects.GlueObject;
	import game.objects.PickupObject;
	import game.objects.RopeObject;
	import game.objects.ThermiteBomb;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.callbacks.PreCallback;
	import nape.callbacks.PreFlag;
	import nape.callbacks.PreListener;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import nape.space.Space;
	import nape.util.Debug;
	import nape.util.ShapeDebug;
	import social.VkWallPostAnswer;
	
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class World extends Sprite {
		static const PLATFORM_WIDTH:Number = 600;
		static const PIXELS_PER_METER:Number = 70;
		
		static const SPAWN_CRATE:int = 1;
		static const SPAWN_BOMB:int = 2;
		static const SPAWN_GLUE:int = 3;
		static const SPAWN_ROPE:int = 4;
		
		static const HARD_IMPACT_SOUND_BORDER:Number = 100;
		static const SOFT_IMPACT_SOUND_BORDER:Number = 5;
		
		// physics
		private var space:Space;
		private var material:Material;
		
		private var platform:Body;
		private var platformJoint:PivotJoint;
		
		private var ghostCrate:Body;
		private var ghostInts:int;
		
		private var physObjects:Vector.<Body>;
		
		private var debug:Debug;
		
		private var toDispose:Vector.<Body>;
		
		// cb / listeners
		private var crateIntListener:InteractionListener;
		private var crateCb:CbType = new CbType();
		private var gameOverIntListener:InteractionListener;
		private var gameOverCb:CbType = new CbType();
		private var ghostIntListener:PreListener;
		private var ghostCb:CbType = new CbType();
		private var ghostIntInListener:InteractionListener;
		private var ghostIntOutListener:InteractionListener;
		private var ghostTempCb:CbType = new CbType();
		private var bombIntListener:InteractionListener;
		private var bombCb:CbType = new CbType();
		private var glueIntListener:InteractionListener;
		private var glueCb:CbType = new CbType();
		private var glueTargetCb:CbType = new CbType();
		private var ropePipeTargetCb:CbType = new CbType();
		private var ropeLinkCb:CbType = new CbType();
		private var ropeLinkIntListener:PreListener;
		private var ropeLinkGhostIntListener:PreListener;
		private var pickupCb:CbType = new CbType();
		private var pickupIntListener:PreListener;
		
		// managing
		private var crateVariants:CrateVariants;
		private var mover:WorldMover;
		
		// lays
		private var background:BackgroundLay;
		private var allObjectsLay:AllObjectsLay;
		private var gfx:GfxLay
		private var gui:GuiLay;
		private var dialogLay:DialogLay;
		public var controlLay:ControlButtonsLay;
		
		// tools
		private var ghostBomb:Body;
		private var ghostGlue:Body;
		private var ghostRopePipe:RopeObject;
		private var ropes:Vector.<RopeObject>;
		
		// gui
		private var platformBm:Bitmap;
		
		// flags
		private var spawnMode:int = 0;
		private var allSleeps:Boolean = true;
		private var spawnVisible:Boolean = true;
		private var spawnPickupWindow:Boolean = true;
		private var gamePaused:Boolean = false;
		
		// counters
		private var trys:int = 10;
		private var gluesC:int = 1;
		private var bombsC:int = 1;
		private var ropesC:int = 1;
		
		// shit
		private var spawnPickupChance:Number = 18;
		
		// scores counters
		private var totalFurniture:int = 0;
		private var totalGlue:int = 0;
		private var totalBombs:int = 0;
		private var totalRopes:int = 0;
		
		// publics
		public var onGameOver:Function = null;
		
		// temps / etc
		private var _i:int;
		private var _j:int;
		private var _tempBl:BodyList;
		private var _updateUpBorderTrigger:Boolean = false;
		private var _tempSpawnMode:int = -1;
		
		public function World():void {
			super();
		}
		public function init():void {
			initPhysics();
			initLays();
			initManaging();
			initGui();
			initTools();
			initCbListeners();
			
			mover.updateUpperLimit();
			
			crateVariants.generateRandomCrateVariant();
			gui.init(crateVariants.currentVariant.bitmapDataGui);
			gui.spawnGui.onLeft = onGuiSpawnLeft;
			gui.spawnGui.onRight = onGuiSpawnRight;
			SpawnMode = SPAWN_CRATE;
		}
		private function initPhysics():void {
			space = new Space(Vec2.get(0, 800));
			material = Material.wood();
			material.elasticity = .1;
			material.dynamicFriction = .3;
			
			
			platform = new Body(BodyType.DYNAMIC);
			platform.shapes.add(new Polygon(Polygon.rect((stage.stageWidth - PLATFORM_WIDTH) / 2, stage.stageHeight - 50, PLATFORM_WIDTH, 20), material));
			platform.space = space;
			platform.cbTypes.add(crateCb);
			platform.allowRotation = false;
			var v:Vec2 = Vec2.get();
			platformJoint = new PivotJoint(platform, space.world, v, platform.localPointToWorld(v));
			platformJoint.space = space;
			platformJoint.maxForce = Number.MAX_VALUE;
			
			var gameOverBody:Body = new Body(BodyType.STATIC);
			gameOverBody.shapes.add(new Polygon(Polygon.rect(- stage.stageWidth * 10, stage.stageHeight, stage.stageWidth * 21, 20), material));
			gameOverBody.space = space;
			gameOverBody.cbTypes.add(gameOverCb);
			
			physObjects = new Vector.<Body>;
			
			toDispose = new Vector.<Body>;
			
			/*debug = new ShapeDebug(stage.stageWidth, stage.stageHeight);
			//debug.drawConstraints = true;
			stage.addChild(debug.display);*/
		}
		private function initManaging():void {
			crateVariants = new CrateVariants();
			mover = new WorldMover(background, allObjectsLay, gfx);
		}
		private function initLays():void {
			background = new BackgroundLay();
			addChild(background);
			background.init();
			allObjectsLay = new AllObjectsLay(stage.stageWidth, stage.stageHeight);
			addChild(allObjectsLay);
			gfx = new GfxLay(stage.stageWidth, stage.stageHeight);
			addChild(gfx);
			gui = new GuiLay();
			addChild(gui);
			dialogLay = new DialogLay();
			addChild(dialogLay);
			controlLay = new ControlButtonsLay();
			addChild(controlLay);
			controlLay.x = stage.stageWidth - controlLay.width + 10;
			controlLay.y = stage.stageHeight - controlLay.height + 10;
			controlLay.onScreenshot = makeScreenshot;
		}
		private function onGuiSpawnLeft():void {
			switch(_tempSpawnMode) {
				case SPAWN_CRATE:
					_tempSpawnMode = SPAWN_ROPE;
					gui.spawnGui.onRope();
					break;
				case SPAWN_GLUE:
					_tempSpawnMode = SPAWN_CRATE;
					gui.spawnGui.onFurniture();
					break;
				case SPAWN_BOMB:
					_tempSpawnMode = SPAWN_GLUE;
					gui.spawnGui.onGlue();
					break;
				case SPAWN_ROPE:
					_tempSpawnMode = SPAWN_BOMB;
					gui.spawnGui.onBomb();
					break;
			}
		}
		private function onGuiSpawnRight():void {
			switch(_tempSpawnMode) {
				case SPAWN_CRATE:
					_tempSpawnMode = SPAWN_GLUE;
					gui.spawnGui.onGlue();
					break;
				case SPAWN_GLUE:
					_tempSpawnMode = SPAWN_BOMB;
					gui.spawnGui.onBomb();
					break;
				case SPAWN_BOMB:
					_tempSpawnMode = SPAWN_ROPE;
					gui.spawnGui.onRope();
					break;
				case SPAWN_ROPE:
					_tempSpawnMode = SPAWN_CRATE;
					gui.spawnGui.onFurniture();
					break;
			}
		}
		private function initGui():void {
			platformBm = new Bitmap(BitmapStorage.staticGetBitmap("gui", "pltfrm"));
			allObjectsLay.objects.addChild(platformBm);
			platformBm.x = (stage.stageWidth - platformBm.width) / 2;
			platformBm.y = stage.stageHeight - 60;
		}
		private function initTools():void {
			ropes = new Vector.<RopeObject>;
		}
		private function initCbListeners():void {
			crateIntListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, crateCb, crateCb, crateIntHandler);
			crateIntListener.space = space;
			gameOverIntListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, crateCb, gameOverCb, gameOverIntHandler);
			gameOverIntListener.space = space;
			ghostIntListener = new PreListener(InteractionType.COLLISION, ghostCb, crateCb, ghostIntHandler);
			ghostIntListener.space = space;
			ghostIntInListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, ghostTempCb, crateCb, ghostIntInHandler);
			ghostIntInListener.space = space;
			ghostIntOutListener = new InteractionListener(CbEvent.END, InteractionType.COLLISION, ghostTempCb, crateCb, ghostIntOutHandler);
			ghostIntOutListener.space = space;
			bombIntListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, bombCb, crateCb, bombIntHandler);
			bombIntListener.space = space;
			glueIntListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, glueCb, glueTargetCb, glueIntHandler);
			glueIntListener.space = space;
			ropeLinkIntListener = new PreListener(InteractionType.COLLISION, ropeLinkCb, ropeLinkCb, ropeLinkIntHandler);
			ropeLinkIntListener.space = space;
			ropeLinkGhostIntListener = new PreListener(InteractionType.COLLISION, ghostCb, ropeLinkCb, ropeLinkIntHandler);
			ropeLinkGhostIntListener.space = space;
			pickupIntListener = new PreListener(InteractionType.COLLISION, crateCb, pickupCb, pickupIntHandler);
			pickupIntListener.space = space;
		}
		private function crateIntHandler(_cb:InteractionCallback):void {
			if (Math.abs(_cb.int1.castBody.constraintVelocity.x) >= HARD_IMPACT_SOUND_BORDER || Math.abs(_cb.int1.castBody.constraintVelocity.y) >= HARD_IMPACT_SOUND_BORDER)
				SoundsManager.playHardImpactSound(_cb.int1.castBody.position.x);
			else if (Math.abs(_cb.int2.castBody.constraintVelocity.x) >= HARD_IMPACT_SOUND_BORDER || Math.abs(_cb.int2.castBody.constraintVelocity.y) >= HARD_IMPACT_SOUND_BORDER)
				SoundsManager.playHardImpactSound(_cb.int1.castBody.position.x);
			else if (Math.abs(_cb.int1.castBody.constraintVelocity.x) >= SOFT_IMPACT_SOUND_BORDER || Math.abs(_cb.int1.castBody.constraintVelocity.y) >= SOFT_IMPACT_SOUND_BORDER)
				SoundsManager.playSoftImpactSound(_cb.int1.castBody.position.x);
			else if (Math.abs(_cb.int2.castBody.constraintVelocity.x) >= SOFT_IMPACT_SOUND_BORDER || Math.abs(_cb.int2.castBody.constraintVelocity.y) >= SOFT_IMPACT_SOUND_BORDER)
				SoundsManager.playSoftImpactSound(_cb.int1.castBody.position.x);
		}
		private function gameOverIntHandler(_cb:InteractionCallback):void {
			if (_cb.int1.castBody.userData[0] is CrateObject) {
				SoundsManager.playBreakSound(_cb.int1.castBody.position.x);
				trys--;
				gui.trysGui.trys.Text = String(trys);
				Shaker.staticAddShake(gui.trysGui.trys, 2, .5);
				if (trys == 0) {
					if (onGameOver !== null) onGameOver(totalFurniture, totalGlue, totalBombs, totalRopes, gui.heiGui.HeiS);
					Shaker.staticCancelShake(this);
					return;
				}
			}
			destroyCrate(_cb.int1.castBody);
		}
		private function ghostIntHandler(_cb:PreCallback):PreFlag {
			return PreFlag.IGNORE;
		}
		private function ropeLinkIntHandler(_cb:PreCallback):PreFlag {
			return PreFlag.IGNORE;
		}
		private function pickupIntHandler(_cb:PreCallback):PreFlag {
			if (_cb.int1.castBody.userData[0] is CrateObject) {
				gfx.spawnSparks((_cb.int2.castBody.userData[0] as PickupObject).tool.x, (_cb.int2.castBody.userData[0] as PickupObject).tool.y - gfx.cont.y, 5);
				(_cb.int2.castBody.userData[0] as PickupObject).dispose();
				toDispose[toDispose.length] = _cb.int2.castBody;
				switch((_cb.int2.castBody.userData[0] as PickupObject).toolType) {
					case PickupObject.TOOL_TYPE_BOMB: gui.spawnGui.BombCount = ++bombsC; break;
					case PickupObject.TOOL_TYPE_GLUE: gui.spawnGui.GlueCount = ++gluesC; break;
					case PickupObject.TOOL_TYPE_ROPE: gui.spawnGui.RopeCount = ++ropesC; break;
					case PickupObject.TOOL_TYPE_HEART: 
						trys++;
						gui.trysGui.trys.Text = String(trys);
						Shaker.staticAddShake(gui.trysGui.trys, 2, .5);
						break;
				}
				gfx.spawnStars(_cb.int2.castBody.position.x, _cb.int2.castBody.position.y, 10);
				spawnPickupWindow = true;
				SoundsManager.playPickup();
				for (_i = 0; _i < physObjects.length; _i++ )
					if (physObjects[_i] == _cb.int2.castBody) {
						physObjects.splice(_i, 1);
						return PreFlag.IGNORE;
					}
			}
			return PreFlag.IGNORE;
		}
		private function ghostIntInHandler(_cb:InteractionCallback):void {
			ghostInts++;
			if (_cb.int2.castBody.userData[0])
				_cb.int2.castBody.userData[0]["banSign"].visible = true;
		}
		private function ghostIntOutHandler(_cb:InteractionCallback):void {
			ghostInts--;
			if (_cb.int2.castBody.userData[0])
				_cb.int2.castBody.userData[0]["banSign"].visible = false;
		}
		private function bombIntHandler(_cb:InteractionCallback):void {
			if (_cb.int2.castBody !== platform) {
				SoundsManager.playBreakSound(_cb.int2.castBody.position.x);
				destroyCrate(_cb.int2.castBody);
				_cb.int1.castBody.space = null;
				_cb.int1.castBody.userData[0]["dispose"]();
				for (_i = 0; _i < physObjects.length; _i++ )
					if (physObjects[_i] == _cb.int1.castBody) {
						physObjects.splice(_i, 1);
						return;
					}
			}
		}
		private function glueIntHandler(_cb:InteractionCallback):void {
			SoundsManager.playGlueTargetSound(_cb.int2.castBody.position.x);
			(_cb.int2.castBody.userData[0] as CrateObject).freeze();
			_cb.int2.castBody.cbTypes.remove(glueTargetCb);
			(_cb.int1.castBody.userData[0] as GlueObject).dispose();
			_cb.int1.castBody.space = null;
			for (_i = 0; _i < physObjects.length; _i++ )
				if (physObjects[_i] == _cb.int1.castBody) {
					physObjects.splice(_i, 1);
					return;
				}
		}
		private function ropePipeIntHandler(_cb:PreCallback):PreFlag {
			return PreFlag.IGNORE;
		}
		private function destroyCrate(_body:Body):void {
			if (_body.userData[0]) {
				gfx.spawnDebris(_body.position.x, _body.position.y, 5);
				gfx.spawnPoofCloud(_body.position.x, _body.position.y);
				gfx.spawnPoof(_body.position.x, _body.position.y);
				_body.space = null;
				_body.userData[0]["dispose"]();
				Shaker.staticAddShake(this, 2, .5);
				for (_i = 0; _i < physObjects.length; _i++ )
					if (physObjects[_i] == _body) {
						physObjects.splice(_i, 1);
						if (_body.userData[0] is CrateObject)
							for (_j = 0; _j < (_body.userData[0] as CrateObject).ropes.length; _j++ )
								destroyRope((_body.userData[0] as CrateObject).ropes[_j], _body);
						return;
					}
			}
		}
		private function destroyRope(_rope:RopeObject, _skipBody:Body):void {
			var i:int;
			for (i = 0; i < physObjects.length; i++ )
				if (physObjects[i].userData[0] is CrateObject)
					if (physObjects[i] !== _skipBody)
						for (var j:int = 0; j < (physObjects[i].userData[0] as CrateObject).ropes.length; j++ )
							if ((physObjects[i].userData[0] as CrateObject).ropes[j] == _rope)
								(physObjects[i].userData[0] as CrateObject).ropes.splice(j--, 1);
			for (i = 0; i < ropes.length; i++ )
				if (ropes[i] == _rope) {
					ropes.splice(i, 1);
					_rope.dispose();
					return;
				}
		}
		public function initListeners():void {
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		public function disposeListeners():void {
			stage.removeEventListener(MouseEvent.CLICK, onClick);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onClick(e:MouseEvent):void {
			if (ghostInts == 0) switch(spawnMode) {
				case SPAWN_CRATE:
					reifyGhostCrate();
					spawnGhostCrate();
					break;
				case SPAWN_BOMB:
					if (bombsC > 0) {
						reifyGhostBomb();
						spawnGhostBomb();
					}
					break;
				case SPAWN_GLUE:
					if (gluesC) {
						reifyGhostGlue();
						spawnGhostGlue();
					}
					break;
				case SPAWN_ROPE: if (ropesC) reifyGhostRopePipe(); break;
			}
			else SoundsManager.playSpawnForbiddenSound(stage.mouseX);
		}
		private function keyDownListener(e:KeyboardEvent):void {
			trace("e.keyCode = " + e.keyCode);
			switch(e.keyCode) {
				case 32: onRotate(); SoundsManager.playSwingSound(stage.mouseX); break;
				case 87:
				case 38: mover.upBtnOn = true; dialogLay.removeScrollHint(); break;
				case 83:
				case 40: mover.downBtnOn = true; break;
				case 65: onGuiSpawnLeft(); break;
				case 68: onGuiSpawnRight(); break;
			}
		}
		private function keyUpListener(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 87:
				case 38: mover.upBtnOn = false; break;
				case 83:
				case 40: mover.downBtnOn = false; break;
				case 49:
					if (spawnVisible) SpawnMode = SPAWN_CRATE;
					else _tempSpawnMode = SPAWN_CRATE;
					gui.spawnGui.onFurniture();
				break;
					case 50:
					if (spawnVisible) SpawnMode = SPAWN_GLUE;
					else _tempSpawnMode = SPAWN_GLUE;
					gui.spawnGui.onGlue();
				break;
					case 51:
					if (spawnVisible) SpawnMode = SPAWN_BOMB;
					else _tempSpawnMode = SPAWN_BOMB;
					gui.spawnGui.onBomb();
				break;
					case 52:
					if (spawnVisible) SpawnMode = SPAWN_ROPE;
					else _tempSpawnMode = SPAWN_ROPE;
					gui.spawnGui.onRope();
				break;
			}
		}
		private function onMouseMove(e:MouseEvent):void {
			SpawnVisible = !gui.spawnGround.hitTestPoint(stage.mouseX, stage.mouseY)
			&& !gui.heiGround.hitTestPoint(stage.mouseX, stage.mouseY)
			&& !gui.trysGround.hitTestPoint(stage.mouseX, stage.mouseY)
			&& stage.mouseY < 530
			&& !gamePaused;
		}
		private function onRotate():void {
			switch(spawnMode) {
				case SPAWN_CRATE: if (ghostCrate) ghostCrate.rotate(Vec2.weak(), 90 * Math.PI / 180); break;
				case SPAWN_BOMB: if (ghostBomb) ghostBomb.rotate(Vec2.weak(), 90 * Math.PI / 180); break;
				case SPAWN_GLUE: if (ghostGlue) ghostGlue.rotate(Vec2.weak(), 90 * Math.PI / 180); break;
			}
		}
		private function spawnPickup(_x:Number, _y:Number, _type:int):void {
			if (spawnPickupWindow) {
				spawnPickupWindow = false;
				var _pup:Body = new Body(BodyType.DYNAMIC);
				_pup.shapes.add(new Circle(30));
				_pup.align();
				_pup.space = space;
				_pup.cbTypes.add(pickupCb);
				_pup.allowMovement = _pup.allowRotation = false;
				_pup.position.set(Vec2.weak(_x, _y));
				var _rf:Sprite = new Sprite();
				var _rfbm:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("gfx", "flash_r"), "auto", true);
				_rf.addChild(_rfbm);
				_rfbm.x = -77;
				_rfbm.y = -56;
				allObjectsLay.signs.addChild(_rf);
				_rf.x = _x;
				_rf.y = _y;
				var _yf:Sprite = new Sprite();
				var _yfbm:Bitmap = new Bitmap(BitmapStorage.staticGetBitmap("gfx", "flash_y"), "auto", true);
				_yf.addChild(_yfbm);
				_yfbm.x = -50;
				_yfbm.y = -37;
				allObjectsLay.signs.addChild(_yf);
				_yf.x = _x;
				_yf.y = _y;
				var _tl:Sprite = new Sprite();
				var _tlBm:Bitmap;
				switch(_type) {
					case PickupObject.TOOL_TYPE_GLUE: _tlBm = new Bitmap(BitmapStorage.staticGetBitmap("tls", "glue"), "auto", true); break;
					case PickupObject.TOOL_TYPE_BOMB: _tlBm = new Bitmap(BitmapStorage.staticGetBitmap("tls", "bomb"), "auto", true); break;
					case PickupObject.TOOL_TYPE_ROPE: _tlBm = new Bitmap(BitmapStorage.staticGetBitmap("tls", "pckup_rp"), "auto", true); break;
					case PickupObject.TOOL_TYPE_HEART: _tlBm = new Bitmap(BitmapStorage.staticGetBitmap("tls", "hrt"), "auto", true); break;
				}
				_tl.addChild(_tlBm);
				_tlBm.x = -_tlBm.width / 2;
				_tlBm.y = -_tlBm.height / 2;
				allObjectsLay.signs.addChild(_tl);
				_tl.x = _x;
				_tl.y = _y;
				var _pupObj:PickupObject = new PickupObject(_rf, _yf, _tl);
				_pupObj.toolType = _type;
				_pup.userData[0] = _pupObj;
				physObjects[physObjects.length] = _pup;
			}
		}
		private function spawnGhostCrate():void {
			ghostCrate = new Body(BodyType.DYNAMIC);
			for (_i = 0; _i < crateVariants.currentVariant.polygons.length; _i++ )
				switch(crateVariants.currentVariant.polygons[_i].type) {
					case CrateVariantPolygon.TYPE_RECTANGLE:
						ghostCrate.shapes.add(new Polygon(Polygon.rect(crateVariants.currentVariant.polygons[_i].x, crateVariants.currentVariant.polygons[_i].y, crateVariants.currentVariant.polygons[_i].width, crateVariants.currentVariant.polygons[_i].height), material));
						break;
					case CrateVariantPolygon.TYPE_CIRCLE: ghostCrate.shapes.add(new Circle(crateVariants.currentVariant.polygons[_i].radius, null, material)); break;
					case CrateVariantPolygon.TYPE_CUSTOM: ghostCrate.shapes.add(new Polygon(crateVariants.currentVariant.polygons[_i].vertex, material)); break;
				}
			ghostCrate.align();
			ghostCrate.space = space;
			ghostCrate.cbTypes.add(ghostCb);
			ghostCrate.cbTypes.add(ghostTempCb);
			ghostCrate.allowMovement = ghostCrate.allowRotation = false;
			ghostCrate.position.set(Vec2.weak(stage.mouseX, stage.mouseY));
			var newCrateObject:CrateObject = new CrateObject(crateVariants.currentVariant, ghostCrate);
			ghostCrate.userData[0] = newCrateObject;
			newCrateObject.graphics.x = ghostCrate.position.x;
			newCrateObject.graphics.y = ghostCrate.position.y + allObjectsLay.y; /* ##################3 */
			allObjectsLay.signs.addChild(newCrateObject.graphics);
			newCrateObject.graphics.alpha = .5;
		}
		private function reifyGhostCrate():void {
			if (ghostCrate) {
				gfx.spawnSparks(stage.mouseX, stage.mouseY - gfx.cont.y, 5);
				gui.heiGui.ShowCheck = true;
				crateVariants.generateRandomCrateVariant();
				gui.spawnGui.setGuiCrateBmd(crateVariants.currentVariant.bitmapDataGui);
				(ghostCrate.userData[0] as CrateObject).graphics.alpha = 1;
				(ghostCrate.userData[0] as CrateObject).reify(allObjectsLay.signs);
				ghostCrate.allowMovement = ghostCrate.allowRotation = true;
				ghostCrate.cbTypes.remove(ghostCb);
				ghostCrate.cbTypes.remove(ghostTempCb);
				ghostCrate.cbTypes.add(crateCb);
				ghostCrate.cbTypes.add(glueTargetCb);
				ghostCrate.cbTypes.add(ropePipeTargetCb);
				allObjectsLay.objects.addChild((ghostCrate.userData[0] as CrateObject).graphics);
				physObjects[physObjects.length] = ghostCrate;
				ghostCrate = null;
				_updateUpBorderTrigger = true;
				totalFurniture++;
				SoundsManager.playSpawnSound(stage.mouseX);
			}
		}
		private function spawnGhostBomb():void {
			ghostBomb = new Body(BodyType.DYNAMIC);
			ghostBomb.shapes.add(new Polygon(Polygon.rect(0, 0, 26, 55), material));
			ghostBomb.align();
			ghostBomb.space = space;
			ghostBomb.cbTypes.add(ghostCb);
			ghostBomb.cbTypes.add(ghostTempCb);
			ghostBomb.allowMovement = ghostBomb.allowRotation = false;
			ghostBomb.position.set(Vec2.weak(stage.mouseX, stage.mouseY));
			var _bombObj:ThermiteBomb = new ThermiteBomb(ghostBomb);
			ghostBomb.userData[0] = _bombObj;
			_bombObj.graphics.x = ghostBomb.position.x;
			_bombObj.graphics.y = ghostBomb.position.y + allObjectsLay.y; /* ##################3 */
			allObjectsLay.signs.addChild(_bombObj.graphics);
			_bombObj.graphics.alpha = .5;
		}
		private function reifyGhostBomb():void {
			if (ghostBomb) {
				gfx.spawnSparks(stage.mouseX, stage.mouseY - gfx.cont.y, 5);
				gui.heiGui.ShowCheck = true;
				(ghostBomb.userData[0] as ThermiteBomb).graphics.alpha = 1;
				(ghostBomb.userData[0] as ThermiteBomb).reify(allObjectsLay.signs);
				ghostBomb.allowMovement = ghostBomb.allowRotation = true;
				ghostBomb.cbTypes.remove(ghostCb);
				ghostBomb.cbTypes.remove(ghostTempCb);
				ghostBomb.cbTypes.add(crateCb);
				ghostBomb.cbTypes.add(bombCb);
				allObjectsLay.objects.addChild((ghostBomb.userData[0] as ThermiteBomb).graphics);
				physObjects[physObjects.length] = ghostBomb;
				ghostBomb = null;
				_updateUpBorderTrigger = true;
				gui.spawnGui.BombCount = --bombsC;
				totalBombs++;
				SoundsManager.playSpawnSound(stage.mouseX);
			}
		}
		private function spawnGhostGlue():void {
			ghostGlue = new Body(BodyType.DYNAMIC);
			ghostGlue.shapes.add(new Polygon(Polygon.rect(0, 0, 34, 56), material));
			ghostGlue.align();
			ghostGlue.space = space;
			ghostGlue.cbTypes.add(ghostCb);
			ghostGlue.cbTypes.add(ghostTempCb);
			ghostGlue.allowMovement = ghostGlue.allowRotation = false;
			ghostGlue.position.set(Vec2.weak(stage.mouseX, stage.mouseY));
			var _glueObj:GlueObject = new GlueObject(ghostGlue);
			ghostGlue.userData[0] = _glueObj;
			_glueObj.graphics.x = ghostGlue.position.x;
			_glueObj.graphics.y = ghostGlue.position.y + allObjectsLay.y; /* ##################3 */
			allObjectsLay.signs.addChild(_glueObj.graphics);
			_glueObj.graphics.alpha = .5;
		}
		private function reifyGhostGlue():void {
			if (ghostGlue) {
				gfx.spawnSparks(stage.mouseX, stage.mouseY - gfx.cont.y, 5);
				gui.heiGui.ShowCheck = true;
				(ghostGlue.userData[0] as GlueObject).graphics.alpha = 1;
				(ghostGlue.userData[0] as GlueObject).reify(allObjectsLay.signs);
				ghostGlue.allowMovement = ghostGlue.allowRotation = true;
				ghostGlue.cbTypes.remove(ghostCb);
				ghostGlue.cbTypes.remove(ghostTempCb);
				ghostGlue.cbTypes.add(crateCb);
				ghostGlue.cbTypes.add(glueCb);
				allObjectsLay.objects.addChild((ghostGlue.userData[0] as GlueObject).graphics);
				physObjects[physObjects.length] = ghostGlue;
				ghostGlue = null;
				_updateUpBorderTrigger = true;
				gui.spawnGui.GlueCount = --gluesC;
				totalGlue++;
				SoundsManager.playSpawnSound(stage.mouseX);
			}
		}
		private function spawnGhostRopePipe():void {
			ghostRopePipe = new RopeObject();
			ghostRopePipe.beginPipeGrphcs.x = stage.mouseX;
			ghostRopePipe.beginPipeGrphcs.y = stage.mouseY - allObjectsLay.y; /* ##################3 */
			allObjectsLay.signs.addChild(ghostRopePipe.beginPipeGrphcs);
			ghostRopePipe.beginPipeGrphcs.alpha = .5;
		}
		private function reifyGhostRopePipe():void {
			if (ghostRopePipe) {
				gui.heiGui.ShowCheck = true;
				_tempBl = space.bodiesUnderPoint(Vec2.get(stage.mouseX, stage.mouseY - allObjectsLay.y)); /* ##################3 */
				if (ghostRopePipe.endPipeGrphcs) {
					if (_tempBl.length == 1) {
						if (_tempBl.at(0).cbTypes.has(ropePipeTargetCb)) {
							if (ghostRopePipe.reifyEnding(_tempBl.at(0))) {
								gfx.spawnSparks(stage.mouseX, stage.mouseY - gfx.cont.y, 5);
								(_tempBl.at(0).userData[0] as CrateObject).graphics.addChild(ghostRopePipe.endPipeGrphcs);
								ghostRopePipe.endPipeGrphcs.x = (_tempBl.at(0).userData[0] as CrateObject).graphics.mouseX;
								ghostRopePipe.endPipeGrphcs.y = (_tempBl.at(0).userData[0] as CrateObject).graphics.mouseY;
								ropes[ropes.length] = ghostRopePipe;
								(ghostRopePipe.targetBody1.userData[0] as CrateObject).ropes.push(ghostRopePipe);
								(ghostRopePipe.targetBody2.userData[0] as CrateObject).ropes.push(ghostRopePipe);
								ghostRopePipe.initRope(ropeLinkCb, ghostCb);
								ghostRopePipe.ropeLay = new flash.display.Shape();
								allObjectsLay.ropes.addChild(ghostRopePipe.ropeLay);
								spawnGhostRopePipe();
								gui.spawnGui.RopeCount = --ropesC;
								totalRopes++;
								SoundsManager.playRopeTargetSound(stage.mouseX);
							} else {
								allObjectsLay.signs.addChild(ghostRopePipe.beginPipeGrphcs);
							}
						} else {
							ghostRopePipe.dropPipe();
							allObjectsLay.signs.addChild(ghostRopePipe.beginPipeGrphcs);
						}
					} else {
						ghostRopePipe.dropPipe();
						allObjectsLay.signs.addChild(ghostRopePipe.beginPipeGrphcs);
					}
				} else {
					if (_tempBl.length == 1) if (_tempBl.at(0).cbTypes.has(ropePipeTargetCb)) {
						gfx.spawnSparks(stage.mouseX, stage.mouseY - gfx.cont.y, 5);
						ghostRopePipe.reifyBegining(allObjectsLay.signs, 0, _tempBl.at(0));
						ghostRopePipe.beginPipeGrphcs.alpha = 1;
						(_tempBl.at(0).userData[0] as CrateObject).graphics.addChild(ghostRopePipe.beginPipeGrphcs);
						ghostRopePipe.beginPipeGrphcs.x = (_tempBl.at(0).userData[0] as CrateObject).graphics.mouseX;
						ghostRopePipe.beginPipeGrphcs.y = (_tempBl.at(0).userData[0] as CrateObject).graphics.mouseY;
						allObjectsLay.signs.addChild(ghostRopePipe.endPipeGrphcs);
						SoundsManager.playRopeCastSound(stage.mouseX);
					}
				}
				_updateUpBorderTrigger = true;
			}
		}
		private function removeGhostBody():void {
			if (ghostCrate) {
				allObjectsLay.signs.removeChild((ghostCrate.userData[0] as CrateObject).graphics);
				ghostCrate.space = null;
				ghostCrate = null;
			}
			if (ghostBomb) {
				allObjectsLay.signs.removeChild((ghostBomb.userData[0] as ThermiteBomb).graphics);
				ghostBomb.space = null;
				ghostBomb = null;
			}
			if (ghostGlue) {
				allObjectsLay.signs.removeChild((ghostGlue.userData[0] as GlueObject).graphics);
				ghostGlue.space = null;
				ghostGlue = null;
			}
			if (ghostRopePipe) {
				ghostRopePipe.dispose();
				ghostRopePipe = null;
			}
		}
		private function makeScreenshot():void {
			if (!gamePaused) {
				SpawnVisible = false;
				gamePaused = true;
				gui.visible = false;
				dialogLay.visible = false;
				controlLay.visible = false;
				Supreme.vk.wallPost(Supreme.vk.CurrentPlayerId, "Какая большая куча ненужной мебели: vk.com/go_fuck_yourself", new <BitmapData>[Screenshooter.getBitmap(this, gui.heiGui.HeiS)], onScreenshotDone);
				//var _bm:Bitmap = new Bitmap(Screenshooter.getBitmap(this, gui.heiGui.HeiS));
				gui.visible = true;
				dialogLay.visible = true;
				controlLay.visible = true;
				//addChild(_bm);
			}
		}
		private function onScreenshotDone(_ans:VkWallPostAnswer):void {
			gamePaused = false;
		}
		public function step():void {
			if (!gamePaused) {
				space.step(1 / 60);
				mover.step();
				background.step();
				gui.step();
				gfx.step();
				dialogLay.step();
				controlLay.step();
				/*debug.clear();
				debug.draw(space);*/
				if (ghostCrate) {
					ghostCrate.position.setxy(stage.mouseX, stage.mouseY - allObjectsLay.y);
					(ghostCrate.userData[0] as CrateObject).step();
				}
				if (ghostBomb) {
					ghostBomb.position.setxy(stage.mouseX, stage.mouseY - allObjectsLay.y);
					(ghostBomb.userData[0] as ThermiteBomb).step();
				}
				if (ghostGlue) {
					ghostGlue.position.setxy(stage.mouseX, stage.mouseY - allObjectsLay.y);
					(ghostGlue.userData[0] as GlueObject).step();
				}
				if (ghostRopePipe) {
					ghostRopePipe.step(allObjectsLay.y); /* ##################3 */
				}
				stepPhysObjects();
			}
		}
		private function stepPhysObjects():void {
			allSleeps = true;
			for (_i = 0; _i < physObjects.length; _i++ ) {
				physObjects[_i].userData[0]["step"]();
				if (Math.abs(physObjects[_i].velocity.x) + Math.abs(physObjects[_i].velocity.y) > .2 || physObjects[_i].type !== BodyType.DYNAMIC)
					allSleeps = false;
			}
			for (_i = 0; _i < ropes.length; _i++ )
				ropes[_i].step(0);
			if (_updateUpBorderTrigger && allSleeps) {
				_updateUpBorderTrigger = false;
				mover.updateUpperLimit();
				gui.heiGui.Hei = (allObjectsLay.objects.height - platformBm.height) / PIXELS_PER_METER;
				gui.heiGui.ShowCheck = false;
				if (Math.random() * 100 <= spawnPickupChance) {
					var _r:Number = Math.random() * 100;
					switch(true) {
						case (_r <= 35):
							spawnPickup(platformBm.x + 100 + Math.random() * (platformBm.width - 200), - mover.upperMoveLimit + 60, 1);
							break;
						case (_r > 35 && _r <= 70):
							spawnPickup(platformBm.x + 100 + Math.random() * (platformBm.width - 200), - mover.upperMoveLimit + 60, 2);
							break;
						case (_r > 70 && _r <= 90):
							spawnPickup(platformBm.x + 100 + Math.random() * (platformBm.width - 200), - mover.upperMoveLimit + 60, 3);
							break;
						default:
							spawnPickup(platformBm.x + 100 + Math.random() * (platformBm.width - 200), - mover.upperMoveLimit + 60, 4);
					}
				}
				spawnPickupChance += .15;
				if (mover.upperMoveLimit > 0)
					dialogLay.spawnScrollHint();
			}
			for (_i = 0; _i < toDispose.length; _i++ ) {
				toDispose[_i].space = null;
				toDispose.splice(_i--, 1);
			}
		}
		public function set SpawnMode(value:int):void {
			spawnMode = value;
			removeGhostBody();
			switch(spawnMode) {
				case SPAWN_CRATE: spawnGhostCrate(); break;
				case SPAWN_BOMB: spawnGhostBomb(); break;
				case SPAWN_GLUE: spawnGhostGlue(); break;
				case SPAWN_ROPE: spawnGhostRopePipe(); break;
			}
		}
		public function set SpawnVisible(value:Boolean):void {
			if (value) {
				if (_tempSpawnMode >= 0) {
					SpawnMode = _tempSpawnMode;
					_tempSpawnMode = -1;
				}
			} else
				if (_tempSpawnMode == -1) {
					_tempSpawnMode = spawnMode;
					SpawnMode = -1;
				}
			spawnVisible = value;
		}
	}
}
