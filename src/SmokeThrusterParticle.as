package  
{
	import Box2D.Common.Math.b2Vec2;
	import fl.motion.Color;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class SmokeThrusterParticle extends Particle
	{
		protected var stps:SmokeThrusterPS;
		protected var angularVelocity:Number;
		protected var alpha:Number;
	
		public function SmokeThrusterParticle(parent:DisplayObjectContainer, ParticleImageClass:Class, st:SmokeThrusterPS) 
		{
			stps = st;		
			angularVelocity = Math.random() * stps.maxAngularVel;
			super(parent, ParticleImageClass, new b2Vec2(0, 0), new b2Vec2(0, 0));
			restoreParticle();
		}
		

		function restoreParticle():void 
		{
			position = stps._position.Copy();
			costume.scaleX = stps.beginScale;
			costume.scaleY = stps.beginScale;
			
			alpha = stps.startAlpha;
			
			var xsign:int=1;
			var ysign:int=1;
			
			if (Math.random() > 0.5)
			xsign = -1;
			
			if (Math.random() > 0.5)
			ysign = -1;
			
			velocity = new b2Vec2(Math.random() * xsign, Math.random() * ysign);
			
			var vel2 = velocity.Copy();
			vel2.Multiply(stps.smokeRadius);
			position.Add(vel2);

		}
		
		override public function done():Boolean 
		{
			if (stps.evaporate && alpha < 0.15)
				return true;
			return false;
		}
		
		override public function update()
		{
			if (alpha < 0.15)
				restoreParticle();
			
			costume.scaleX *= (stps.growthKoef + Math.random() * 0.05);
			costume.scaleY *= (stps.growthKoef + Math.random() * 0.05);
			alpha -= stps.alphaDrop;
			costume.rotation += angularVelocity;
			costume.alpha = alpha;
			
			super.update();
		}
	}

}