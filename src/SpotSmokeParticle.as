package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class SpotSmokeParticle extends Particle
	{
		var sps:SpotSmokePS;
		var angularVelocity:Number;
		var growthKoef:Number;
		
		public function SpotSmokeParticle(parent:DisplayObjectContainer, smokeps:SpotSmokePS, ParticleImageClass:Class)  
		{
			sps = smokeps;
			super(parent, ParticleImageClass, new b2Vec2(0, 0), new b2Vec2(0, 0));
			Functions.tintColor(costume, sps.tintColor , sps.tintAlpha);
			
			angularVelocity = sps.maxAngularVel * Math.random();
			
			costume.scaleX = sps.beginScale;
			costume.scaleY = sps.beginScale;
			
			var xsign:int=1;
			var ysign:int=1;
			
			if (Math.random() > 0.5)
			xsign = -1;
			
			if (Math.random() > 0.5)
			ysign = -1;
			
			velocity = new b2Vec2(Math.random() * xsign * sps.velMultiplier, Math.random() * ysign * sps.velMultiplier);
	
			growthKoef = sps.growthKoef + 0.07 + Math.random() * 0.09;
			
			var vel2 = velocity.Copy();
			vel2.Multiply(sps.smokeRadius);
			position.Add(vel2);
		}

		override public function update()
		{		
			costume.scaleX *= growthKoef;
			costume.scaleY *= growthKoef;
			costume.rotation += angularVelocity;
			costume.alpha = sps.alpha;
			velocity.Multiply(0.85);
			super.update();
		}
	}
}