package io.arkeus.yogo.game.player {
	import io.axel.AxU;
	import io.axel.sprite.AxSprite;

	public class Piece extends AxSprite {
		public function Piece(x:uint, y:uint, graphic:Class) {
			super(x, y, graphic);
			velocity.x = AxU.rand(-200, 200);
			velocity.y = AxU.rand(-600, -200);
			velocity.a = AxU.rand(0, 100);
			acceleration.y = 600;
			drag.x = 100;
		}
		
		override public function update():void {
			if (touching & LEFT || touching & RIGHT) {
				velocity.x *= -1;
			}
			if (touching & UP || touching & DOWN) {
				velocity.y *= -1;
			}
			
			if (touching & DOWN) {
				velocity.a = 0;
			}
			
			super.update();
		}
	}
}
