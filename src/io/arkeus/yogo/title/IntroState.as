package io.arkeus.yogo.title {
	import io.arkeus.yogo.game.background.BackgroundSet;
	import io.arkeus.yogo.game.world.WorldBuilder;
	import io.axel.sprite.AxSprite;
	import io.axel.state.AxState;
	import io.axel.text.AxText;
	
	public class IntroState extends AxState {
		private var title:AxSprite;
		private var start:AxSprite;
		private var quality:AxText;
		private var qualityHelp:AxText;
		private var done:Boolean = false;
		
		override public function create():void {
			add(new BackgroundSet);
			
			var wb:WorldBuilder = new WorldBuilder;
			add(wb.buildIntro());
			
			add(new IntroText);
		}
		
		override public function update():void {
			super.update();
		}
	}
}