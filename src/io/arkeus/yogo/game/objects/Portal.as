package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;

	public class Portal extends Entity {
		public function Portal(x:uint, y:uint, faction:uint) {
			super(x, y, Resource.PORTAL, 16, 16);
			this.faction = faction;
			show(faction == Player.ALICE ? 0 : 1);
			
			width = height = 4;
			offset.x = offset.y = 6;
			this.x += 6;
			this.y += 6;
		}
		
		override public function collide(player:Player):void {
			if (collided || player.faction != faction) {
				return;
			}
			
			collided = true;
			player.teleport();
		}
	}
}
