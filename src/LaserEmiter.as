package  
{
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class LaserEmiter extends Actor
	{
		
		
		public static var DOWN:int = 0;
		public static var UP:int = 1;
		public static var LEFT:int = 2;
		public static var RIGHT:int = 3;
		
		var laser:LaserContignous;
		var laserStartPosition:b2Vec2;
		var angle:Number;
		
		var laserPosOffset:Number = 8.5;
		
		
		public function LaserEmiter(position:b2Vec2, laserShootOutDir:Number, angl:Number, lsrSpd:Number = 0.1 )
		{
			super(new LaserStand());
			

			angle = angl;
			
			
			
			laser = new LaserContignous(Global.gameCanvas, position, angle, lsrSpd);
			
			
			laserStartPosition = position.Copy();
			//Functions.DivideB2Vec2ByRatio(laserStartPosition);
			
			if (laserShootOutDir == DOWN)
			{
				
				laserStartPosition.y += laserPosOffset;
				_costume.scaleY = -1;
				
			}
			else
			if (laserShootOutDir == LEFT)
			{
				laserStartPosition.x -= laserPosOffset;
				_costume.scaleX = -1;
				_costume.rotation = -90;
				
			}
			else
			if (laserShootOutDir == RIGHT)
			{
				laserStartPosition.x += laserPosOffset;
				_costume.rotation = 90;
			}
			else
			if (laserShootOutDir == UP)
			{
				laserStartPosition.y -= laserPosOffset;
			}
			
			Functions.DivideB2Vec2ByRatio(laserStartPosition);
			
			_costume.x = position.x;
			_costume.y = position.y;
			
			Global.gameCanvas.addChild(_costume);
		}
		
		override public function childSpecificUpdating():void 
		{
			laser.shoot(laserStartPosition, angle);
			laser.update();
			
			
			//super.childSpecificUpdating();
		}
		
	}

}