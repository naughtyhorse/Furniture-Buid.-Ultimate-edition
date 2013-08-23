package game.managing {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Andrew Rahimov
	 */
	public final class SoundsManager {
		
		private static var wid:Number;
		
		private static var softImpact1:Sound;
		private static var softImpact2:Sound;
		private static var softImpact3:Sound;
		private static var hardImpact1:Sound;
		private static var hardImpact2:Sound;
		
		private static var spawn1:Sound;
		private static var spawn2:Sound;
		private static var spawn3:Sound;
		private static var spawn4:Sound;
		private static var spawn5:Sound;
		
		private static var ropeCast1:Sound;
		private static var ropeCast2:Sound;
		private static var ropeTarget1:Sound;
		private static var ropeTarget2:Sound;
		
		private static var glue1:Sound;
		private static var glue2:Sound;
		
		private static var buttonClick:Sound;
		private static var buttonOver:Sound;
		
		private static var break1:Sound;
		private static var break2:Sound;
		private static var break3:Sound;
		private static var break4:Sound;
		private static var break5:Sound;
		private static var break6:Sound;
		private static var break7:Sound;
		private static var break8:Sound;
		private static var break9:Sound;
		
		private static var swing1:Sound;
		private static var swing2:Sound;
		private static var swing3:Sound;
		
		private static var soundtrack:Sound;
		private static var sndtrckChannel:SoundChannel;
		
		private static var pickup:Sound;
		
		private static var _st:SoundTransform;
		private static var mute:Boolean = false;
		private static var _rNum:Number = 0;
		
		private static var _tempVol:Number;
		
		public static function init(_wid:Number):void {
			wid = _wid;
			_st = new SoundTransform();
			softImpact1 = new SoftImpact1Sound;
			softImpact2 = new SoftImpact2Sound;
			softImpact3 = new SoftImpact3Sound;
			hardImpact1 = new HardImpact1Sound;
			hardImpact2 = new HardImpact2Sound;
			spawn1 = new Spawn1Sound;
			spawn2 = new Spawn2Sound;
			spawn3 = new Spawn3Sound;
			spawn4 = new Spawn4Sound;
			spawn5 = new Spawn5Sound;
			ropeCast1 = new RopeCast1Sound;
			ropeCast2 = new RopeCast2Sound;
			ropeTarget1 = new RopeTarget1Sound;
			ropeTarget2 = new RopeTarget2Sound;
			glue1 = new GlueTarget1Sound;
			glue2 = new GlueTarget2Sound;
			buttonClick = new ButtonClickSound;
			buttonOver = new ButtonOverSound;
			break1 = new Break1Sound;
			break2 = new Break2Sound;
			break3 = new Break3Sound;
			break4 = new Break4Sound;
			break5 = new Break5Sound;
			break6 = new Break6Sound;
			break7 = new Break7Sound;
			break8 = new Break8Sound;
			break9 = new Break9Sound;
			swing1 = new Swing1Sound;
			swing2 = new Swing2Sound;
			swing3 = new Swing3Sound;
			soundtrack = new Soundtrack;
			pickup = new PickupSound;
		}
		public static function playPickup():void {
			if (!mute) pickup.play();
		}
		public static function playSoundtrack():void {
			if (!mute) {
				sndtrckChannel = soundtrack.play(0, int.MAX_VALUE);
			}
		}
		public static function setSoundtrackVolume(_vol:Number):void {
			if (_vol > 0)_tempVol = _vol;
			sndtrckChannel.soundTransform = new SoundTransform(_vol);
		}
		public static function playSoftImpactSound(_x:Number):void {
			if (!mute) {
				_st.pan = calcPanarama(_x);
				switch(Math.round(Math.random() * 2)) {
					case 0: softImpact1.play(0, 0, _st); break;
					case 1: softImpact2.play(0, 0, _st); break;
					case 2: softImpact3.play(0, 0, _st); break;
				}
			}
		}
		public static function playHardImpactSound(_x:Number):void {
			if (!mute) {
				_st.pan = calcPanarama(_x);
				switch(Math.round(Math.random())) {
					case 0: hardImpact1.play(0, 0, _st); break;
					case 1: hardImpact2.play(0, 0, _st); break;
				}
			}
		}
		public static function playSpawnSound(_x:Number):void {
			if (!mute) {
				_rNum = Math.round(Math.random() * 5);
				_st.pan = calcPanarama(_x);
				switch(true) {
					case (_rNum >= 0 && _rNum < 4): spawn1.play(0, 0, _st); break;
					case (_rNum == 4): spawn2.play(0, 0, _st); break;
					case (_rNum == 5): spawn3.play(0, 0, _st); break;
					/*case (_rNum == 6): spawn4.play(0, 0, _st); break;
					case (_rNum == 7): spawn5.play(0, 0, _st); break;*/
				}
			}
		}
		public static function playSpawnForbiddenSound(_x:Number):void {
			if (!mute) {
				_st.pan = calcPanarama(_x);
				switch(Math.round(Math.random())) {
					case 0: spawn4.play(0, 0, _st); break;
					case 1: spawn5.play(0, 0, _st); break;
				}
			}
		}
		public static function playRopeCastSound(_x:Number):void {
			if (!mute) {
				_st.pan = calcPanarama(_x);
				switch(Math.round(Math.random())) {
					case 0: ropeCast1.play(0, 0, _st); break;
					case 1: ropeCast2.play(0, 0, _st); break;
				}
			}
		}
		public static function playRopeTargetSound(_x:Number):void {
			if (!mute) {
				_st.pan = calcPanarama(_x);
				switch(Math.round(Math.random())) {
					case 0: ropeTarget1.play(0, 0, _st); break;
					case 1: ropeTarget2.play(0, 0, _st); break;
				}
			}
		}
		public static function playGlueTargetSound(_x:Number):void {
			if (!mute) {
				_st.pan = calcPanarama(_x);
				switch(Math.round(Math.random())) {
					case 0: glue1.play(0, 0, _st); break;
					case 1: glue2.play(0, 0, _st); break;
				}
			}
		}
		public static function playButtonClickSound():void {
			if (!mute) buttonClick.play();
		}
		public static function playButtonOverSound():void {
			if (!mute) buttonOver.play();
		}
		public static function playBreakSound(_x:Number):void {
			if (!mute) {
				_st.pan = calcPanarama(_x);
				switch(Math.round(Math.random() * 8)) {
					case 0: break1.play(0, 0, _st); break;
					case 1: break2.play(0, 0, _st); break;
					case 2: break3.play(0, 0, _st); break;
					case 3: break4.play(0, 0, _st); break;
					case 4: break5.play(0, 0, _st); break;
					case 5: break6.play(0, 0, _st); break;
					case 6: break7.play(0, 0, _st); break;
					case 7: break8.play(0, 0, _st); break;
					case 8: break9.play(0, 0, _st); break;
				}
			}
		}
		public static function playSwingSound(_x:Number):void {
			if (!mute) {
				_st.pan = calcPanarama(_x);
				switch(Math.round(Math.random() * 2)) {
					case 0: swing1.play(0, 0, _st); break;
					case 1: swing2.play(0, 0, _st); break;
					case 2: swing3.play(0, 0, _st); break;
				}
			}
		}
		private static function calcPanarama(_x:Number):Number {
			return -.9 + (_x / wid) * 1.8;
		}
		public static function set Mute(value:Boolean):void {
			mute = value;
			if (mute)
				setSoundtrackVolume(0);
			else setSoundtrackVolume(_tempVol);
		}
		public static function get Mute():Boolean {
			return mute;
		}
	}
}
