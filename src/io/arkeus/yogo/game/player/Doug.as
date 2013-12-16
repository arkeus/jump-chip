package io.arkeus.yogo.game.player {
	import io.arkeus.yogo.assets.Resource;
	import io.axel.Ax;
	import io.axel.AxPoint;
	import io.axel.input.AxKey;
	
	public class Doug extends Player {
		public function Doug(start:AxPoint) {
			super(start, Resource.DOUG);
			facing = LEFT;
			faction = DOUG;
		}
		
		override public function start():void {
			super.start();
			velocity.x = -SPEED;
		}
		
		override protected function get pressedJumpKey():Boolean {
			return Ax.keys.pressed(AxKey.D) || Ax.keys.pressed(AxKey.RIGHT);
		}
	}
}