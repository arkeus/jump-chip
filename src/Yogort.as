package {
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import io.arkeus.yogo.title.TitleState;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.Ax;
	
	[SWF(width = "800", height = "640", backgroundColor = "#000000")]
	
	public class Yogort extends Ax {
		private static const ALLOWED_URLS:Array = [
			"Users/Lee",
			"axgl.org",
			"axel.io",
		];
		
		public function Yogort() {
			var allowed:Boolean = false;
			for each(var url:String in ALLOWED_URLS) {
				if (root.loaderInfo.url.indexOf(url) >= 0) {
					allowed = true;
				}
			}
			
			super(TitleState, 800, 640, 2);
			
			if (!allowed) {
				navigateToURL(new URLRequest("http://arkeus.io"), "_self");
				throw new Error("Invalid");
			}
		}
		
		override public function create():void {
			Ax.background.hex = 0xff414141;
			
			// debug
			//Ax.pauseState = null;
			//Ax.unfocusedFramerate = 60;
			//Ax.soundMuted = true;
			//Ax.musicMuted = true;
			Ax.debuggerEnabled = true;
			
			SoundSystem.initialize();
		}
	}
}
