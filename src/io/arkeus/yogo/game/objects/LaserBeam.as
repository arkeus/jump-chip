package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;
	import io.axel.Ax;

	public class LaserBeam extends Entity {
		public function LaserBeam(x:Number, y:Number, height:Number) {
			super(x, y);
			create(2, height, 0xffffffff);
		}
		
		override public function update():void {
			alpha = Math.cos(Ax.now / 200) / 4 + 0.75;
			super.update();
		}
		
		override public function collide(player:Player):void {
			player.destroy();
		}
	}
}
