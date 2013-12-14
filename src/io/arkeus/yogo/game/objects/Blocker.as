package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.Registry;
	import io.arkeus.yogo.game.World;
	import io.arkeus.yogo.game.player.Player;
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
				}
			}
		}
		
		private function get tileID():uint {
			return faction == Player.ALICE ? 7 : 8;
		}
	}
}
