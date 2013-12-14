package io.arkeus.yogo.game.world {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import io.arkeus.yogo.assets.Resource;
	import io.arkeus.yogo.game.World;
	import io.arkeus.yogo.game.objects.Blocker;
	import io.arkeus.yogo.game.objects.Coin;
	import io.arkeus.yogo.game.objects.Portal;
	import io.arkeus.yogo.game.objects.Spike;
	import io.arkeus.yogo.game.objects.Teleport;
	import io.arkeus.yogo.game.player.Player;
	import io.axel.AxEntity;
	import io.axel.AxGroup;
	import io.axel.AxPoint;
	import io.axel.AxRect;

	public class WorldBuilder {
		private static const PER_ROW:uint = 3;
		
		public var tiles:Array;
		public var aliceStart:AxPoint;
		public var dougStart:AxPoint;
		
		public var coins:AxGroup = new AxGroup;
		public var objects:AxGroup = new AxGroup;
		
		public var teleport:Teleport;
		
		public function WorldBuilder() {
		}
		
		public function build(level:uint):World {
			var world:World = new World;
			parseMap(Resource.MAP, level);
			world.build(tiles, Resource.TILES, World.TILE_SIZE, World.TILE_SIZE, 1);
			world.getTile(10).collision = AxEntity.NONE;
			return world;
		}
		
		private function parseMap(map:Class, level:uint = 0):void {
			tiles = [];
			
			var bounds:AxRect = getLevelBounds(level);
			var pixels:BitmapData = (new map as Bitmap).bitmapData;
			for (var y:uint = 0; y < bounds.height; y++) {
				var row:Array = [];
				for (var x:uint = 0; x < bounds.width; x++) {
					initializePixel(pixels, bounds.x + x, bounds.y + y);
					row.push(parseTile());
					parseObject(x, y);
				}
				tiles.push(row);
			}
			
			if (aliceStart == null || dougStart == null) {
				throw new Error("Missing start point(s)");
			}
		}
		
		private function getLevelBounds(level:uint):AxRect {
			var index:uint = level - 1;
			var bounds:AxRect = new AxRect(index % PER_ROW * World.WIDTH, Math.floor(index / PER_ROW) * World.HEIGHT, World.WIDTH, World.HEIGHT);
			return bounds;
		}
		
		private var c:Boolean, l:Boolean, u:Boolean, d:Boolean, r:Boolean;
		private var cp:uint, lp:uint, up:uint, dp:uint, rp:uint;
		private var ulp:uint, urp:uint, dlp:uint, drp:uint;
		private var ul:Boolean, ur:Boolean, dl:Boolean, dr:Boolean;
		
		private function initializePixel(pixels:BitmapData, x:uint, y:uint):void {
			cp = pixels.getPixel(x, y);
			lp = pixels.getPixel(x - 1, y);
			up = pixels.getPixel(x, y - 1);
			dp = pixels.getPixel(x, y + 1);
			rp = pixels.getPixel(x + 1, y);
			ulp = pixels.getPixel(x - 1, y - 1);
			urp = pixels.getPixel(x + 1, y - 1);
			dlp = pixels.getPixel(x - 1, y + 1);
			drp = pixels.getPixel(x + 1, y + 1);
			
			c = cp == WALL;
			l = lp == cp;
			r = rp == cp;
			u = up == cp;
			d = dp == cp;
			ul = ulp == cp;
			ur = urp == cp;
			dl = dlp == cp;
			dr = drp == cp;
		}
		
		private function parseTile():uint {
			if (cp == ALICE_BRICK) {
				return 7;
			} else if (cp == DOUG_BRICK) {
				return 8;
			} else if (!c) {
				return 0;
			}
			
			var tile:uint = 15; 
			if (u && d && l && r) {
				if (!dr) {
					tile = 1;
				} else if (!dl) {
					tile = 3;
				} else if (!ur) {
					tile = 21;
				} else if (!ul) {
					tile = 23;
				}
			} else if (u && d && l) {
				tile = 11;
			} else if (u && d && r) {
				tile = 13;
			} else if (l && u && r) {
				tile = 2;
			} else if (l && d && r) {
				tile = 22;
			} else if (r && d) {
				tile = 4;
			} else if (l && d) {
				tile = 6;
			} else if (u && r) {
				tile = 24;
			} else if (u && l) {
				tile = 26;
			}
			return tile;
		}
		
		private function parseObject(x:uint, y:uint):void {
			switch(cp) {
				case ALICE: aliceStart = new AxPoint(x, y); break;
				case DOUG: dougStart = new AxPoint(x, y); break;
				case ALICE_COIN: coins.add(new Coin(x, y, Player.ALICE)); break;
				case DOUG_COIN: coins.add(new Coin(x, y, Player.DOUG)); break;
				case ALICE_END: objects.add(new Portal(x, y, Player.ALICE)); break;
				case DOUG_END: objects.add(new Portal(x, y, Player.DOUG)); break;
				case SPIKE: objects.add(new Spike(x, y)); break;
				case ALICE_SWITCH: objects.add(new Blocker(x, y, Player.ALICE)); break;
				case DOUG_SWITCH: objects.add(new Blocker(x, y, Player.DOUG)); break;
				case TELEPORT:
					var t:Teleport = new Teleport(x, y);
					if (teleport != null) {
						teleport.link(t);
					} else {
						teleport = t;
					}
					objects.add(t);
				break;
			}
		}
		
		private static const
		WALL:uint = 0x000000,
		NOTHING:uint = 0xffffff,
		ALICE:uint = 0xff00ff,
		ALICE_COIN:uint = 0xff83ff,
		ALICE_END:uint = 0x8f008f,
		DOUG:uint = 0x0080ff,
		DOUG_COIN:uint = 0x85c2ff,
		DOUG_END:uint = 0x00478e,
		SPIKE:uint = 0xff0000,
		ALICE_SWITCH:uint = 0x341d34,
		ALICE_BRICK:uint = 0x5f505f,
		DOUG_SWITCH:uint = 0x162436,
		DOUG_BRICK:uint = 0x47515d,
		TELEPORT:uint = 0x7957fb
	}
}
