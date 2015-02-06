package  
{
	import Box2D.Common.Math.b2Vec2;
	import fl.motion.Color;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class ExplosionParticle extends Particle
	{
		var angularVelocity:Number;
		var growthKoef:Number;
		var endScale:Number;
		var alphaDrop:Number;
		var alpha:Number;
		var colorDrop:int;
		var cTint:Color = new Color();

		public function ExplosionParticle(parent:DisplayObjectContainer, ParticleImageClass:Class, gk:Number, beginScale:Number, es:Number, 
									  ad:Number, starta:Number, velm:Number, posoff:Number, maxav:Number, tcolor:uint, colordrop:int, talpha:Number) 
		{
			super(parent, ParticleImageClass, new b2Vec2(0,0), new b2Vec2(0,0));
			
			velocity = new b2Vec2(Math.cos(Math.PI * 2 * Math.random()), Math.sin(Math.PI * 2 * Math.random()));
			position = velocity.Copy();
			velocity.Multiply(velm);
			position.Multiply(posoff);
			
			growthKoef = gk;
			endScale = es;
			alphaDrop = ad;
			
			growthKoef = gk - 0.01 * Math.random();
			endScale = es - 0.01 * Math.random();
			alphaDrop = ad;
			
			angularVelocity = maxav * Math.random();
			
			if (Math.random() > 0.5)
				angularVelocity *= -1;
			
			colorDrop = colordrop;
			costume.rotation = 360 * Math.random();
			costume.scaleX = beginScale;
			costume.scaleY = costume.scaleX;
			alpha = starta;
			cTint.setTint( tcolor, talpha);
		}

		override public function done():Boolean 
		{
			if (alpha < 0.05)
				return true;
				
			return super.done();
		}
		
		override public function update()
		{		
			if (costume.scaleX < endScale)
			{
				alpha -= alphaDrop;
				costume.scaleX *= growthKoef*1.9;
				costume.scaleY *= growthKoef*1.9;
			}
			else
			{	
				costume.rotation -= angularVelocity/2;
				alpha -= alphaDrop*6;
				costume.scaleX *= growthKoef*1.006;
				costume.scaleY *= growthKoef * 1.006;
				cTint.redOffset -= colorDrop/2;
				cTint.blueOffset -= colorDrop/2;
				cTint.greenOffset -= colorDrop / 2;
				position.Add(velocity);
			}
			
			costume.transform.colorTransform = cTint;	
			cTint.redOffset -= colorDrop;
			cTint.blueOffset -= colorDrop;
			cTint.greenOffset -= colorDrop;
			
			costume.alpha = alpha;
			costume.rotation += angularVelocity;
			super.update();
		}
	}
}