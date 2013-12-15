package io.arkeus.yogo.assets {
	import io.axel.AxGroup;
	import io.axel.particle.AxParticleCloud;

	public class ParticleGroup extends AxGroup {
		override public function dispose():void {
			for (var i:uint = 0; i < members.length; i++) {
				resetParticleCloud(members[i]);
			}
		}
		
		private function resetParticleCloud(group:AxGroup):void {
			for (var i:uint = 0; i < group.members.length; i++) {
				var cloud:AxParticleCloud = group.members[i] as AxParticleCloud;
				cloud.time = 0;
				cloud.visible = false;
				cloud.active = false;
				cloud.exists = false;
			}
		}
	}
}
