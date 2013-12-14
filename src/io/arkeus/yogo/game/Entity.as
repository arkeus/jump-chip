package io.arkeus.yogo.game {
	import io.arkeus.yogo.game.player.Player;
	import io.axel.sprite.AxSprite;

	public class Entity extends AxSprite {
		public var faction:uint = uint.MAX_VALUE;
		public var collided:Boolean = false;
		
		public function Entity(x:uint, y:uint, graphic:Class = null, frameWidth:uint = 0, frameHeight:uint = 0) {
			super(x * World.TILE_SIZE, y * World.TILE_SIZE, graphic, frameWidth, frameHeight);
		}
		
		public function collide(player:Player):void {}
	}
}
