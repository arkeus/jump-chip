package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.axel.Ax;
	import io.axel.sprite.AxSprite;

	public class Heart extends AxSprite {
		public function Heart(x:uint, y:uint) {
			super(x, y, Resource.HEART);
			velocity.y = -20;
			solid = false;
		}
		
		override public function update():void {
			alpha -= Ax.dt;
			if (alpha <= 0) {
				destroy();
			}
			super.update();
		}
	}
}
