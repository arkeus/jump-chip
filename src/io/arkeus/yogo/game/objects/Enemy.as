package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;
	import io.arkeus.yogo.util.Registry;
	import io.arkeus.yogo.util.SoundSystem;
	
	public class Enemy extends Entity {
		public var hp:int = 1;
		
		public function Enemy(x:uint, y:uint, resource:Class = null) {
			super(x, y, resource || Resource.ENEMY, 16, 24);
			
			animations.add("walk", [0, 1, 2, 3, 4, 5], 8);
			animate("walk");
			
			height = 16;
			offset.y = 8;
			width = 14;
			offset.x = 1;
			
			this.x += offset.x;
			
			addTimer(1.8, function():void {
				if (Math.abs(center.y - Registry.game.doug.center.y) < 100) {
					shoot();
				}
			}, 0);
		}
		
		override public function update():void {
			if (center.x < Registry.game.doug.center.x) {
				facing = RIGHT;
			} else {
				facing = LEFT;
			}
			super.update();
		}
		
		override public function collide(player:Player):void {
			if (collided) {
				return;
			}
			player.destroy();
			collided = true;
		}
		
		protected function shoot():void {
			SoundSystem.play("enemy-shoot");
			var bullet:Bullet = getBullet(center.x, y + 4, facing, false);
		}
		
		public static function getBullet(x:Number, y:Number, direction:uint, friendly:Boolean):Bullet {
			var bullet:Bullet = Registry.game.bullets.recycle() as Bullet;
			if (bullet == null) {
				bullet = new Bullet(0, 0, 0, true);
				Registry.game.bullets.add(bullet);
			}
			bullet.initialize(x, y, direction, friendly);
			return bullet;
		}
		
		override public function hit():void {
			hp -= 1;
			effects.flash(0.1, 0xffff0000);
			if (hp <= 0) {
				if (!(this is Boss)) {
					SoundSystem.play("enemy-die");
				}
				destroy();
			}
		}
	}
}


