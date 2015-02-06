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
	public class SpikeStrip extends Actor
	{
		static var LEFT:int = 0;
		static var RIGHT:int = 1;
		static var UP:int = 2;
		static var DOWN:int = 3;
		
		public function SpikeStrip(topLeft:b2Vec2, width:Number, height:Number,spikeDirection:int, spikeNum:int ) 
		{
			
			super(new Sprite());
			var bottomRight:b2Vec2 = topLeft.Copy();
			bottomRight.x += width;
			bottomRight.y += height;
			
			var position:b2Vec2 = topLeft.Copy();
			
			position.x += width / 2;
			position.y += height / 2;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			position.x /= Global.RATIO;
			position.y /= Global.RATIO;
			bodyDef.position = position;
			bodyDef.type = b2Body.b2_staticBody;
			_body = Global.world.CreateBody(bodyDef);
			_body.SetUserData(this);
			
			var spikeSpr:Spike = new Spike();
			var spikeOrigHeight:Number = spikeSpr.height;
			var spikeOrigWidth:Number = spikeSpr.width;
			
			var spikeNum:int;
			var currX:Number;
			var currY:Number;
			var newSpikeWidth:Number;
			var newSpikeHeight:Number;
			
			var middleWidth:Number = bottomRight.x - width / 2;
			var middleHeight:Number = bottomRight.y - height / 2;

			var sensorFixtureDef:b2FixtureDef = new b2FixtureDef();
			var sensorShape:b2PolygonShape = new b2PolygonShape();
			
			var bodyArr:Array;

			
			
			
			
			if (spikeDirection == UP || spikeDirection == DOWN)
			{
				newSpikeHeight = height;
				newSpikeWidth = (newSpikeHeight * spikeOrigWidth) / spikeOrigHeight;
				spikeNum = width / newSpikeWidth;
				if (spikeNum == 0)
				spikeNum = 1;
			
				
				
				currX = topLeft.x + newSpikeWidth / 2;
				currY = middleHeight;
				
				if (spikeDirection == UP)
				{
					if (spikeNum > 1 )
					{
						bodyArr = [ new b2Vec2(  -(width / 2 - newSpikeWidth / 2), -height / 2), new b2Vec2(-1*(width / 2 - newSpikeWidth / 2) + (spikeNum-1) * newSpikeWidth, -height / 2), 
						new b2Vec2((spikeNum * newSpikeWidth) - width / 2, height / 2), new b2Vec2( -width / 2, height / 2)];
					}
					else
					{
						bodyArr = [ new b2Vec2(  -newSpikeWidth / 2, height / 2), new b2Vec2(0, -height / 2 ), new b2Vec2(newSpikeWidth / 2, height / 2)];
					}
				}
				else
				{
					bodyArr = [ new b2Vec2( -width / 2, -height / 2), new b2Vec2((spikeNum * newSpikeWidth) - width / 2, -height / 2), 
					new b2Vec2(-1*(width / 2 - newSpikeWidth / 2) + (spikeNum-1) * newSpikeWidth, height / 2), new b2Vec2(  -(width / 2 - newSpikeWidth / 2), height / 2) ];	
				}
				
				for (var i:int = 0; i < spikeNum; i++ )
				{
					var tempSpike:Spike = new Spike();
					
					tempSpike.width = newSpikeWidth;
					tempSpike.height = newSpikeHeight;
						
					tempSpike.x = currX;
					tempSpike.y = currY;
									
					if (spikeDirection == DOWN)
						tempSpike.scaleY *= -1;
					
					currX += newSpikeWidth;
					Global.gameCanvas.addChild(tempSpike);
				}
			}
			else
			{
				newSpikeHeight = width;
				newSpikeWidth = (newSpikeHeight*spikeOrigWidth)/spikeOrigHeight;
				spikeNum = height / newSpikeWidth;
				
				currX = middleWidth;
				currY = topLeft.y + newSpikeWidth/2;
				
				if (spikeDirection == LEFT)
				{
					bodyArr = [ new b2Vec2( width / 2, -height / 2), new b2Vec2(width / 2, -height / 2 + spikeNum * newSpikeWidth), 
					new b2Vec2(-width / 2, -height / 2 + newSpikeWidth/2 + (spikeNum-1) * newSpikeWidth ), new b2Vec2(-width / 2, -height / 2 + newSpikeWidth/2)];
				}
				else
				{
					bodyArr = [ new b2Vec2(width / 2, -height / 2 + newSpikeWidth/2), new b2Vec2(width / 2, -height / 2 + newSpikeWidth/2 + (spikeNum-1) * newSpikeWidth ), 		
					new b2Vec2(-width / 2, -height / 2 + spikeNum * newSpikeWidth) , new b2Vec2( -width / 2, -height / 2) ];
				}
				
				for (var i:int = 0; i < spikeNum; i++ )
				{
					var tempSpike:Spike = new Spike();
					
					tempSpike.width = newSpikeWidth;
					tempSpike.height = newSpikeHeight;
					tempSpike.rotation = 90;
					tempSpike.x = currX;
					tempSpike.y = currY;
									
					if (spikeDirection == LEFT)
						tempSpike.scaleY *= -1;
					
					currY += newSpikeWidth;
					Global.gameCanvas.addChild(tempSpike);
				}
			}
			
			
			var vecNum:int = 4;
			
			if (spikeNum == 1)
			vecNum = 3;
			
			Functions.DivideB2Vec2ArrayByRatio(bodyArr);
			sensorShape.SetAsArray(bodyArr, vecNum);
			sensorFixtureDef.shape = sensorShape;
			sensorFixtureDef.isSensor = true;
			_body.CreateFixture(sensorFixtureDef);
		}
		
		override public function childSpecificUpdating():void 
		{
			
		}
		
		
	}

}