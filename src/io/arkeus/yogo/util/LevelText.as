package io.arkeus.yogo.util {
	import io.axel.Ax;
	import io.axel.input.AxKey;
	import io.axel.text.AxText;

	public class LevelText extends AxText {
		public static const PADDING:uint = 30;
		
		private var state:uint = 0;
		private var callback:Function;
		
		public function LevelText(text:String, callback:Function) {
			super(PADDING, 0, null, text, Ax.viewWidth - PADDING * 2, "center");
			this.y = (Ax.viewHeight - height) / 2 - 40;
			this.callback = callback;
			this.alpha = 0;
		}
		
		override public function update():void {
			if (state == 0) {
				if (alpha < 1) {
					alpha += Ax.dt * 2;
				} else if (Ax.keys.pressed(AxKey.ANY)) {
					state = 1;
				}
			} else if (state == 1) {
				callback();
				state = 2;
			} else if (state == 2) {
				alpha -= Ax.dt * 2;
				if (alpha <= 0) {
					state = 3;
				}
			} else if (state == 3) {
				Ax.levelText = null;
				dispose();
			}
		}
	}
}
