package io.arkeus.yogo.game.player {
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.objects.Bullet;
	import io.arkeus.yogo.game.objects.Enemy;
	import io.arkeus.yogo.game.objects.Heart;
	import io.arkeus.yogo.util.Registry;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.Ax;
	import io.axel.AxPoint;
	import io.axel.input.AxKey;
	import io.axel.particle.AxParticleSystem;

	public class Player extends Entity {
		public static const SPEED:uint = 50;
		public static const SUPER_SPEED:uint = 100;
		public static const ALICE:uint = 0;
		public static const DOUG:uint = 1;
		
		public static const DOUBLE_JUMP:uint = 1;
		public static const GUN:uint = 2;
		
		public static const JUMP_SPEED:int = -250;
		public static const BOUNCE_SPEED:int = -250;
		public static const SHOOT_DELAY:Number = 0.4;
		
		public var teleported:Boolean = false;
		public var failed:Boolean = false;
		public var dead:Boolean = false;
		public var lastTeleport:uint = 0;
		
		public var supersized:Boolean = false;
		public var chips:uint = 0;
		public var invincible:Boolean = false;
		public var freezed:Boolean = false;
		
		public var shootTimer:Number = 0;
		
		public function Player(start:AxPoint, resource:Class) {
			super(start.x, start.y, resource, 16, 24);
			
			animations.add("walk", [0, 1, 2, 3, 4, 5], 8);
			animate("walk");
			
			height = 16;
			offset.y = 8;
			width = 14;
			offset.x = 1;
			
			acceleration.y = 600;
			origin.x = animations.frameWidth / 2;
			origin.y = animations.frameHeight / 2;
		}
		
		override public function update():void {
			handleMovement();
			
			super.update();
		}
		
		private function handleMovement():void {
			if (frozen) {
				return;
			}
			
			if (Ax.keys.pressed(AxKey.S)) {
				//teleport();
			} else if (Ax.keys.pressed(AxKey.R)) {
				destroy();
			}
			
			if (!supersized) {
				if (touching & RIGHT) {
					velocity.x = -SPEED;
					SoundSystem.play("hit-side");
				} else if (touching & LEFT) {
					velocity.x = SPEED;
					SoundSystem.play("hit-side");
				}
			}
			
			if (pvelocity.y > 0 && velocity.y == 0) {
				SoundSystem.play("fall");
			}
			
			if (started) {
				if (!supersized) {
					if (pressedJumpKey && touching & DOWN) {
						jump();
					}
				} else {
					if (Ax.keys.held(AxKey.A) || Ax.keys.held(AxKey.Q) || Ax.keys.held(AxKey.LEFT)) {
						velocity.x = -SUPER_SPEED;
					} else if (Ax.keys.held(AxKey.D) || Ax.keys.held(AxKey.RIGHT)) {
						velocity.x = SUPER_SPEED;
					} else {
						velocity.x = 0;
					}
					if ((Ax.keys.pressed(AxKey.W) || Ax.keys.pressed(AxKey.UP)) && touching & DOWN) {
						jump();
					}
					if (Ax.keys.held(AxKey.SPACE) && shootTimer <= 0) {
						shoot();
						shootTimer = SHOOT_DELAY;
					}
				}
			}
			
			shootTimer -= Ax.dt;
			
			if (velocity.x < 0) {
				facing = LEFT;
			} else if (velocity.x > 0) {
				facing = RIGHT;
			}
			
			if (x < -20 || x > Ax.viewWidth + 20 || y < -20 || y > Ax.viewHeight + 20) {
				destroy();
			}
		}
		
		private function shoot():void {
			SoundSystem.play("shoot");
			var bullet:Bullet = Enemy.getBullet(center.x, y + 4, facing, true);
		}
		
		private function jump():void {
			velocity.y = JUMP_SPEED;
			if (faction == ALICE) {
				SoundSystem.play("alice-jump");
			} else {
				SoundSystem.play("doug-jump");
			}
		}
		
		public function freeze():void {
			freezed = true;
			acceleration.y = 0;
		}
		
		public function teleport():void {
			teleported = true;
			effects.grow(1, 0.01, 4).fadeOut(1);
			facing = RIGHT;
			velocity.x = 0;
			velocity.y = -50;
			acceleration.y = 0;
			solid = false;
			SoundSystem.play("portal");
		}
		
		public function get frozen():Boolean {
			return teleported || failed || freezed;
		}
		
		protected function get pressedJumpKey():Boolean {
			return false;
		}
		
		private static const BOUNCE_PAD:uint = 1;
		private var booped:uint = 0;
		
		override public function collide(player:Player):void {
			if (booped == Ax.now) {
				return;
			}
			booped = Ax.now;
			
			var top:Player = player.y < y ? player : this;
			var bottom:Player = player.y < y ? this : player;
			
			if (top.right > left + BOUNCE_PAD && top.left < right - BOUNCE_PAD && top.velocity.y > 0) {
				top.velocity.y = BOUNCE_SPEED;
				top.y = bottom.y - top.height;
				SoundSystem.play("boop");
			}
			
			if (Math.abs(top.y - bottom.y) < 5 && Registry.game.level > 4) {
				var center:uint = top.right < bottom.right ? top.right : bottom.right;
				Registry.game.add(new Heart(center - 3, bottom.y));
			}
		}
		
		public function fail():void {
			failed = true;
			velocity.x = 0;
		}
		
		public function supersize():void {
			supersized = true;
		}
		
		override public function destroy():void {
			if (dead || teleported || invincible) {
				return;
			}
			
			SoundSystem.play("die");
			AxParticleSystem.emit("explosion", x, y);
			Ax.camera.shake(0.2, 3);
			dead = true;
			solid = false;
			Registry.game.explosions.add(new Explosion(x, y, faction));
			super.destroy();
		}
	}
}
