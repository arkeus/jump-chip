package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.World;
	import io.arkeus.yogo.util.Registry;
	import io.axel.AxGroup;
	import io.axel.particle.AxParticleSystem;
	import io.axel.tilemap.AxTile;

	public class Laser extends Entity {
		private var initialized:Boolean = false;
		
		public function Laser(x:uint, y:uint) {
			super(x, y, Resource.LASER);
			solid = false;
			
			var self:Laser = this;
			addTimer(0.1, function():void {
				AxParticleSystem.emit("spark-down", self.x + 6, self.y + 4);
			}, 0);
		}
		
		override public function update():void {
			if (!initialized) {
				initialize();
				initialized = true;
			}
			
			super.update();
		}
		
		private function initialize():void {
			var tx:uint = x / World.TILE_SIZE;
			var ty:uint = y / World.TILE_SIZE;
			var world:World = Registry.game.world;
			
			while (ty < World.HEIGHT) {
				var tile:AxTile = world.getTileAt(tx, ty);
				if (tile != null && tile.collision != NONE) {
					break;
				}
				ty++;
			}
			
			var height:uint = ty * World.TILE_SIZE - y - 4;
			var beam:LaserBeam = new LaserBeam((x + 7) / World.TILE_SIZE, (y + 4) / World.TILE_SIZE, height);
			(parent as AxGroup).add(beam);
			
			addTimer(0.05, function():void {
				AxParticleSystem.emit("spark-up", beam.x, beam.y + beam.height);
			}, 0);
		}
	}
}
