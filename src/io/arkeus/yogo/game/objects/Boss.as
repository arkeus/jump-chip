package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.GameState;
	import io.arkeus.yogo.game.player.Explosion;
	import io.arkeus.yogo.title.OutroState;
	import io.arkeus.yogo.util.LevelText;
	import io.arkeus.yogo.util.Registry;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.Ax;
	import io.axel.input.AxKey;
	import io.axel.particle.AxParticleSystem;
	
	public class Boss extends Enemy {
		private static const SPEED:uint = 100;
		
		public function Boss(x:uint, y:uint) {
			super(x, y, Resource.BOSS);
			hp = 7;
		}
		
		override public function update():void {
			if (touching & LEFT) {
				velocity.x = SPEED;
			} else if (touching & RIGHT) {
				velocity.x = -SPEED;
			}
			
			// Probably leave this in for people who cant beat the boss
			if (Ax.keys.held(AxKey.L) && Ax.keys.pressed(AxKey.F) && solid) {
				destroy();
			}
			
			super.update();
			facing = velocity.x < 0 ? LEFT : RIGHT;
		}
		
		override public function start():void {
			velocity.x = -SPEED;
		}
		
		override protected function shoot():void {
			return;
		}
		
		override public function destroy():void {
			if (!solid) {
				return;
			}
			SoundSystem.play("die");
			AxParticleSystem.emit("explosion", x, y);
			Ax.camera.shake(0.2, 3);
			solid = false;
			Registry.game.explosions.add(new Explosion(x, y, 2));
			Registry.game.doug.invincible = true;
			
			Registry.coins += Registry.game.coinsCollected;
			
			Registry.game.doug.addTimer(4, function():void {
				Ax.camera.fadeOut(0.5, 0xff000000, function():void {
					Ax.states.change(new OutroState);
					Ax.camera.fadeIn(0.5);
				});
			});
			
			super.destroy();
		}
	}
}