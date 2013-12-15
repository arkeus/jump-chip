package {
	import io.arkeus.yogo.title.TitleState;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.Ax;
	
	[SWF(width = "800", height = "640", backgroundColor = "#000000")]
	
	public class Yogort extends Ax {
		public function Yogort() {
			super(TitleState, 800, 640, 2);
		}
		
		override public function create():void {
			Ax.background.hex = 0xff414141;
			
			// debug
			Ax.pauseState = null;
			Ax.unfocusedFramerate = 60;
			Ax.soundMuted = true;
			Ax.musicMuted = true;
			Ax.debuggerEnabled = true;
			
			SoundSystem.initialize();
		}
	}
}
