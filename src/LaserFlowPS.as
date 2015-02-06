package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	//import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author Mikhail
	 */
	public class LaserFlowPS extends ParticleSystem
	{
		public var _destroy:Boolean = false;
		public var _start:b2Vec2;
		public var _end:b2Vec2;
		public var maxNum:int = 5;
		
		public function LaserFlowPS(parent:DisplayObjectContainer,start:b2Vec2,end:b2Vec2/*,loc:b2Vec2*/) 
		{
			_start = start;
			_end = end;
			super(parent, start);
		}
		
		override public function update():Boolean 
		{
			if ( _end != null)
			{
				_canvas.name =  String(Math.abs(Functions.GetDistanceBetweenB2Vec2(_start, _end) * Global.RATIO));
				
				if (maxNum > _allParticles.length && Global.TIME % 3 == 0)
				{
					
					
					
					var newPart:LaserFlowParticle = new LaserFlowParticle(_canvas/*.parent*/, Sprite,20, Math.random()*2    );//12 iste
					_allParticles.push(newPart);
					//trace("partikla : " + _allParticles.length);
				}
			}	
			super.update();
			
			//draw();
			
			return _destroy;
		}
		
		
		
		
	}

}