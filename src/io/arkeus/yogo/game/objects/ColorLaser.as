package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;
	import io.axel.Ax;

	public class ColorLaser extends Entity {
		public function ColorLaser(x:uint, y:uint, faction:uint) {
			super(x, y, faction == Player.ALICE ? Resource.PINK_LASER : Resource.BLUE_LASER, 16, 16);
			this.faction = faction;
			animations.add("laser", [0, 1, 2, 3], 20);
			animate("laser");
		}
		
		override public function update():void {
			alpha = Math.cos(Ax.now / 200) / 4 + 0.75;
			super.update();
		}
		
		override public function collide(player:Player):void {
			if (player.faction != faction) {
				player.destroy();
			}
		}
	}
}
