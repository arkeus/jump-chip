package io.arkeus.yogo.game.player {
	import io.arkeus.yogo.assets.Resource;
	import io.axel.Ax;
	import io.axel.AxPoint;
	import io.axel.input.AxKey;

	public class Alice extends Player {
		public function Alice(start:AxPoint) {
			super(start, Resource.ALICE);
			facing = RIGHT;
			faction = ALICE;
		}
		
		override public function start():void {
			super.start();
			velocity.x = SPEED;
		}
		
		override protected function get pressedJumpKey():Boolean {
			return Ax.keys.pressed(AxKey.A) || Ax.keys.pressed(AxKey.LEFT) || Ax.keys.pressed(AxKey.Q);
		}
	}
}
