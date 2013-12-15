package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.World;
	import io.arkeus.yogo.game.player.Player;
	import io.arkeus.yogo.util.Registry;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.particle.AxParticleSystem;
	import io.axel.tilemap.AxTile;

	public class Blocker extends Entity {
		public function Blocker(x:uint, y:uint, faction:uint) {
			super(x, y, Resource.BLOCKER, 16, 16);
			this.faction = faction;
			centerOrigin();
			show(faction == Player.ALICE ? 0 : 1);
		}
		
		override public function collide(player:Player):void {
			if (collided || player.faction != faction) {
				return;
			}
			
			AxParticleSystem.emit(faction == Player.ALICE ? "coin-pink" : "coin-blue", this.x + 3, this.y + 3);
			
			SoundSystem.play("bricker");
			show(2);
			collided = true;
			Registry.game.world.getTile(tileID);
			var world:World = Registry.game.world;
			for (var y:uint = 0; y < world.rows; y++) {
				for (var x:uint = 0; x < world.cols; x++) {
					var tile:AxTile = world.getTileAt(x, y);
					if (tile == null || tile.index != tileID) {
						continue;
					}
					world.setTileAt(x, y, 10);
					AxParticleSystem.emit(faction == Player.ALICE ? "brick-pink" : "brick-blue", x * World.TILE_SIZE, y * World.TILE_SIZE);
				}
			}
		}
		
		private function get tileID():uint {
			return faction == Player.ALICE ? 7 : 8;
		}
	}
}
