package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class ParallaxLayer  
	{
		
		
		var startPos:b2Vec2;
		var endY:Number;
		var sprite:Sprite;
		var maxCameraOffset:Number;
		var dirAndTotalLenghtOfMov:Number;
		var movingRatio:Number;
		
		
		public function ParallaxLayer(spr:Sprite, sPos:b2Vec2, eY:Number) 
		{
			startPos = sPos;
			endY = eY;
			
			sprite = spr;
			sprite.x = startPos.x;
			sprite.y = startPos.y;
			
			Global.gameCanvas.addChild(sprite);
				
			maxCameraOffset = Global.currentLevel._height - Global.screenHeight;
			
			if (maxCameraOffset)
			{
				dirAndTotalLenghtOfMov = endY - startPos.y;
				movingRatio = 1 / (maxCameraOffset / dirAndTotalLenghtOfMov);
			}
			else movingRatio = 0;
			
			//trace(startPos.y);
		}
		
		public function Update()
		{
			sprite.y = startPos.y + Global.gameCanvas.y * movingRatio;
		}
		
	}

}