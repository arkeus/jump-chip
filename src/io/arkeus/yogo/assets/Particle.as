package io.arkeus.yogo.assets {
	import io.axel.particle.AxParticleEffect;
	import io.axel.particle.AxParticleSystem;
	import io.axel.render.AxBlendMode;

	public class Particle {		
		private static var group:ParticleGroup;
		
		public static function initialize():ParticleGroup {
			if (group != null) {
				return group;
			}
			
			var effect:AxParticleEffect;
			group = new ParticleGroup;
			
			effect = new AxParticleEffect("portal-pink", Resource.PARTICLE_PIXEL_PINK, 10);
			effect.frameSize.x = effect.frameSize.y = 1;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 5;
			effect.x.min = 3; effect.x.max = 12;
			effect.y.min = 14; effect.y.max = 16;
			effect.yVelocity.min = -100; effect.yVelocity.max = -40;
			effect.xVelocity.min = effect.xVelocity.max = 0;
			effect.lifetime.min = 0.2; effect.lifetime.max = 0.4;
			effect.startAlpha.min = effect.startAlpha.max = 0.3;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("portal-blue", Resource.PARTICLE_PIXEL_BLUE, 10);
			effect.frameSize.x = effect.frameSize.y = 1;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 5;
			effect.x.min = 3; effect.x.max = 12;
			effect.y.min = 14; effect.y.max = 16;
			effect.yVelocity.min = -100; effect.yVelocity.max = -40;
			effect.xVelocity.min = effect.xVelocity.max = 0;
			effect.lifetime.min = 0.2; effect.lifetime.max = 0.4;
			effect.startAlpha.min = effect.startAlpha.max = 0.3;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("portal-pink-complete", Resource.PARTICLE_PIXEL_PINK, 10);
			effect.frameSize.x = effect.frameSize.y = 1;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 50;
			effect.x.min = 3; effect.x.max = 12;
			effect.y.min = 14; effect.y.max = 16;
			effect.yVelocity.min = -100; effect.yVelocity.max = -40;
			effect.xVelocity.min = effect.xVelocity.max = 0;
			effect.lifetime.min = 0.3; effect.lifetime.max = 0.7;
			effect.startAlpha.min = effect.startAlpha.max = 0.5;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("portal-blue-complete", Resource.PARTICLE_PIXEL_BLUE, 10);
			effect.frameSize.x = effect.frameSize.y = 1;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 50;
			effect.x.min = 3; effect.x.max = 12;
			effect.y.min = 14; effect.y.max = 16;
			effect.yVelocity.min = -100; effect.yVelocity.max = -40;
			effect.xVelocity.min = effect.xVelocity.max = 0;
			effect.lifetime.min = 0.3; effect.lifetime.max = 0.7;
			effect.startAlpha.min = effect.startAlpha.max = 0.5;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("coin-pink", Resource.PARTICLE_PIXEL_PINK, 4);
			effect.frameSize.x = effect.frameSize.y = 1;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 150;
			effect.x.min = 0; effect.x.max = 10;
			effect.y.min = 0; effect.y.max = 10;
			effect.xVelocity.min = -50; effect.xVelocity.max = 50;
			effect.yVelocity.min = -50; effect.yVelocity.max = 50;
			effect.lifetime.min = 1; effect.lifetime.max = 2;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("coin-blue", Resource.PARTICLE_PIXEL_BLUE, 4);
			effect.frameSize.x = effect.frameSize.y = 1;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 50;
			effect.x.min = 0; effect.x.max = 10;
			effect.y.min = 0; effect.y.max = 10;
			effect.xVelocity.min = -50; effect.xVelocity.max = 50;
			effect.yVelocity.min = -50; effect.yVelocity.max = 50;
			effect.lifetime.min = 1; effect.lifetime.max = 2;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("explosion", Resource.PARTICLE_SMOKE, 2);
			effect.frameSize.x = effect.frameSize.y = 5;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 200;
			effect.x.min = 0; effect.x.max = 14;
			effect.y.min = -6; effect.y.max = 16;
			effect.xVelocity.min = -20; effect.xVelocity.max = 20;
			effect.yVelocity.min = -20; effect.yVelocity.max = 20;
			effect.lifetime.min = 0.5; effect.lifetime.max = 1;
			effect.startAlpha.min = effect.startAlpha.max = 0.2;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("smoke", Resource.PARTICLE_SMOKE, 1000);
			effect.frameSize.x = effect.frameSize.y = 5;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 1;
			effect.x.min = -3; effect.x.max = -3;
			effect.y.min = -3; effect.y.max = -3;
			effect.xVelocity.min = -5; effect.xVelocity.max = 5;
			effect.yVelocity.min = -5; effect.yVelocity.max = 5;
			effect.lifetime.min = 0.3; effect.lifetime.max = 0.5;
			effect.startAlpha.min = effect.startAlpha.max = 0.1;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("brick-pink", Resource.PARTICLE_BRICK_PINK, 50);
			effect.frameSize.x = effect.frameSize.y = 12;
			//effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 2;
			effect.x.min = 0; effect.x.max = 16;
			effect.y.min = 0; effect.y.max = 16;
			effect.xVelocity.min = -50; effect.xVelocity.max = 50;
			effect.yVelocity.min = -200; effect.yVelocity.max = -100;
			effect.yAcceleration.min = effect.yAcceleration.max = 400;
			effect.lifetime.min = 1; effect.lifetime.max = 2;
			effect.endAlpha.min = effect.endAlpha.max = 1;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("brick-blue", Resource.PARTICLE_BRICK_BLUE, 50);
			effect.frameSize.x = effect.frameSize.y = 12;
			//effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 2;
			effect.x.min = 0; effect.x.max = 4;
			effect.y.min = 0; effect.y.max = 4;
			effect.xVelocity.min = -20; effect.xVelocity.max = 20;
			effect.yVelocity.min = -100; effect.yVelocity.max = -50;
			effect.yAcceleration.min = effect.yAcceleration.max = 200;
			effect.lifetime.min = 1; effect.lifetime.max = 2;
			effect.endAlpha.min = effect.endAlpha.max = 1;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("spark-down", Resource.PARTICLE_SPARK, 10);
			effect.frameSize.x = effect.frameSize.y = 1;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 5;
			effect.x.min = 0; effect.x.max = 3;
			effect.y.min = 0; effect.y.max = 0;
			effect.yVelocity.min = 0; effect.yVelocity.max = 20;
			effect.xVelocity.min = -20; effect.xVelocity.max = 20;
			effect.yAcceleration.min = effect.yAcceleration.max = 100;
			effect.lifetime.min = 0.2; effect.lifetime.max = 0.4;
			effect.startAlpha.min = effect.startAlpha.max = 1;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("spark-up", Resource.PARTICLE_SPARK, 40);
			effect.frameSize.x = effect.frameSize.y = 1;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 20;
			effect.x.min = 0; effect.x.max = 1;
			effect.y.min = 0; effect.y.max = 0;
			effect.yVelocity.min = -70; effect.yVelocity.max = -20;
			effect.xVelocity.min = -40; effect.xVelocity.max = 40;
			effect.yAcceleration.min = effect.yAcceleration.max = 200;
			effect.lifetime.min = 0.3; effect.lifetime.max = 0.5;
			effect.startAlpha.min = effect.startAlpha.max = 1;
			group.add(AxParticleSystem.register(effect));
			
			effect = new AxParticleEffect("bullet-red", Resource.PARTICLE_SPARK, 10);
			effect.frameSize.x = effect.frameSize.y = 1;
			effect.blend = AxBlendMode.PARTICLE;
			effect.amount = 20;
			effect.x.min = 0; effect.x.max = 4;
			effect.y.min = 0; effect.y.max = 2;
			effect.yVelocity.min = -100; effect.yVelocity.max = -50;
			effect.xVelocity.min = -50; effect.xVelocity.max = 50;
			effect.yAcceleration.min = effect.yAcceleration.max = 300;
			effect.lifetime.min = 0.3; effect.lifetime.max = 0.5;
			effect.startAlpha.min = effect.startAlpha.max = 1;
			group.add(AxParticleSystem.register(effect));
			
			return group;
		}
	}
}
