package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class StaticPlatform extends FloorActor
	{
		public function StaticPlatform(position:b2Vec2, width:Number, height:Number, blockNumber:Number, spaceBetween:Number, ratioArray:Array) 
		{
			super(new Sprite());
			
			var spaceBetweenCounter = blockNumber - 1;
			var totalSpaceBetween = spaceBetweenCounter * spaceBetween;
			var blockCombinedWidth = width - totalSpaceBetween;
			
			var ratioSum:Number;
			for each(var ratio:Number in ratioArray)
				ratioSum += Math.abs(ratio);
			
			var ratioMultiplyer:Number = blockCombinedWidth / ratioSum;
			
			var currentX:Number = -width/2;
			for each(var ratio:Number in ratioArray)
			{
				var currentSprite:Sprite;
				
				if (Math.random() > 0.5)
					currentSprite = new SquareRock1();
				else
					currentSprite = new SquareRock2();
				
				currentSprite.height = height;
				currentSprite.width = ratio * ratioMultiplyer;
				currentSprite.x = currentX + currentSprite.width/2;
				currentX += currentSprite.width + spaceBetween; 
				
				Sprite(_costume).addChild(currentSprite);
			}
			
			var centerPosition:b2Vec2 = position;
			centerPosition.x += width / 2;
			centerPosition.y += height / 2;
			Functions.DivideB2Vec2ByRatio(centerPosition);
	
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			  
			groundBodyDef.position = centerPosition;
			var groundBody:b2Body = Global.world.CreateBody(groundBodyDef);
			groundBody.SetUserData(this);
			
			var groundShape:b2PolygonShape = new b2PolygonShape();
			groundShape.SetAsBox(width/2   / Global.RATIO, height/2  / Global.RATIO);
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
			groundFixtureDef.shape = groundShape;
			
			groundFixtureDef.friction = 0.1;
			//groundFixtureDef.restitution = 2;
			groundBody.CreateFixture(groundFixtureDef);
			
			Global.gameCanvas.addChild(_costume);
			updateCostumePositionAndRotation();
		}
	}
}