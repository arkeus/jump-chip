package io.arkeus.yogo.game {
	import io.arkeus.yogo.assets.Particle;
	import io.arkeus.yogo.game.background.BackgroundSet;
	import io.arkeus.yogo.game.player.Alice;
	import io.arkeus.yogo.game.player.Doug;
	import io.arkeus.yogo.game.player.Player;
	import io.arkeus.yogo.game.world.WorldBuilder;
	import io.arkeus.yogo.util.LevelText;
	import io.arkeus.yogo.util.Registry;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.Ax;
	import io.axel.AxEntity;
	import io.axel.AxGroup;
	import io.axel.input.AxKey;
	import io.axel.state.AxState;
	import io.axel.text.AxText;

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
		
		public function GameState(level:uint = 2):void {
			this.level = level;
		}
		
		override public function create():void {
			Registry.game = this;
			SoundSystem.playMusic(MusicGame);
			
			add(new BackgroundSet);
			add(Particle.initialize());
			
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
			
			addTutorials();
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
				var text:String = LEVEL_TEXTS[level];
				if (text == null) {
					Ax.states.change(new GameState(level + 1));
					Ax.camera.fadeIn(0.5);
				} else {
					Ax.levelText = new LevelText(text, function():void {
						Ax.states.change(new GameState(level + 1));
						Ax.camera.fadeIn(0.5);
					});
				}
			});
		}
		
		private function restartLevel():void {
			Ax.camera.fadeOut(0.5, 0xff000000, function():void {
				Ax.states.change(new GameState(level));
				Ax.camera.fadeIn(0.5);
			});
		}
		
		private function addTutorials():void {
			switch (level) {
				case 1:
					addTutorial(3, "Press @[ff00ff]A@[] @[666666](or Q or LEFT)@[] to activate the @[a8ff00]Jump Chip@[] in @[ff00ff]Alice@[].");
					addTutorial(16, "Press @[ff00ff]D@[] @[666666](or Q or RIGHT)@[] to activate the @[a8ff00]Jump Chip@[] in @[0080ff]Doug@[].");
				break;
				case 2:
					addTutorial(3, "Use @[ff0000]R@[] to self destruct if you get stuck.");
				break;
			}
		}
		
		private static const T_PAD:uint = 30;
		private function addTutorial(y:uint, text:String):void {
			add(new AxText(T_PAD, y * World.TILE_SIZE, null, text, Ax.viewWidth - T_PAD * 2, "center"));
		}
		
		private static const LEVEL_TEXTS:Object = {
			1: "With only a @[a8ff00]Jump Chip@[], I was limited. But I was a child. My imagination was boundless. And so I built them puzzles.",
			2: "Sometimes I kept them separate.",
			3: "Other times I forced them to use each other to reach their goals.",
			4: "Sometimes I felt they had grown fond of each other. But this was only my imagination playing tricks on me. They were bots, after all.",
			5: "I built new toys to challenge them.",
			6: "I built new toys to challenge them.",
			7: "I tried to confuse them.",
			8: "Yet they always reached their goals.",
			9: "I began to throw harder challenges at them.",
			10: "I'd begun to grow fond of watching them explode. I'd always put them back together, of course.",
			11: "But as I grew older, the excitement faded. I no longer got the same joy from playing with @[ff00ff]Alice@[] and @[0080ff]Doug@[]."
		};
	}
}
