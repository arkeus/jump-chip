package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.axel.Ax;
	import io.axel.sprite.AxSprite;

	public class Heart extends AxSprite {
		public function Heart(x:uint, y:uint, broken:Boolean = false) {
			super(x, y, broken ? Resource.BROKEN_HEART : Resource.HEART);
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
