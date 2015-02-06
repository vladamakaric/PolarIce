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
	
	public class ShrapnelParticle extends Particle
	{
		var angularVelocity:Number;
		var linearDamping:Number;
		var scaleKoef:Number;
		
		public function ShrapnelParticle(parent:DisplayObjectContainer, ParticleImageClass:Class, bs:Number, sk:Number , pos:b2Vec2, vel:b2Vec2, angVel:Number, angDamp:Number, linDamp:Number, color:Number=-1)  
		{
			super(parent, ParticleImageClass, pos, vel);
			
			if(color>0)
			Functions.tintColor(costume, color, 1);
				
			angularVelocity = angVel;
			linearDamping = linDamp;
			
			scaleKoef = sk;

			costume.scaleX = bs;
			costume.scaleY = bs;
		}
		
		override public function update()
		{
			velocity.Multiply(linearDamping);			
			costume.scaleX *= scaleKoef;
			costume.scaleY *= scaleKoef;
			costume.rotation += angularVelocity;
			super.update();
		}
	}

}