package {
	import io.arkeus.yogo.game.GameState;
	import io.axel.Ax;
	
	[SWF(width = "800", height = "640", backgroundColor = "#000000")]
	
	public class Yogort extends Ax {
		public function Yogort() {
			super(GameState, 800, 640, 2);
		}
		
		override public function create():void {
			Ax.background.hex = 0xffdddddd;
			Ax.pauseState = null;
			Ax.unfocusedFramerate = 60;
		}
	}
}
