package io.arkeus.yogo.game.world {
	import io.arkeus.yogo.assets.Resource;
	import io.axel.render.AxBlendMode;
	import io.axel.sprite.AxSprite;

	public class Noise extends AxSprite {
		public function Noise() {
			super(0, 0, Resource.NOISE);
			noScroll();
			blend = AxBlendMode.FILTER;
			addTimer(0.05, function():void {
				angle += 90;
			}, 0);
		}
	}
}
