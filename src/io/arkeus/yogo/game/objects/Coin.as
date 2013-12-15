package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.Ax;
	import io.axel.AxU;
	import io.axel.particle.AxParticleSystem;

	public class Coin extends Entity {
		private var delay:Number;
		
		public function Coin(x:uint, y:uint, faction:uint) {
			super(x, y, Resource.COIN, 16, 16);
			this.faction = faction;
			show(faction == Player.ALICE ? 0 : 1);
			delay = AxU.rand(150, 350);
			width = height = 10;
			offset.x = offset.y = 3;
			this.x += offset.y;
			this.y += offset.y;
			origin.x = animations.frameWidth / 2;
			origin.y = animations.frameHeight / 2;
		}
		
		override public function update():void {
			if (!collided) {
				alpha = Math.cos(Ax.now / delay) / 4 + 0.75;
				scale.x = scale.y = Math.cos(Ax.now / 500) / 10 + 0.9;
			}
			
			super.update();
		}
		
		override public function collide(player:Player):void {
			if (collided || player.faction != faction) {
				return;
			}
			SoundSystem.play("coin");
			AxParticleSystem.emit(faction == Player.ALICE ? "coin-pink" : "coin-blue", x, y);
			effects.grow(0.4, 4, 4).fadeOut(0.4, 0, destroy);
			collided = true;
		}
	}
}
