package io.arkeus.yogo.title {
	import io.arkeus.yogo.game.background.BackgroundSet;
	import io.arkeus.yogo.game.objects.Heart;
	import io.arkeus.yogo.game.player.Alice;
	import io.arkeus.yogo.game.player.Doug;
	import io.arkeus.yogo.game.player.Player;
	import io.arkeus.yogo.game.world.WorldBuilder;
	import io.arkeus.yogo.util.Registry;
	import io.axel.Ax;
	import io.axel.AxPoint;
	import io.axel.input.AxKey;
	import io.axel.sprite.AxSprite;
	import io.axel.state.AxState;
	import io.axel.text.AxText;
	
	public class OutroState extends AxState {
		private var title:AxSprite;
		private var start:AxSprite;
		private var quality:AxText;
		private var qualityHelp:AxText;
		private var done:Boolean = false;
		private var text:AxText;
		private var completion:AxText;
		
		private var alice:Alice;
		private var doug:Doug;
		
		override public function create():void {
			add(new BackgroundSet);
			
			var allCoins:Boolean = Registry.coins >= Registry.NUM_COINS;
			
			var wb:WorldBuilder = new WorldBuilder;
			add(wb.buildOutro(allCoins));
			add(wb.objects);
			
			if (!allCoins) {
				add(text = new AxText(40, 50, null, BAD_TEXT, Ax.viewWidth - 80, "center"));
				add(doug = new Doug(new AxPoint(3, 17)));
				doug.freeze();
				
				addTimer(2, function():void {
					doug.facing = doug.facing == LEFT ? RIGHT : LEFT;
				}, 0, 1);
				addTimer(2, function():void {
					add(new Heart(doug.center.x - 4 + (doug.facing == LEFT ? -3 : 3), doug.y - 6, true));
				}, 0);
			} else {
				add(text = new AxText(40, 50, null, GOOD_TEXT, Ax.viewWidth - 80, "center"));
				add(doug = new Doug(new AxPoint(6, 17)));
				add(alice = new Alice(new AxPoint(18, 17)));
				doug.freeze();
				alice.freeze();
				
				addTimer(4, function():void {
					doug.facing = RIGHT;
					addTimer(1.5, function():void {
						alice.facing = LEFT;
						addTimer(1, function():void {
							doug.velocity.x = Player.SPEED;
							alice.velocity.x = -Player.SPEED;
							addTimer(1.7, function():void {
								doug.velocity.x = 0;
								alice.velocity.x = 0;
								addTimer(1, function():void {
									add(new Heart(doug.right + 2, doug.y - 6));
								}, 0);
							});
						});
					});
				});
			}
			
			var color:String = allCoins ? "@[00ff00]" : "@[ff0000]";
			add(completion = new AxText(0, 156, null, color + Math.round(Registry.coins * 100.0 / Registry.NUM_COINS) + "@[]% Completion"));
			
			completion.scale.x = completion.scale.y = 3;
			completion.x = (Ax.viewWidth - completion.width * 3) / 2 + 5;
			
			text.alpha = 0;
			completion.alpha = 0;
			
			addTimer(15, function():void { done = true; });
		}
		
		override public function update():void {
			text.alpha += Ax.dt /3;
			if (text.alpha >= 1) {
				completion.alpha += Ax.dt / 3;
				if (completion.alpha >= 1) {
					done = true;
				}
			}
			
			if (done && (Ax.keys.pressed(AxKey.SPACE) || Ax.keys.pressed(AxKey.ESCAPE))) {
				Ax.camera.fadeOut(0.5, 0xff000000, function():void {
					Ax.states.change(new TitleState);
					Ax.camera.fadeIn(0.5);
				});
			}
			
			super.update();
		}
		
		private static const BAD_TEXT:String = "With his final act of disobedience, I was through. I tried to sell him, but no one wants a disobedient bot.\n\nAnd so I left him out in the garage, left forever to think on his actions.";
		private static const GOOD_TEXT:String = "It was only then that I saw Doug's intentions. He truly loved Alice, and who was I to keep them apart? I sold all the extra chips I had bought, tracked down Alice, and bought her back. If Jump Chips were enough for them, it was enough for me.";
	}
}