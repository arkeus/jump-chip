package io.arkeus.yogo.util {
	import io.axel.Ax;
	import io.axel.sound.AxSound;

	public class SoundSystem {
		public static const VOLUME:Number = 0.5;
		
		public static var music:AxSound;
		public static var musicClass:Class;
		
		private static var sounds:Object = {};
		private static var initialized:Boolean = false;
		
		public static function playMusic(klass:Class):void {
			if (klass == musicClass || Ax.musicMuted) {
				return;
			} else if (music != null) {
				music.destroy();
				music.dispose();
			}
			musicClass = klass;
			music = Ax.playMusic(klass, VOLUME);
			music.volume = Ax.musicMuted ? 0 : VOLUME;
		}
		
		public static function play(soundName:String):void {
			if (sounds[soundName] == null || Ax.soundMuted) {
				return;
			}
			(sounds[soundName] as SfxrSynth).play();
		}
		
		public static function create(soundName:String, parameters:String):void {
			if (Ax.soundMuted) {
				return;
			}
			var sound:SfxrSynth = new SfxrSynth;
			sound.params.setSettingsString(parameters);
			sound.cacheSound();
			sounds[soundName] = sound;
		}
		
		public static function mute():void {
			Ax.musicMuted = true;
			Ax.soundMuted = true;
		}
		
		public static function unmute():void {
			Ax.musicMuted = false;
			Ax.soundMuted = false;
		}
		
		public static function toggleMute():Boolean {
			if (Ax.musicMuted) {
				unmute();
				return false;
			} else {
				mute();
				return true;
			}
		}
		
		public static function initialize():void {
			if (initialized) {
				return;
			}
			
			create("alice-jump", "0,,0.1338,,0.1517,0.4261,,0.2939,,,,,,0.2395,,,,,1,,,,,0.5");
			create("doug-jump", "0,,0.1338,,0.1517,0.29,,0.2939,,,,,,0.2395,,,,,1,,,,,0.5");
			create("portal", "0,,0.3588,,0.53,0.3642,,0.28,,,,,,0.1117,,0.5564,,,1,,,,,0.5");
			create("teleport", "0,,0.0325,,0.42,0.4929,,0.2567,,,,,,0.0649,,0.5859,,,1,,,,,0.5");
			create("coin", "0,,0.0911,0.5624,0.36,0.81,,,,,,0.4545,0.6689,,,,,,1,,,,,0.5");
			create("bricker", "0,,0.063,0.5581,0.4238,0.6665,,,,,,0.3851,0.5849,,,,,,1,,,,,0.5");
			create("select", "0,,0.1608,,0.21,0.4606,,0.26,,,,,,0.1114,,,,,1,,,0.1,,0.4");
			create("start", "0,,0.0801,0.4943,0.42,0.4829,,,0.26,,,0.3607,0.5744,,,,,,1,,,,,0.5");
			create("die", "3,,0.3077,0.7116,0.41,0.15,,-0.2387,,,,,,,,0.5274,,,1,,,,,0.5");
			create("boop", "0,,0.1025,,0.233,0.3083,,0.2456,,,,,,0.4922,,,,,0.6054,,,,,0.5");
			create("hit-side", "0,,0.2036,,0.15,0.3083,,0.2526,,,,,,0.0444,,,,,1,,,,,0.3");
			create("fall", "3,,0.01,,0.2002,0.4477,,-0.6689,,,,,,,,,,,1,,,0.0852,,0.35");
		}
	}
}
