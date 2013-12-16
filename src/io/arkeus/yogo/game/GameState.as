package io.arkeus.yogo.game {
	import io.arkeus.yogo.assets.Particle;
	import io.arkeus.yogo.game.background.BackgroundSet;
	import io.arkeus.yogo.game.objects.Bullet;
	import io.arkeus.yogo.game.objects.Enemy;
	import io.arkeus.yogo.game.player.Alice;
	import io.arkeus.yogo.game.player.Doug;
	import io.arkeus.yogo.game.player.Player;
	import io.arkeus.yogo.game.world.WorldBuilder;
	import io.arkeus.yogo.title.EscapeState;
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
		public var bullets:AxGroup;
		public var enemies:AxGroup;
		
		public var worldColliders:AxGroup;
		
		public var level:uint;
		public var retry:Boolean;
		public var levelChanged:Boolean = false;
		public var coinsCollected:uint = 0;
		
		public function GameState(level:uint = 1, retry:Boolean = false):void {
			this.level = level;
			this.retry = retry;
			if (level == 1) {
				Registry.coins = 0;
			}
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
			
			enemies = wb.enemies;
			
			bullets = new AxGroup;
			objects.add(bullets);
			
			players = new AxGroup;
			players.add(alice = new Alice(wb.aliceStart));
			players.add(doug = new Doug(wb.dougStart));
			add(players);
			
			if (level > 12) {
				alice.visible = alice.exists = alice.solid = false;
				doug.supersize();
			}
			
			worldColliders = new AxGroup;
			worldColliders.add(players, false, false);
			worldColliders.add(objects, false, false);
			
			add(explosions = new AxGroup);
			
			addTutorials();
			
			addTimer(1, function():void { trace("COINS", Registry.coins); }, 0);
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
			Ax.overlap(bullets, enemies, function(bullet:Bullet, object:Enemy):void {
				if (bullet.friendly) {
					object.hit();
					bullet.destroy();
				}
			});
			
			if (Ax.keys.pressed(AxKey.ESCAPE) && Ax.camera.sprite.alpha == 0) {
				Ax.states.push(new EscapeState);
			}
		}
		
		public function get won():Boolean {
			return (doug.supersized || alice.teleported) && doug.teleported;
		}
		
		public function get dead():Boolean {
			return alice.dead || doug.dead;
		}
		
		private function nextLevel():void {
			Ax.camera.fadeOut(0.5, 0xff000000, function():void {
				Registry.coins += coinsCollected;
				
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
				if (level == 13 && !level13TextShown && wrongPortal) {
					level13TextShown = true;
					Ax.levelText = new LevelText(LEVEL_13_DIE_TEXT, function():void {
						Ax.states.change(new GameState(level));
						Ax.camera.fadeIn(0.5);
					});
				} else {
					Ax.states.change(new GameState(level));
					Ax.camera.fadeIn(0.5);
				}
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
				case 14:
					addTutorial(19, "Press @[ff00ff]Space@[] to activate the @[a8ff00]Gun Chip@[].");
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
			6: "I tried to confuse them.",
			7: "I threw more and more obstacles at them.",
			8: "Yet they always reached their goals.",
			9: "I began to throw harder challenges at them.",
			10: "I'd begun to grow fond of watching them explode. I'd always put them back together, of course.",
			11: "But as I grew older, the excitement faded. I no longer got the same joy from playing with @[ff00ff]Alice@[] and @[0080ff]Doug@[].",
			12: "And so to remedy my boredom, I sold @[ff00ff]Alice@[] for money to buy new chips.\n\nWith a @[a8ff00]Move Chip@[] installed for free movement and a @[a8ff00]Speed Chip@[] for haste, my excitement was renewed and I began to throw new challenges at @[0080ff]Doug@[].",
			13: "I tried to get @[0080ff]Doug@[]'s mind off @[ff00ff]Alice@[] by even giving him a @[a8ff00]Gun Chip@[]. Yet his search for @[ff00ff]Alice@[] continued.",
			14: "In the end I pit him against the newest version of @[ff0000]Battle Bot@[], borrowed from a friend. Even a bot needs punishing every now and again."
		};
		
		private static const LEVEL_13_DIE_TEXT:String = "Without @[ff00ff]Alice@[], @[0080ff]Doug@[] seemed heartbroken and appeared to not want to play by the rules.";
		private static var level13TextShown:Boolean = false;
		public var wrongPortal:Boolean = false;
	}
}
