package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.World;
	import io.arkeus.yogo.util.Registry;
	import io.axel.AxGroup;
	import io.axel.particle.AxParticleSystem;
	import io.axel.tilemap.AxTile;

	public class DynamicLaser extends Entity {
		private static const SPEED:uint = 60;
		
		private var initialized:Boolean = false;
		private var beam:LaserBeam;
		
		public function DynamicLaser(x:uint, y:uint) {
			super(x, y, Resource.LASER);
			
			var self:DynamicLaser = this;
			addTimer(0.1, function():void {
				AxParticleSystem.emit("spark-down", self.x + 6, self.y + 4);
			}, 0);
		}
		
		override public function update():void {
			if (!started) {
				super.update();
				return;
			}
			
			if (!initialized) {
				initialize();
				initialized = true;
			}
			
			updateBeam();
			if (touching & LEFT) {
				velocity.x = SPEED;
			} else if (touching & RIGHT) {
				velocity.x = -SPEED;
			}
			
			if (beam != null) {
				beam.x = x + 7;
			}
			
			super.update();
		}
		
		override public function draw():void {
			if (beam != null) {
				beam.x = x + 7;
			}
			super.draw();
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
			beam = new LaserBeam((x + 7) / World.TILE_SIZE, (y + 4) / World.TILE_SIZE, 100);
			beam.scale.y = height / 100;
			(parent as AxGroup).add(beam);
			
			addTimer(0.05, function():void {
				AxParticleSystem.emit("spark-up", beam.x, beam.y + beam.height).velocity.x = velocity.x;
			}, 0);
			
			velocity.x = -SPEED;
		}
		
		private function updateBeam():void {
			var tx:uint = (x + 7) / World.TILE_SIZE;
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
			beam.scale.y = height / 100;
			beam.height = height;
		}
	}
}
