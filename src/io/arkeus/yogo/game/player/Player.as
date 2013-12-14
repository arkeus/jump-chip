package io.arkeus.yogo.game.player {
	import io.arkeus.yogo.game.Entity;
	import io.axel.Ax;
	import io.axel.AxPoint;
	import io.axel.input.AxKey;

	public class Player extends Entity {
		public static const SPEED:uint = 50;
		public static const ALICE:uint = 0;
		public static const DOUG:uint = 1;
		
		public static const JUMP_SPEED:int = -250;
		public static const BOUNCE_SPEED:int = -250;
		
		public var teleported:Boolean = false;
		public var started:Boolean = false;
		
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
				teleport();
			}
			
			if (touching & RIGHT) {
				velocity.x = -SPEED;
			} else if (touching & LEFT) {
				velocity.x = SPEED;
			}
			
			if (started && Ax.keys.pressed(key) && touching & DOWN) {
				velocity.y = JUMP_SPEED;
			}
			
			if (velocity.x < 0) {
				facing = LEFT;
			} else if (velocity.x > 0) {
				facing = RIGHT;
			}
		}
		
		public function start():void {
			started = true;
		}
		
		public function teleport():void {
			teleported = true;
			effects.grow(1, 0.01, 4).fadeOut(1);
			facing = RIGHT;
			velocity.x = 0;
			velocity.y = -50;
			acceleration.y = 0;
		}
		
		public function get frozen():Boolean {
			return teleported;
		}
		
		protected function get key():uint {
			return 0;
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
			}
		}
	}
}
