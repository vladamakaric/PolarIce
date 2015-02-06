package  
{
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	/**
	 * ...
	 * @author Mikhail
	 */
	public class LaserSparkParticle extends Particle
	{
		var _usporavanje:Number = 8 / 10;
		var _brzina = 20;
		
		public function LaserSparkParticle(parentContainer:DisplayObjectContainer, position:b2Vec2 , partType:int) 
		{
			
			var speed:b2Vec2 = new b2Vec2(0, -_brzina);
				var mat:b2Mat22 = new b2Mat22();
				mat.Set(Math.random() * (Math.PI * 2));
				speed.MulM(mat);
				
				speed.Multiply(0.5);
				
			super(parentContainer, Sprite , position, speed);
			costume.rotation = mat.GetAngle() / Math.PI * 180;
			
			switch(partType)
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
				//
				break;
			}
		}
		
		public function draw0():void 
		{
			var bot:int = -(Math.random() * 8);
			var thck:int = Math.random() * 7 + 1;
			
			costume.graphics.lineStyle(thck, 0xFE864B, .8);
			costume.graphics.moveTo(0, bot);
			costume.graphics.lineTo(0, Math.random()*6);
			costume.graphics.lineStyle(thck /3 , 0xFFF1C6, 1);
			costume.graphics.lineTo(0, bot );
		}
		
		public function draw1():void
		{
			costume.graphics.lineStyle(1, 0xFF8282);
			costume.graphics.beginFill(0xFF8282);
			costume.graphics.drawCircle(0, 0, Math.random() * 3 + 1);
			//costume.filters = [new BlurFilter(2, 2)];
		}
		
		public function draw2():void
		{
			costume.graphics.lineStyle(1, 0);
			costume.graphics.beginFill(0);
			costume.graphics.drawRect(0, 0, 1, 1);
			
		}
		
		override public function update()
		{
			//trace("pos : " + position.x + " , " + position.y);
			//trace("vel : " + velocity.x + " , " + position.y);
			costume.alpha -= .06;
			costume.scaleY -= .15;
			velocity.Multiply(_usporavanje);
			super.update();
		}
		
		override public function done():Boolean 
		{
			//return costume.alpha <= 0;
			return costume.scaleY <= 0;
		}
		
	}

}