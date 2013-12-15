package io.arkeus.yogo.game {
	import io.arkeus.yogo.game.background.BackgroundSet;
	import io.arkeus.yogo.game.player.Alice;
	import io.arkeus.yogo.game.player.Doug;
	import io.arkeus.yogo.game.player.Player;
	import io.arkeus.yogo.game.world.WorldBuilder;
	import io.axel.Ax;
	import io.axel.AxEntity;
	import io.axel.AxGroup;
	import io.axel.collision.AxGrid;
	import io.axel.input.AxKey;
	import io.axel.state.AxState;

	public class GameState extends AxState {
		public var world:World;
		public var players:AxGroup;
		public var alice:Player;
		public var doug:Player;
		public var coins:AxGroup;
		public var objects:AxGroup;
		public var explosions:AxGroup;
		
		public var worldColliders:AxGroup;
		
		public var level:uint;
		public var levelChanged:Boolean = false;
		
		public function GameState(level:uint = 6):void {
			this.level = level;
		}
		
		override public function create():void {
			Registry.game = this;
			
			add(new BackgroundSet);
			
			var wb:WorldBuilder = new WorldBuilder;
			world = wb.build(level);
			add(world);
			
			coins = wb.coins;
			add(objects = wb.objects);
			objects.add(coins);
			
			players = new AxGroup;
			players.add(alice = new Alice(wb.aliceStart));
			players.add(doug = new Doug(wb.dougStart));
			add(players);
			
			worldColliders = new AxGroup;
			worldColliders.add(players, false, false);
			worldColliders.add(objects, false, false);
			
			add(explosions = new AxGroup);
		}
		
		override public function update():void {
			if (won && !levelChanged) {
				addTimer(1, nextLevel);
				levelChanged = true;
			} else if (dead && !levelChanged) {
				addTimer(1, restartLevel);
				levelChanged = true;
			}
			
			super.update();
			
			if (Ax.keys.pressed(AxKey.ANY) && !alice.started) {
				for each(var object:AxEntity in objects.members) {
					if (object is Entity) {
						(object as Entity).start();
					}
				}
				alice.start();
				doug.start();
			}
			
			Ax.collide(worldColliders, world);
			Ax.collide(explosions, world);
			Ax.collide(players, players, function(p1:Player, p2:Player):void {
				p1.collide(p2);
			});
			Ax.overlap(players, objects, function(player:Player, object:Entity):void {
				object.collide(player);
			});
		}
		
		public function get won():Boolean {
			return alice.teleported && doug.teleported;
		}
		
		public function get dead():Boolean {
			return alice.dead || doug.dead;
		}
		
		private function nextLevel():void {
			Ax.camera.fadeOut(0.5, 0xff000000, function():void {
				Ax.states.change(new GameState(level + 1));
				Ax.camera.fadeIn(0.5);
			});
		}
		
		private function restartLevel():void {
			Ax.camera.fadeOut(0.5, 0xff000000, function():void {
				Ax.states.change(new GameState(level));
				Ax.camera.fadeIn(0.5);
			});
		}
	}
}
