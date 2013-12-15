package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.Ax;
	import io.axel.particle.AxParticleSystem;

	public class Teleport extends Entity {
		public var other:Teleport;
		private var growing:Boolean = false;
		
		public function Teleport(x:uint, y:uint) {
			super(x, y, Resource.TELEPORT);
			velocity.a = 180;
			centerOrigin();
		}
		
		public function link(other:Teleport):void {
			this.other = other;
			other.other = this;
		}
		
		override public function update():void {
			if (!collided && !growing) {
				scale.x = scale.y = Math.cos(Ax.now / 500) / 10 + 0.9;
			}
			
			if (growing) {
				velocity.a += Ax.dt * 500;
			} else if (velocity.a > 180) {
				velocity.a -= Ax.dt * 500;
			}
			
			super.update();
		}
		
		override public function collide(player:Player):void {
			if (Math.abs(player.center.x - center.x) > 2) {
				return;
			} else if (Ax.now - player.lastTeleport < 500) {
				return;
			}
			
			AxParticleSystem.emit("coin-blue", x + 3, y + 3);
			AxParticleSystem.emit("coin-pink", x + 3, y + 3);
			
			player.lastTeleport = Ax.now;
			
			var dx:Number = player.x - x;
			var dy:Number = player.y - y;
			player.x = other.x + dx;
			player.y = other.y + dy;
			
			teleportGrow();
			other.teleportGrow();
			SoundSystem.play("teleport");
		}
		
		public function teleportGrow():void {
			growing = true;
			effects.clear(true).grow(0.4, 3, 3, function():void {
				effects.grow(0.4, 1, 1, function():void {
					growing = false;
				});
			})
		}
	}
}
