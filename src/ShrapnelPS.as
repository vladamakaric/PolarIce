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
	public class ShrapnelPS extends ParticleSystem
	{
		public function ShrapnelPS(parent:DisplayObjectContainer, normal:b2Vec2, basescale:Number, location:b2Vec2, linDam:Number = 1,  color:Number=-1) 
		{
			super(parent,location);
			var parnum:int=10;
			
			
			
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
				horVel.Multiply( -(Math.random() * 6));
				else
				horVel.Multiply( Math.random() * 6);
				
				vel = normal.Copy();
				vel.Multiply(Math.random() * 5.5 +1);
				vel.Add(horVel);

				}
				else
				{
					sk = 0.9;
					var vm:Number = Math.random() * 10;
					
					var angle:Number = Math.PI * 2 * Math.random();
					vel = new b2Vec2(Math.cos(angle)*vm, Math.sin(angle)*vm);
				}
				
				var ParticleClass:Class;
				
				switch (int(Math.random()*9))
				{
					case 0:
					ParticleClass = WhiteShrapnelParticle1;
					break;
					case 1:
					ParticleClass = WhiteShrapnelParticle2;
					break;
					case 2:
					ParticleClass = WhiteShrapnelParticle3;
					break;
					case 3:
					ParticleClass = WhiteShrapnelParticle4;
					break;
					case 4:
					ParticleClass = WhiteShrapnelParticle5;
					break;
					case 5:
					ParticleClass = WhiteShrapnelParticle6;
					break;
					case 6:
					ParticleClass = WhiteShrapnelParticle7;
					break;
					case 7:
					ParticleClass = WhiteShrapnelParticle8;
					break;
					case 8:
					ParticleClass = WhiteShrapnelParticle9;
					break;
					case 9:
					ParticleClass = WhiteShrapnelParticle10;
					break;
				}
				
				var particl:ShrapnelParticle = new ShrapnelParticle(_canvas, ParticleClass, basescale, sk, location.Copy(), vel, Math.random() * 50, 0.99, 0.875*linDam, color );
				_allParticles.push(particl);
			}
		}
		
		override public function update():Boolean 
		{
			super.update();
			if (Particle(_allParticles[0]).costume.scaleX < 0.09)
				return true;
				
			return false;
		}
		
	}

}