package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;

	public class Blade extends Entity {
		public static const HORIZONTAL:uint = 0;
		public static const VERTICAL:uint = 1;
		
		private static const SPEED:uint = 160;
		private var dir:uint;
		
		public function Blade(x:uint, y:uint, dir:uint) {
			super(x, y, Resource.BLADE);
			this.dir = dir;
			
			width = height = 8;
			offset.x = offset.y = 4;
			this.x += 4;
			this.y += 4;
		}
		
		override public function update():void {
			if (touching & LEFT) {
				velocity.x = SPEED;
			} else if (touching & RIGHT) {
				velocity.x = -SPEED;
			} else if (touching & UP) {
				velocity.y = SPEED;
			} else if (touching & DOWN) {
				velocity.y = -SPEED;
			}
			
			super.update();
		}
		
		override public function start():void {
			super.start();
			
			if (dir == HORIZONTAL) {
				velocity.x = SPEED;
			} else {
				velocity.y = SPEED;
			}
		}
		
		override public function collide(player:Player):void {
			player.destroy();
		}
	}
}
