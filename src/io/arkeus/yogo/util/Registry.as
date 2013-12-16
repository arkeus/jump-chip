package io.arkeus.yogo.util {
	import io.arkeus.yogo.game.GameState;
	import io.arkeus.yogo.game.player.Player;

	public class Registry {
		public static const NUM_COINS:int = 12 * 4 + 3 * 2;
		
		public static var game:GameState;
		public static var player:Player;
		
		public static var coins:uint;
	}
}
