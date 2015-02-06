package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class StaticActor extends Actor
	{
		public function StaticActor(parent:DisplayObjectContainer, 
		                            location:Point, 
									arrayOfCoords:Array,
									spriteToUse:Class = null)
		{
			var myBody:b2Body = createBodyFromCoords(arrayOfCoords, location);
			var mySprite:Sprite;
			
			if (spriteToUse != null)
			{
				mySprite = new spriteToUse();
				parent.addChild(mySprite);
			}
			else
			mySprite = createSpriteFromCoords(arrayOfCoords, location, parent);

			
			super(myBody, mySprite);
		}
		
		
		
		
		private function createSpriteFromCoords(arrayOfCoords:Array, location:Point, parent:DisplayObjectContainer):Sprite
		{
			var newSprite:Sprite = new Sprite();
			newSprite.graphics.lineStyle(2, 0x00D900);
			
			for each(var listOfPoints:Array in arrayOfCoords)
			{
			    var firstPoint:b2Vec2 = listOfPoints[0];
				newSprite.graphics.moveTo(firstPoint.x, firstPoint.y);
				newSprite.graphics.beginFill(0x00D900);
				
				for each (var newPoint:b2Vec2 in listOfPoints)
				{
				    newSprite.graphics.lineTo(newPoint.x, newPoint.y);	
				}
				
				newSprite.graphics.lineTo(firstPoint.x, firstPoint.y);
				newSprite.graphics.endFill();
			}
			
			newSprite.x = location.x;
			newSprite.y = location.y;
			
			parent.addChild(newSprite);
			
			return newSprite;
		}
		
		private function createBodyFromCoords( arrayOfCoords:Array, location:Point):b2Body
		{
			var allFixtures:Array = [];
			
			for each (var listOfPointsOrig:Array in arrayOfCoords)
			{
				var newFix:b2FixtureDef = new b2FixtureDef();
				var newPolyShape :b2PolygonShape = new b2PolygonShape();
				
				var listOfPoints:Array = new Array(); 
						
				for (var i:int = 0; i < listOfPointsOrig.length; i++) 
				{
					listOfPoints.push(new b2Vec2(b2Vec2(listOfPointsOrig[i]).x, b2Vec2(listOfPointsOrig[i]).y ));
					
					b2Vec2(listOfPoints[i]).Set(  listOfPoints[i].x / Global.RATIO, listOfPoints[i].y / Global.RATIO);
				}	
				
				newPolyShape.SetAsArray(listOfPoints, listOfPoints.length);
				
				newFix.shape = newPolyShape;
				
				allFixtures.push(newFix);
			}
			
			var arbiBodyDef:b2BodyDef = new b2BodyDef();
			arbiBodyDef.position.Set(location.x / Global.RATIO , location.y / Global.RATIO );
			
			var arbiBody:b2Body = Global.world.CreateBody(arbiBodyDef);
			
			for each (var newFixDef:b2FixtureDef in allFixtures)
			{
			   arbiBody.CreateFixture(newFixDef);	
			}
			
			return arbiBody;
		}
		
	}
}