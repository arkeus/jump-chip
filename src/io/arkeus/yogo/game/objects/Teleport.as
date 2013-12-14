package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;
	import io.axel.Ax;

	public class Teleport extends Entity {
		public var other:Teleport;
		
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
			if (!collided) {
				scale.x = scale.y = Math.cos(Ax.now / 500) / 10 + 0.9;
			}
			
			super.update();
		}
		
		override public function collide(player:Player):void {
			if (collided) {
				return;
			} else if (Math.abs(player.center.x - center.x) > 2) {
				return;
			} else if (Ax.now - player.lastTeleport < 500) {
				return;
			}
			
			player.lastTeleport = Ax.now;
			collided = true;
			
			var dx:Number = player.x - x;
			var dy:Number = player.y - y;
			player.x = other.x + dx;
			player.y = other.y + dy;
		}
	}
}
