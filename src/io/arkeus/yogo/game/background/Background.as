package io.arkeus.yogo.game.background {
	import io.axel.sprite.AxParallaxSprite;

	public class Background extends AxParallaxSprite {
		public function Background(graphic:Class, speed:Number) {
			super(0, 0, graphic);
			
			velocity.x = speed;
		}
	}
}
