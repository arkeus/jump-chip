package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;
	import io.arkeus.yogo.util.Registry;
	import io.axel.particle.AxParticleSystem;

	public class Portal extends Entity {
		public function Portal(x:uint, y:uint, faction:uint) {
			super(x, y, Resource.PORTAL, 16, 16);
			this.faction = faction;
			show(faction == Player.ALICE ? 0 : 1);
			
			width = height = 4;
			offset.x = offset.y = 6;
			this.x += 6;
			this.y += 6;
			
			var self:Portal = this;
			addTimer(0.1, function():void {
				var name:String = faction == Player.ALICE ? "portal-pink" : "portal-blue";
				if (collided) {
					name += "-complete";
				}
				AxParticleSystem.emit(name, self.x - offset.x, self.y - offset.y);
			}, 0);
		}
		
		override public function collide(player:Player):void {
			if (collided || player.failed || (player.faction != faction && !player.supersized)) {
				return;
			}
			
			if (player.supersized && player.faction == faction) {
				player.fail();
				Registry.game.add(new Heart(player.center.x - 3, player.y, true));
				Registry.game.wrongPortal = true;
				addTimer(1, function():void {
					player.destroy();
				});
				return;
			}
			
			collided = true;
			player.teleport();
		}
	}
}
