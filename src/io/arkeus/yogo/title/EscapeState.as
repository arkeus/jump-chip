package io.arkeus.yogo.title {
	import flash.system.System;
	
	import io.axel.Ax;
	import io.axel.AxPoint;
	import io.axel.input.AxKey;
	import io.axel.sprite.AxSprite;
	import io.axel.state.AxState;
	import io.axel.text.AxText;

	public class EscapeState extends AxState {
		override public function create():void {
			// Create tint and text
			var tint:AxSprite = new AxSprite(0, 140).create(Ax.width, 30, 0xbb000000);
			var text:AxText = new AxText(0, 147, null, "@[ff0000]M@[] To Return To Menu\n @[00ff00]Escape@[] to continue.", Ax.viewWidth, "center");
			// Set properties
			tint.scroll = text.scroll = new AxPoint(0, 0);
			//text.zooms = false;
			tint.alpha = 0;
			// Fade the tint in
			tint.effects.fadeIn(0.5);
			// Add to state
			this.add(tint).add(text);
			// Garbade collect as an added bonus
			System.gc();
		}
		
		override public function update():void {
			if (Ax.keys.pressed(AxKey.ESCAPE)) {
				Ax.states.pop();
			} else if (Ax.keys.pressed(AxKey.M)) {
				Ax.states.pop();
				Ax.states.change(new TitleState);
			}
			
			super.update();
		}
	}
}
