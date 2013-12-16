package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;
	import io.axel.particle.AxParticleSystem;

	public class Bullet extends Entity {
		private static const SPEED:uint = 150;
		
		public var friendly:Boolean;
		
		public function Bullet(x:Number, y:Number, direction:uint, friendly:Boolean) {
			super(0, 0, Resource.BULLET, 5, 3);
			initialize(x, y, direction, friendly);
		}
		
		public function initialize(x:Number, y:Number, direction, friendly):void {
			this.x = this.previous.x = x;
			this.y = this.previous.y = y;
			velocity.x = direction == LEFT ? -SPEED : SPEED;
			touching = 0;
			this.friendly = friendly;
			show(friendly ? 1 : 0);
		}
		
		override public function update():void {
			if (touching > 0) {
				destroy();
			}
			super.update();
		}
		
		override public function collide(player:Player):void {
			if (collided || friendly) {
				return;
			}
			player.destroy();
			destroy();
			collided = true;
		}
		
		override public function destroy():void {
			AxParticleSystem.emit(friendly ? "bullet-red" : "bullet-red", x, y);
			super.destroy();
		}
	}
}
