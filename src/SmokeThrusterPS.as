package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;

	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class SmokeThrusterPS extends ParticleSystem
	{
		public var maxNumParticles:int;
		public var currentParticleNum:int = 0;
		public var beginScale:Number;
		public var growthKoef:Number;
		public var alphaDrop:Number;
		public var smokeRadius:Number;
		public var startAlpha:Number;
		public var maxAngularVel:Number;
		public var evaporate:Boolean=false;
		
		public function SmokeThrusterPS(parent:DisplayObjectContainer, loc:b2Vec2,pn:int, bscale:Number,gk:Number, ad:Number, smokeR:Number, startA:Number, maxav:Number)
		{
			smokeRadius = smokeR;
			maxNumParticles = pn;
			growthKoef = gk;
			alphaDrop = ad;
			super(parent, loc);
			beginScale = bscale;
			startAlpha = startA;
			maxAngularVel = maxav;
		}
		
		override public function update():Boolean 
		{
			if ( maxNumParticles > currentParticleNum)
			{
				var smokeClass:Class;
				
				switch(currentParticleNum%4) 
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
				
				var stp:SmokeThrusterParticle = new SmokeThrusterParticle(_canvas, smokeClass, this);
				currentParticleNum += 1;
				
				_allParticles.push(stp);
			}
			
			super.update();
			
			if (_allParticles.length == 0)
				return true;
		
			return false;
		}
		

		
	}

}