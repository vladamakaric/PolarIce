package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author Mikhail
	 */
	public class LaserFlowParticle extends Particle
	{
		//public var _start:b2Vec2;
		//public var _end:b2Vec2;
		
		public function LaserFlowParticle(parent:DisplayObjectContainer, ParticleImageClass:Class,speed:Number, drawPreset:int) 
		{
			super(parent, ParticleImageClass, new b2Vec2(), new b2Vec2(0, -speed));
			
			//costume.graphics.beginFill(0);
			//costume.graphics.lineStyle(3);
			//costume.graphics.drawCircle(0, 0, 3);
			//costume.graphics.endFill();
			
			switch(drawPreset)
			{
				case 0:
				draw0();
				break;
				
				case 1:
				draw1();
				break;
				
				case 2:
				draw2();
				break;
				
				default:
				//trace("nista");
				break;
			}
			
		}
		
		override public function done():Boolean 
		{
			//trace(costume.y);
			return costume.y + velocity.y < int(costume.parent.name) * -1;
		}
		
		override public function update()
		{ 
			super.update();
		}
		
		public function draw0():void 
		{//bela linija
			costume.graphics.lineStyle(2, LaserContignous.LaserColours[1], 0.8);
			//costume.graphics.beginFill(LaserContignous.LaserColours[2], 0.3);
			costume.graphics.lineTo(0, Math.random() * 20 + 5);
			//costume.filters = [new BlurFilter(Math.random() * 16),new GlowFilter(LaserContignous.LaserColours[1], 0.4, 16)];
		}
		
		public function draw2():void
		{//crna taackica
			costume.graphics.lineStyle(2, 0,0.3);
			costume.graphics.lineTo(Math.random()* 3, 1);
		}
		
		public function draw1():void
		{//Crvena mrlja
			costume.graphics.lineStyle(3, LaserContignous.LaserColours[2], 0.2);
			costume.graphics.beginFill(LaserContignous.LaserColours[2], 0.2);
			costume.graphics.drawRect( -1, -4 , 2, Math.random()*10 + 4);
			//costume.filters = [new BlurFilter(Math.random()*5,Math.random()*5)];
		}
		
	}

}