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
	public class SpotSmokePS extends ParticleSystem
	{
		var numParticles:int;
		var beginScale:Number;
		var growthKoef:Number;
		var alphaDrop:Number;
		var smokeRadius:Number;
		var tintColor:Number;
		var tintAlpha:Number;
		var maxAngularVel:Number;
		var velMultiplier:Number;
		var alpha:Number;
		
		public function SpotSmokePS(parent:DisplayObjectContainer, loc:b2Vec2, pn:int, bscale:Number, gk:Number, ad:Number, smokeR:Number, 
								alph:Number, tcolor:Number, talpha:Number, maxav:Number, vmulti:Number)  
		{
			super(parent, loc);
			
			_canvas.x = loc.x;
			_canvas.y = loc.y;

			smokeRadius = smokeR;
			numParticles = pn;
			growthKoef = gk;
			alphaDrop = ad;
			beginScale = bscale;
			alpha = alph;
			tintColor = tcolor;
			tintAlpha = talpha;
			maxAngularVel = maxav;
			velMultiplier = vmulti;
			
			var smokeClass:Class;
			numParticles = pn;
			
			for (var i:int = 0; i < numParticles; i++ )
			{
				switch(i%4) 
				{
					case 0:
					smokeClass = SPa1;
					break;
					case 1:
					smokeClass = SPa2;
					break;
					case 2:
					smokeClass = SPa3;
					break;
					case 3:
					smokeClass = SPa4;
					break;
				}
				
				var sp:SpotSmokeParticle =  new SpotSmokeParticle(_canvas, this, smokeClass);
				_allParticles.push(sp);
			}
		}	
		
		override public function update():Boolean 
		{
			super.update();
			alpha -= alphaDrop;
			
			if (alpha < 0.05)
				return true;
				
			return false;
		}
	}

}