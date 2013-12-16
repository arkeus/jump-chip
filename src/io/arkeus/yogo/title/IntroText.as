package io.arkeus.yogo.title {
	import io.arkeus.yogo.game.GameState;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.Ax;
	import io.axel.AxEntity;
	import io.axel.AxGroup;
	import io.axel.input.AxKey;
	import io.axel.text.AxText;

	public class IntroText extends AxGroup {
		private static const DELAY:Number = 2.5;
		private static const PADDING:uint = 40;
		
		private var counter:uint = 0;
		private var position:uint = 0;
		private var done:Boolean = false;
		
		public function IntroText() {
			addTimer(DELAY, function():void {
				if (counter >= INTRO_TEXT.length) {
					return;
				}
				var line:String = INTRO_TEXT[counter++];
				var text:AxText = new AxText(PADDING, PADDING + position, null, line, Ax.viewWidth - PADDING * 2);
				add(text);
				text.alpha = 0;
				position += text.height + 10;
				if (counter == INTRO_TEXT.length) {
					text.alpha = 1;
					done = true;
				}
			}, 0, 0);
			
			var skip:AxText = new AxText(PADDING, Ax.viewHeight - PADDING, null, "@[666666][Escape To Skip]");
			skip.y -= skip.height;
			add(skip);
		}
		
		private var begun:Boolean = false;
		private function begin():void {
			if (begun) {
				return;
			}
			SoundSystem.play("start");
			begun = true;
			Ax.camera.fadeOut(0.5, 0xff000000, function():void {
				Ax.states.change(new GameState(1));
				Ax.camera.fadeIn(0.5);
			});
		}
		
		override public function update():void {
			for each(var entity:AxEntity in members) {
				if (entity is AxText && entity.alpha < 1) {
					entity.alpha += Ax.dt * 0.5;
				}
			}
			
			if ((done && Ax.keys.pressed(AxKey.SPACE)) || Ax.keys.pressed(AxKey.ESCAPE)) {
				begin();
			}
			
			super.update();
		}
		
		private static const INTRO_TEXT:Array = [
			"As a child I was always jealous of my friends and their programmable bots.",
			"Each bot could be programmed with a countless number of chips, giving them exciting abilities.",
			"On my 10th birthday my father took me to get me my own pair of bots.",
			"I named them @[ff00ff]Alice@[] and @[0080ff]Doug@[].",
			"Money was tight at the time, so when we went to buy chips, my father told me, \"@[ff0000]you only get one@[]\".",
			"I chose the @[a8ff00]Jump Chip@[].",
			"@[555555][Space To Begin]@[]"
		];
	}
}
