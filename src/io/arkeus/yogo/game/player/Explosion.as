package io.arkeus.yogo.game.player {
	import io.arkeus.yogo.assets.Resource;
	import io.axel.AxGroup;

	public class Explosion extends AxGroup {
		public function Explosion(x:uint, y:uint, faction:uint) {
			addPiece(x + 5, y + 3, Resource.PIECE_BODY);
			addPiece(x + 5, y + 5, Resource.PIECE_HAND);
			addPiece(x + 5, y, Resource.PIECE_WING);
			if (faction == Player.ALICE) {
				addPiece(x + 3, y - 3, Resource.PIECE_HEAD_ALICE);
				addPiece(x + 7, y - 3, Resource.PIECE_BOW);
			} else {
				addPiece(x + 3, y - 3, Resource.PIECE_HEAD_DOUG);
			}
		}
		
		private function addPiece(x:uint, y:uint, graphic:Class):void {
			var piece:Piece = new Piece(x, y, graphic);
			add(piece);
		}
	}
}
