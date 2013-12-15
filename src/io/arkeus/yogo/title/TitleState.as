package io.arkeus.yogo.title {
	import io.arkeus.yogo.assets.Particle;
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.GameState;
	import io.arkeus.yogo.game.background.BackgroundSet;
	import io.arkeus.yogo.game.world.WorldBuilder;
	import io.arkeus.yogo.util.SoundSystem;
	import io.axel.Ax;
	import io.axel.input.AxKey;
	import io.axel.sprite.AxSprite;
	import io.axel.state.AxState;
	import io.axel.text.AxText;

	public class TitleState extends AxState {
		private var title:AxSprite;
		private var start:AxSprite;
		private var quality:AxText;
		private var qualityHelp:AxText;
		private var mute:AxText;
		private var muteHelp:AxText;
		private var done:Boolean = false;
		
		override public function create():void {
			SoundSystem.playMusic(MusicTitle);
			add(new BackgroundSet);
			add(Particle.initialize());
			
			var wb:WorldBuilder = new WorldBuilder;
			add(wb.buildTitle());
			
			add(title = new AxSprite(0, 40, Resource.TITLE));
			add(start = new AxSprite(0, 182, Resource.TITLE_START));
			
			title.x = (Ax.viewWidth - title.width) / 2;
			start.x = (Ax.viewWidth - start.width) / 2;
			
			add(quality = new AxText(0, 256, null, qualityText, Ax.viewWidth, "center"));
			add(qualityHelp = new AxText(0, 270, null, "Press @[ff0000]Q@[] to Change", Ax.viewWidth, "center"));
			quality.alpha = qualityHelp.alpha = 0.6;
			
			add(mute = new AxText(0, 256, null, "Sound Is @[00ff00]On@[]", Ax.viewWidth, "center"));
			add(muteHelp = new AxText(0, 270, null, "Press @[ff0000]M@[] to Change", Ax.viewWidth, "center"));
			mute.alpha = muteHelp.alpha = 0.6;
		}
		
		override public function update():void {
			title.alpha =  Math.cos(Ax.now / 500) / 4 + 0.55;
			start.alpha =  Math.cos(Ax.now / 300) / 4 + 0.65;
			
			if (Ax.keys.pressed(AxKey.Q)) {
				switch (Ax.quality) {
					case Ax.HIGH: Ax.quality = Ax.MEDIUM; break;
					case Ax.MEDIUM: Ax.quality = Ax.LOW; break;
					case Ax.LOW: Ax.quality = Ax.HIGH; break;
				}
				quality.text = qualityText;
				SoundSystem.play("select");
			}
			
			if (Ax.keys.pressed(AxKey.M)) {
				var muted:Boolean = SoundSystem.toggleMute();
				if (muted) {
					mute.text = "Sound is @[ff0000]Off@[]";
				} else {
					mute.text = "Sound is @[00ff00]On@[]";
				}
				SoundSystem.play("select");
			}
			
			if (Ax.keys.pressed(AxKey.SPACE) && !done) {
				SoundSystem.play("start");
				Ax.camera.fadeOut(0.5, 0xff000000, function():void {
					Ax.states.change(new IntroState);
					Ax.camera.fadeIn(0.5);
				});
				done = true;
			}
			
			super.update();
		}
		
		private function get qualityText():String {
			switch (Ax.quality) {
				case Ax.HIGH: return "Quality: @[00ff00]High@[]"; break;
				case Ax.MEDIUM: return "Quality: @[ffff00]Medium@[]"; break;
				case Ax.LOW: return "Quality: @[ff0000]Low@[]"; break;
			}
			return "?"
		}
	}
}
