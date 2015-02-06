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
	public class ShrapnelPS2 extends ParticleSystem
	{
		public function ShrapnelPS2(parent:DisplayObjectContainer, normal:b2Vec2, basescale:Number, location:b2Vec2, costsca:Number=1) 
		{
			super(parent,location);
			var parnum:int = 10;
			
			_canvas.scaleX = costsca;
			_canvas.scaleY = costsca;
			
			_canvas.x = location.x;
			_canvas.y = location.y;
			
			if (normal.x == 0 &&  normal.y == 0)
				parnum = 75;
			
			for (var i:int; i < parnum; i++)
			{
				var vel:b2Vec2;
				
				var sk:Number;
				if (!(normal.x == 0 &&  normal.y == 0) )
				{
					sk = 0.9;
				var horVel:b2Vec2 = new b2Vec2( -normal.y, normal.x);
				
				if(i%2==0)
				horVel.Multiply( -(Math.random() * 2));
				else
				horVel.Multiply( Math.random() * 2);
				
				vel = normal.Copy();
				vel.Multiply(Math.random() * 4 +3);
				vel.Add(horVel);

				}
				else
				{
					sk = 0.9;
					vel = Functions.getRandomVector(Math.random() * 10);
				}
				
				var ParticleClass:Class;
				
				switch (int(Math.random()*9))
				{
					case 0:
					ParticleClass = BlackShrapnelParticle1;
					break;
					case 1:
					ParticleClass = BlackShrapnelParticle2;
					break;
					case 2:
					ParticleClass = BlackShrapnelParticle3;
					break;
					case 3:
					ParticleClass = BlackShrapnelParticle4;
					break;
					case 4:
					ParticleClass = BlackShrapnelParticle5;
					break;
					case 5:
					ParticleClass = BlackShrapnelParticle6;
					break;
					case 6:
					ParticleClass = BlackShrapnelParticle7;
					break;
					case 7:
					ParticleClass = BlackShrapnelParticle8;
					break;
					case 8:
					ParticleClass = BlackShrapnelParticle9;
					break;
					case 9:
					ParticleClass = BlackShrapnelParticle10;
					break;
				}
				
				var particl:ShrapnelParticle = new ShrapnelParticle(_canvas, ParticleClass, basescale, sk, new b2Vec2(0,0), vel, Math.random() * 50, 0.99, 0.9 );
				_allParticles.push(particl);
			}
		}
		
		override public function update():Boolean 
		{
			if (Particle(_allParticles[0]).costume.scaleX < 0.09)
				return true;
				
			return super.update();;
		}
		
	}

}