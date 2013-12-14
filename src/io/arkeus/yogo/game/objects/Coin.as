package io.arkeus.yogo.game.objects {
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.Entity;
	import io.arkeus.yogo.game.player.Player;
	import io.axel.Ax;
	import io.axel.AxU;

	public class Coin extends Entity {
		private var delay:Number;
		
		public function Coin(x:uint, y:uint, faction:uint) {
			super(x, y, Resource.COIN, 16, 16);
			this.faction = faction;
			show(faction == Player.ALICE ? 0 : 1);
			delay = AxU.rand(350, 650);
			centerOrigin();
		}
		
		override public function update():void {
			if (!collided) {
				alpha = Math.cos(Ax.now / delay) / 4 + 0.75;
			}
			
			super.update();
		}
		
		override public function collide(player:Player):void {
			if (collided || player.faction != faction) {
				return;
			}
			effects.grow(0.4, 4, 4).fadeOut(0.4, 0, destroy);
			collided = true;
		}
	}
}
