package  
{
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Contacts.b2Contact;
	import fl.motion.Color;
	import fl.transitions.TransitionManager;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class Functions
	{
		public static const halfPI:Number = Math.PI / 2;
		
		public function Functions() 
		{
			
		}

		static function fromTwoObjectsIsOneClass_ReturnNullOrObj(obj1:*, obj2:*, className:Class):*
		{
			if (obj1 is className)
				return obj1;
			
			if (obj2 is className)
				return obj2;
			
			return null;	
		}
		
		static function fromTwoObjectsIsOneClass_ReturnConditionAndTwoObjects(obj1:*, obj2:*, className:Class):Array
		{
			if (obj1 is className)
				return [true, obj1, obj2];
			
			if (obj2 is className)
				return [true, obj2, obj1];
			
			return [false];
		}
		
		static function getCollidedBodys(contact:b2Contact):Array
		{
			return [contact.GetFixtureB().GetBody().GetUserData(), contact.GetFixtureA().GetBody().GetUserData()];
		}
		
		static function doBothCollidedBodysHaveUserData(contact:b2Contact):Boolean
		{
			if (contact.GetFixtureA().GetBody().GetUserData() == null || contact.GetFixtureB().GetBody().GetUserData() == null)
				return false;
				
			return true;
		}

		static function GetVectorFromAToB(A:b2Vec2, B:b2Vec2):b2Vec2
		{
			var tempVec:b2Vec2 = B.Copy();
			tempVec.Subtract(A);
			return tempVec;
		}
		
		static function PerpVector(vec:b2Vec2):void
		{
			vec.Set( -vec.y, vec.x);
		}
		
		
		static function GetRandomSnowEdgeSprite():Class
		{
			var rand:int = (Math.random() * 4);
			
			switch(rand)
			{
				case 0:
				return SnowEdge1;

				case 1:
				return SnowEdge2;

				case 2:
				return SnowEdge3;
				
				case 3:
				return SnowEdge4;

				default:
				return SnowEdge1;
			}
		}
		
		static function GetRandomSnowCoverSprite():Class
		{
			var rand:int = (Math.random() * 4);
			
			switch(rand)
			{
				case 0:
				return SnowCover1;

				case 1:
				return SnowCover2;

				case 2:
				return SnowCover3;

				case 3:
				return SnowCover4;

				default:
				return SnowCover1;
			}
		}
		
		static function AddSnowToPlatform(platformSprite:Sprite, width:Number, height:Number)
		{
			var leftEdgeWidthOnPlatform:Number;
			var rightEdgeWidthOnPlatform:Number;

			var leftEdgeSnow:Sprite = new (GetRandomSnowEdgeSprite())();
			//RandomSnowEdgeSprite(leftEdgeSnow);
			leftEdgeSnow.y = - height / 2;
			leftEdgeSnow.x = - width / 2 + (leftEdgeSnow.width / 2 - 5);
			leftEdgeWidthOnPlatform = leftEdgeSnow.width / 2 - 5;
			platformSprite.addChild(leftEdgeSnow);
			
			var rightEdgeSnow:Sprite = new (GetRandomSnowEdgeSprite())();
			rightEdgeSnow.scaleX *= -1;
			rightEdgeSnow.y = - height / 2;
			
			rightEdgeWidthOnPlatform = rightEdgeSnow.width / 2 - 5;
			rightEdgeSnow.x = + width / 2 - (rightEdgeSnow.width / 2 - 5);
			platformSprite.addChild(rightEdgeSnow);
			
			var widthOfSnowCoverPiece:Number = 43;
			
			var remainingWidthOfPlatform:Number = width - (rightEdgeWidthOnPlatform + leftEdgeWidthOnPlatform);
			
			if (remainingWidthOfPlatform > 0)
			{
				var snowPiecesNum:int = remainingWidthOfPlatform / widthOfSnowCoverPiece + 1;
				
				var snowPieceXStep:Number = remainingWidthOfPlatform / snowPiecesNum;
				
				var currX:Number = - width / 2 + leftEdgeWidthOnPlatform
				for (var i:Number = 0; i < snowPiecesNum; i++ )
				{
					currX += snowPieceXStep;
					
					
					var snowCoverSpr:Sprite = new (GetRandomSnowCoverSprite())();
				//	RandomSnowCoverSprite(snowCoverSpr);
					
					
					if (Math.random() > 0.5)
						snowCoverSpr.scaleX *= -1;
					
					snowCoverSpr.x = currX;
					snowCoverSpr.y = leftEdgeSnow.y;
					
					platformSprite.addChild(snowCoverSpr);
				}
			}
		}
		
		static function AddStaticBlockPlatform(position:b2Vec2, width:Number, height:Number, blockNumber:Number, spaceBetween:Number, ratioArray:Array) 
		{
			var costume:Sprite = new Sprite();
			
			var spaceBetweenCounter:Number = blockNumber - 1;
			var totalSpaceBetween:Number = spaceBetweenCounter * spaceBetween;
			var blockCombinedWidth:Number = width - totalSpaceBetween;
			
			var ratioSum:Number = 0;
			
			
			for ( var i:Number = 0; i < blockNumber; i++ )
				ratioSum += Math.abs(ratioArray[i]);
			
			var ratioMultiplyer:Number = blockCombinedWidth / ratioSum;
			

			var currentX:Number = -width / 2;

			
			for (var i:Number = 0; i < blockNumber; i++ )
			{
				var ratio:Number = ratioArray[i];
				
				var currentSprite:Sprite;
				
				
				if (Math.random() > 0.5)
					currentSprite = new SquareRock1();
				else
					currentSprite = new SquareRock2();
					
				if (Math.random() > 0.5)
					currentSprite.scaleX = -1;

				currentSprite.height = height;
				currentSprite.width = ratio * ratioMultiplyer;
				
				currentSprite.x = currentX + currentSprite.width/2;
				currentX += currentSprite.width + spaceBetween; 
				
				/*
				if (i < blockNumber - 1)
				{
					var currentBetweenBlocksBlack:Sprite = new BlackBetweenBlocks1();
						
					currentBetweenBlocksBlack.height = height * 0.92;
					currentBetweenBlocksBlack.width = spaceBetween * 7.5;
						
					currentBetweenBlocksBlack.x = currentX - spaceBetween / 2;
					costume.addChild(currentBetweenBlocksBlack);
				}*/
				//currentBetweenBlocksBlack.width = spaceBetween * 2;
				
				costume.addChild(currentSprite);
			}
////////////////////////////////////////////////


			AddSnowToPlatform(costume, width, height);
			
			
			
///////////////////////////////////////////////////////////////		
			var centerPosition:b2Vec2 = position;
			centerPosition.x += width / 2;
			centerPosition.y += height / 2;
			Functions.DivideB2Vec2ByRatio(centerPosition);
	
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			  
			groundBodyDef.position = centerPosition;
			var groundBody:b2Body = Global.world.CreateBody(groundBodyDef);
			
			
			var groundShape:b2PolygonShape = new b2PolygonShape();
			groundShape.SetAsBox(width/2   / Global.RATIO, height/2  / Global.RATIO);
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
			groundFixtureDef.shape = groundShape;

			groundFixtureDef.friction = 0.1;
			//groundFixtureDef.restitution = 2;
			groundBody.CreateFixture(groundFixtureDef);
			groundBody.SetUserData(new FloorActor(new Shtani()));
			
			costume.x = groundBody.GetPosition().x * Global.RATIO;
			costume.y = groundBody.GetPosition().y * Global.RATIO;
			Global.gameCanvas.addChild(costume);
		}
		
		static function AddStaticIceBlockPlatform(position:b2Vec2, width:Number, height:Number, blockNumber:Number, spaceBetween:Number, ratioArray:Array) 
		{
			var costume:Sprite = new Sprite();
			
			var spaceBetweenCounter:Number = blockNumber - 1;
			var totalSpaceBetween:Number = spaceBetweenCounter * spaceBetween;
			var blockCombinedWidth:Number = width - totalSpaceBetween;
			
			var ratioSum:Number = 0;
			
			
			for ( var i:Number = 0; i < blockNumber; i++ )
				ratioSum += Math.abs(ratioArray[i]);
			
			var ratioMultiplyer:Number = blockCombinedWidth / ratioSum;
			

			var currentX:Number = -width / 2;

			
			for (var i:Number = 0; i < blockNumber; i++ )
			{
				var ratio:Number = ratioArray[i];
				
				var currentSprite:Sprite;
				
				if (Math.random() > 0.5)
					currentSprite = new IceBoux1();
				else
					currentSprite = new IceBoux1();
					
				if (Math.random() > 0.5)
					currentSprite.scaleX = -1;

				currentSprite.height = height;
				currentSprite.width = ratio * ratioMultiplyer;
				
				currentSprite.x = currentX + currentSprite.width/2;
				currentX += currentSprite.width + spaceBetween; 
				
			/*	if (i < blockNumber - 1)
				{
					var currentBetweenBlocksBlack:Sprite = new BlackBetweenBlocks1();
						
					currentBetweenBlocksBlack.height = height * 0.92;
					currentBetweenBlocksBlack.width = spaceBetween * 7.5;
						
					currentBetweenBlocksBlack.x = currentX - spaceBetween / 2;
					costume.addChild(currentBetweenBlocksBlack);
				}*/
				//currentBetweenBlocksBlack.width = spaceBetween * 2;
				
				costume.addChild(currentSprite);
			}

			var centerPosition:b2Vec2 = position;
			centerPosition.x += width / 2;
			centerPosition.y += height / 2;
			Functions.DivideB2Vec2ByRatio(centerPosition);
	
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			  
			groundBodyDef.position = centerPosition;
			var groundBody:b2Body = Global.world.CreateBody(groundBodyDef);
			groundBody.SetUserData(new FloorActor(new Shtani()));
			
			var groundShape:b2PolygonShape = new b2PolygonShape();
			groundShape.SetAsBox(width/2   / Global.RATIO, height/2  / Global.RATIO);
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
			groundFixtureDef.shape = groundShape;

			groundFixtureDef.friction = 0.0000000000001;
			//groundFixtureDef.restitution = 2;
			groundBody.CreateFixture(groundFixtureDef);
			
			
			costume.x = groundBody.GetPosition().x * Global.RATIO;
			costume.y = groundBody.GetPosition().y * Global.RATIO;
			Global.gameCanvas.addChild(costume);
		}
		
		static function AddInvisibleRectangle(topLeftPosition:b2Vec2, width:Number, height:Number) 
		{
			var rectangle:Shape = new Shape(); // initializing the variable named rectangle
			rectangle.graphics.beginFill(0x00FFFF); // choosing the colour for the fill, here it is red
			rectangle.graphics.drawRect(topLeftPosition.x, topLeftPosition.y, width,height); // (x spacing, y spacing, width, height)
			rectangle.graphics.endFill();
			Global.gameCanvas.addChild(rectangle);
			
			var centerPosition:b2Vec2 = topLeftPosition;
			centerPosition.x += width / 2;
			centerPosition.y += height / 2;
			centerPosition.y /= Global.RATIO;
			centerPosition.x /= Global.RATIO;
				
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			  
			groundBodyDef.position = centerPosition;
			var groundBody:b2Body = Global.world.CreateBody(groundBodyDef);
			groundBody.SetUserData(new FloorActor(new Shtani()));
			
			var groundShape:b2PolygonShape = new b2PolygonShape();
			groundShape.SetAsBox(width/2   / Global.RATIO, height/2  / Global.RATIO);
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
			groundFixtureDef.shape = groundShape;
			
			groundFixtureDef.friction = 0.1;
			//groundFixtureDef.restitution = 2;
			var groundFixture:b2Fixture = groundBody.CreateFixture(groundFixtureDef);
			

			
		}
		
		static function tintColor(mc:Sprite, colorNum:Number, alphaSet:Number):void 
		{
			var cTint:Color = new Color();
			cTint.setTint(colorNum, alphaSet);
			mc.transform.colorTransform = cTint;
		}
		
		static function CollidedFixtureBodyHasUserData(contact:b2Contact, userData:*):Boolean
		{
			return (contact.GetFixtureA().GetBody().GetUserData() == userData) || (contact.GetFixtureB().GetBody().GetUserData() == userData);
		}
		
		static function AnyContactFixtureIsSensor(contact:b2Contact):Boolean
		{
			return contact.GetFixtureA().IsSensor() ||	contact.GetFixtureB().IsSensor();
		}
		
		static function getCollidedBody(contact:b2Contact, bodyClass:Class):*
		{
			if (contact.GetFixtureA().GetBody().GetUserData() is bodyClass)
				return contact.GetFixtureA().GetBody().GetUserData();
				else
				return contact.GetFixtureB().GetBody().GetUserData();
		}
		
		static function getCollidedBodyThatIsNot(contact:b2Contact, bodyClass:Class):*
		{
				if (contact.GetFixtureA().GetBody().GetUserData() is bodyClass)
				return contact.GetFixtureB().GetBody().GetUserData();
				else
				return contact.GetFixtureA().GetBody().GetUserData();
		}
		
		static function CollidedBodyIs_RetiturnUDObjectAndOtherFixture(contact:b2Contact, bodyClass:Class):Array
		{
			if(contact.GetFixtureA().GetBody().GetUserData() != null)
			if (contact.GetFixtureA().GetBody().GetUserData() is bodyClass)
				return [1, contact.GetFixtureA().GetBody().GetUserData(), contact.GetFixtureB()];
			
			
			if(contact.GetFixtureB().GetBody().GetUserData() != null)
			if (contact.GetFixtureB().GetBody().GetUserData() is bodyClass)
				return [1, contact.GetFixtureB().GetBody().GetUserData(), contact.GetFixtureA()];
			
			return [0];
		}
		
		
		static function areCollidedBodys_ReturnFirstFixture(contact:b2Contact, class1:Class, class2:Class):b2Fixture
		{
			if (contact.GetFixtureA().GetBody().GetUserData() == null || contact.GetFixtureB().GetBody().GetUserData() == null)
			return null;
			
			if(contact.GetFixtureA().GetBody().GetUserData() is class1 && 
			contact.GetFixtureB().GetBody().GetUserData() is class2) 
			{
				return contact.GetFixtureA();
			}
			else
			if(contact.GetFixtureA().GetBody().GetUserData() is class2 && 
			contact.GetFixtureB().GetBody().GetUserData() is class1) 
			{
				return contact.GetFixtureB();
			}
			
			return null;
		}
		
		static function areCollidedBodys_ReturnBodyArray(contact:b2Contact, class1:Class, class2:Class):Array
		{
			if (contact.GetFixtureA().GetBody().GetUserData() == null || contact.GetFixtureB().GetBody().GetUserData() == null)
			return [false];
			
			if(contact.GetFixtureA().GetBody().GetUserData() is class1 && 
			contact.GetFixtureB().GetBody().GetUserData() is class2) 
			{
				return [true,contact.GetFixtureA().GetBody().GetUserData(), contact.GetFixtureB().GetBody().GetUserData()];
			}
			else
			if(contact.GetFixtureA().GetBody().GetUserData() is class2 && 
			contact.GetFixtureB().GetBody().GetUserData() is class1) 
			{
				return [true, contact.GetFixtureB().GetBody().GetUserData(), contact.GetFixtureA().GetBody().GetUserData()];
			}
			
			return [false];
		}
		

		
		
		
		static function areCollidedBodys(contact:b2Contact, class1:Class, class2:Class):Boolean
		{		
			if (contact.GetFixtureA().GetBody().GetUserData() == null || contact.GetFixtureB().GetBody().GetUserData() == null)
			return false;

			if(contact.GetFixtureA().GetBody().GetUserData() is class1 && 
			contact.GetFixtureB().GetBody().GetUserData() is class2) 
			{
				return true;
			}
			else
			if(contact.GetFixtureA().GetBody().GetUserData() is class2 && 
			contact.GetFixtureB().GetBody().GetUserData() is class1) 
			{
				return true;
			}

			return false;
		}
		
		static function createFixture(body:b2Body, shape:*, density:Number, restitution:Number = -1 , friction:Number = -1):void
		{
			var fd:b2FixtureDef = getFixtureDef(shape, density, restitution, friction);			
			body.CreateFixture(fd);
		}
		
		static function getFixtureDef(shape:*, density:Number, restitution:Number = -1 , friction:Number = -1):b2FixtureDef
		{
			var fd:b2FixtureDef = new b2FixtureDef();
			fd.density = density;
			
			if (restitution != -1)
			fd.restitution = restitution;
			
			if (friction != -1)
			fd.friction = friction;
			
			
			fd.restitution = 0.3;
			fd.friction = 0.5;
			
			fd.shape = shape;
			
			return fd;
		}
		
		static function CircleGenerator(position:b2Vec2, radius:Number, density:Number, restitution:Number = -1 , friction:Number = -1):b2Body
		{
			position.Set(position.x / Global.RATIO, position.y / Global.RATIO);
			var wheelBodyDef:b2BodyDef = new b2BodyDef();
			wheelBodyDef.position = position;
			wheelBodyDef.type = b2Body.b2_dynamicBody;
			var wheelBody:b2Body = Global.world.CreateBody(wheelBodyDef);
			var circleShape:b2CircleShape = new b2CircleShape(radius / Global.RATIO );
			var wheelFixtureDef:b2FixtureDef = new b2FixtureDef();
			wheelFixtureDef.shape = circleShape;
			
			if (restitution != -1)
			wheelFixtureDef.restitution = restitution;
			
			if (friction != -1)
			wheelFixtureDef.friction = friction;
			
			wheelFixtureDef.density = density;
			var wheelFixture:b2Fixture = wheelBody.CreateFixture(wheelFixtureDef);	
			
			return wheelBody;
		}
		
	
		
		static function ProcessedAngleDifferenceSmallerThan(diffAmount:Number, ang1:Number, ang2:Number):Boolean
		{
			if (Math.abs(ang1 - ang2) < diffAmount || Math.abs(ang1-ang2) > Math.PI*2 - diffAmount)
				return true;
				
			return false;
		}
		
		static function GetRandomStageCoordinates():b2Vec2
		{
			var x:Number = Math.random() * Global.stage.stageWidth / Global.RATIO;
			var y:Number = Math.random() * Global.stage.stageHeight / Global.RATIO;	
			
			return new b2Vec2(x, y);
		}
		
		static function ProcessGroundedFlagsForWalkingActors(contact:b2Contact, grounded:Boolean)
		{
			var arr:Array = areCollidedBodys_ReturnBodyArray(contact, WalkingActor, FloorActor);
			
			if (!arr[0])
				return;
			
			var walkingFixture:b2Fixture = WalkingActor(arr[1])._body.GetFixtureList();
			
			if (!walkingFixture.IsSensor())
				return;

			//if (Math.abs(manif.m_normal.y) != 1)  //novo
			//return;
				
			
			
			if(grounded)
			WalkingActor(arr[1])._groundedCounter += 1;
			else
			WalkingActor(arr[1])._groundedCounter -= 1;
			
			WalkingActor(arr[1]).determineGroundedness();
			
			if (arr[2] is PushingEnemy)
			{
				if (grounded)
				PushingEnemy(arr[2]).standingWalkingActorsCount++;
					else
				PushingEnemy(arr[2]).standingWalkingActorsCount--;
			}
		}
		
		public static function getRandomVector(vm:Number):b2Vec2
		{
			var angle:Number = Math.PI * 2 * Math.random();
			return new b2Vec2(Math.cos(angle) * vm, Math.sin(angle) * vm);
		}
		static function GetProcessedAngleFromVector(vector:b2Vec2):Number
		{
			var angle:Number = Math.atan2(vector.x, vector.y);

			angle = Math.abs(angle);
			
			if (vector.x < 0)
			angle += Math.PI;
			else
			angle = Math.PI - angle;
			
			while (angle > Math.PI * 2)
				angle -= Math.PI * 2;
				
			return angle;
		}
		
		static function getProcessedAngle(angle:Number):Number
		{
			angle = Math.abs(angle);
			
			while (angle > Math.PI * 2)
				angle -= Math.PI * 2;
				
			return angle;
		}
		
		static function GetDistanceBetweenB2Vec2(pointA:b2Vec2, pointB:b2Vec2):Number
		{
			return Math.sqrt( (pointA.x - pointB.x) * (pointA.x - pointB.x) + (pointA.y - pointB.y) * (pointA.y - pointB.y));
		}
		
		static function reflectB2Vec2PolygonHorizontally(vecArr:Array):void
		{
			for each(var vector:b2Vec2 in vecArr)
			{
				vector.x *= -1;
			}
			
			vecArr.reverse();
		}
		
		
		static function DivideB2Vec2BySpecificRatio(vector:b2Vec2, sr:Number):void
		{
			vector.Multiply(1 / sr);
		}
		
		
		
		static function DivideB2Vec2ByRatio(vector:b2Vec2):void
		{
			vector.Multiply(1 / Global.RATIO);
		}
		
		static function MultiplyB2Vec2ByRatio(vector:b2Vec2):void
		{
			vector.Multiply(Global.RATIO);
		}
		
		static function DivideB2Vec2ArrayByRatio(vecArr:Array):void
		{
			for each(var vector:b2Vec2 in vecArr)
			{
				DivideB2Vec2ByRatio(vector);
			}
		}
		
		static function DivideB2Vec2ArrayBySpecificRatio(vecArr:Array, sr:Number):void
		{
			for each(var vector:b2Vec2 in vecArr)
			{
				DivideB2Vec2BySpecificRatio(vector, sr);
			}
		}
		
		static function GetB2Vec2ArrayPolygonWidth(vecArr:Array):Number
		{
			return Math.abs(GetMaxXFromB2Vec2Array(vecArr) - GetMinXFromB2Vec2Array(vecArr));
		}
		
		static function GetB2Vec2ArrayPolygonHeight(vecArr:Array):Number
		{
			return Math.abs(GetMaxYFromB2Vec2Array(vecArr) - GetMinYFromB2Vec2Array(vecArr));
		}
		
		static function OffsetB2Vec2Array( vecArr:Array, vecOffset:b2Vec2):void
		{
			for each(var vector:b2Vec2 in vecArr)
			{
				vector.Add(vecOffset);
			}
		}
		
		static function GetMaxYFromB2Vec2Array(vecArr:Array):Number
		{
			var maxY:Number = -10000;
			for each(var vector:b2Vec2 in vecArr)
			{
				if (vector.y > maxY)
					maxY = vector.y;
			}
			
			return maxY;
		}
		
		static function GetMaxXFromB2Vec2Array(vecArr:Array):Number
		{
			var maxX:Number = -10000;
			for each(var vector:b2Vec2 in vecArr)
			{
				if (vector.x > maxX)
					maxX = vector.x;
			}
			
			return maxX;
		}
		
		static function GetMinYFromB2Vec2Array(vecArr:Array):Number
		{
			var minY:Number = 10000;
			for each(var vector:b2Vec2 in vecArr)
			{
				if (vector.y < minY)
					minY = vector.y;
			}
			
			return minY;
		}
		
		static function GetMinXFromB2Vec2Array(vecArr:Array):Number
		{
			var minX:Number = 10000;
			for each(var vector:b2Vec2 in vecArr)
			{
				if (vector.x < minX)
					minX = vector.x;
			}
			
			return minX;
		}
	
	
		
	}

}