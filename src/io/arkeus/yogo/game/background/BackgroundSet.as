package io.arkeus.yogo.game.background {
	import io.arkeus.yogo.assets.Resource;
	import io.axel.AxGroup;

	public class BackgroundSet extends AxGroup {
		public function BackgroundSet() {
			add(new Background(Resource.BG_CLOUDS, 3));
			add(new Background(Resource.BG_MOUNTAINS, 6));
			add(new Background(Resource.BG_HILLS, 15));
			add(new Background(Resource.BG_TREES, 40));
		}
	}
}
