package  
{
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class MediumEnemy extends WalkingEnemy
	{
		var horWayOfMovement:Number = -1;
		var speed:Number = 0.8;		
		var regularSpeed:Number = 1.6;
		var pursuitSpeed:Number = 3.2;
		var dontMove:Boolean = false;
		
		var pursuit:Boolean = false;
		
		var orientation:Number = 1;
		var consistentHorWayOfMovCounter:Number = 0;
		
		var upperWidth:Number;
		
		var smallSpeedCounter:Number = 0;
		
		var playerNotDetectedCounter:Number = 0;
		
		var leftHand:MovieClip;
		var rightHand:MovieClip;
		var head:MovieClip;
		
		var pursuitOver:Boolean = true;
		
		public function MediumEnemy(position:b2Vec2) 
		{
			super(new PolarBearMC());
			_health = 2;
			_grounded = true;

			_width = 25;
			_height = 56;
			
			var bodyDef:b2BodyDef = new b2BodyDef();	  
		    position.x /= Global.RATIO;
		    position.y /= Global.RATIO;
		    bodyDef.position = position;
		    bodyDef.type = b2Body.b2_dynamicBody;  
			  
			_body = Global.world.CreateBody(bodyDef);
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(_width/2/Global.RATIO, _height/2/Global.RATIO);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			fixtureDef.density = 5.2;
			fixtureDef.friction = 0.3;
			_body.CreateFixture(fixtureDef);
			
			_body.SetFixedRotation(true);
			_body.ResetMassData();
			_body.SetUserData(this);
			_body.SetBullet(true);
			_body.SetLinearDamping(3);
			
			rightHand = new PBRukaAnimacijaTamna();
			leftHand = new PBRukaAnimacija();
			head = new PBHeadAnimation();

			head.stop();
			rightHand.gotoAndPlay(9);
			
			Global.gameCanvas.addChild(rightHand);
			Global.gameCanvas.addChild(_costume);
			Global.gameCanvas.addChild(leftHand);
			Global.gameCanvas.addChild(head);
			updateCostumePositionAndRotation();
		}

		private function Callback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number ):Number
		{
			if (fixture.GetBody().GetUserData() is WalkingEnemy)
			{
				if(fixture.GetBody().GetUserData() is MediumEnemy)
				{
					rayCast = false;
					return 0;
				}
				else
					return 1;
			}
			
			rayCast = false;
			return 0;
		}
		
		private function PathToPlayerClear(A:b2Vec2 , B:b2Vec2):Boolean 
		{
			rayCast = true;
			Global.world.RayCast(Callback, A, B);
			return rayCast;
		}
		
		public function ReverseMovement()
		{
			horWayOfMovement *= -1;
			consistentHorWayOfMovCounter = 0;
		}
		
		private function determineOrientation():void
		{
			if (consistentHorWayOfMovCounter > 2)
			{
				if (horWayOfMovement * _body.GetLinearVelocity().x >= 0)
				{
					orientation = horWayOfMovement;
					_costume.scaleX = horWayOfMovement;
					head.scaleX = _costume.scaleX;
					leftHand.scaleX = _costume.scaleX; 
					rightHand.scaleX = _costume.scaleX * 0.9;
					rightHand.scaleY = _costume.scaleY*0.9;
				}
			}

			if (pursuit)
			{
				pursuitOver = false;
				
				
				head.play();
				
				if (head.currentFrame == 13)
				head.gotoAndPlay(2); 
				
				if (dontMove)
				{
					if (MovieClip(_costume).currentFrame == 13)
					MovieClip(_costume).stop();
					else
					{
						MovieClip(_costume).nextFrame();
						MovieClip(_costume).play();	
					}
				}
				else
				{
					MovieClip(_costume).nextFrame();
					MovieClip(_costume).play();
				}

				if (leftHand.currentFrame == 28)
					leftHand.stop();
				
				if (leftHand.currentFrame == 9)
				{
					leftHand.gotoAndPlay(20);
				}
				
				if (rightHand.currentFrame == 28)
					rightHand.stop();
				
				if (rightHand.currentFrame == 9)
				{
					rightHand.gotoAndPlay(20);
				}
			}
			else
			{
				
				dontMove = false;
				
				if (head.currentFrame == 13)
				{
					pursuitOver = true;
				head.gotoAndStop(1); 
				}

				MovieClip(_costume).play();
				
				if (leftHand.currentFrame == 28)
					leftHand.play();
				
				if (leftHand.currentFrame == 18)
					leftHand.gotoAndPlay(1);

				if (rightHand.currentFrame == 28)
					rightHand.play();
					
				if (rightHand.currentFrame == 35)
				{
					rightHand.gotoAndPlay(9);
					
				}
					
					
				if (rightHand.currentFrame == 18)
					rightHand.gotoAndPlay(1);
			}
		}
		
		private function CheckForPlayer()
		{
			var prevPursuitStatus:Boolean = pursuit;
			
			
			var widthOfFrontBox = 200;
			var widthOfBackBox = 40;
			var heightOfBoxes = _height;
						
			var frontLowerBound:b2Vec2 = _body.GetWorldCenter().Copy();
			frontLowerBound.y += _height * 0.4 / Global.RATIO;
			frontLowerBound.x += (_width / 2 + 3) / Global.RATIO * horWayOfMovement;
			
			var frontUpperBound:b2Vec2 = frontLowerBound.Copy();
			frontUpperBound.x += widthOfFrontBox / Global.RATIO * horWayOfMovement;
			frontUpperBound.y -= heightOfBoxes / Global.RATIO;
			
			var backLowerBound:b2Vec2 = _body.GetWorldCenter().Copy();
			backLowerBound.x -= (_width / 2 + 3) / Global.RATIO * horWayOfMovement;
			backLowerBound.y =  frontLowerBound.y;
			
			var backUpperBound:b2Vec2 = backLowerBound.Copy();
			backUpperBound.x -= widthOfBackBox / Global.RATIO * horWayOfMovement;
			backUpperBound.y = frontUpperBound.y;
			
			if (horWayOfMovement>0)
			{
				var temp = frontUpperBound.x;
				frontUpperBound.x = frontLowerBound.x;
				frontLowerBound.x = temp;
			}
			else 
			{
				var temp = backUpperBound.x;
				backUpperBound.x = backLowerBound.x;
				backLowerBound.x = temp;
			}
			
			var frontBox:b2AABB = new b2AABB();
			frontBox.lowerBound = frontUpperBound;
			frontBox.upperBound = frontLowerBound;
			
			var backBox:b2AABB = new b2AABB();
			backBox.lowerBound = backUpperBound;
			backBox.upperBound = backLowerBound;

			var playerAABB:b2AABB = Global.player._body.GetFixtureList().GetNext().GetAABB();

			if (frontBox.TestOverlap(playerAABB))
			{
				var A:b2Vec2 = new b2Vec2();
				
				if(horWayOfMovement<0)
				A.x = frontLowerBound.x + 2/Global.RATIO;
				else
				A.x = frontUpperBound.x - 2/Global.RATIO;
				
				A.y = _body.GetWorldCenter().y;
				
				var B:b2Vec2 = A.Copy();
				B.x = Global.player._body.GetPosition().x - (Global.player._width / 2 + 4) / Global.RATIO * horWayOfMovement;

				if (PathToPlayerClear(A, B))
				{
					playerNotDetectedCounter = 0;
					pursuit = true;
				}
			}
			
			else if (backBox.TestOverlap(playerAABB) && Global.player._grounded)
			{
				var A:b2Vec2 = new b2Vec2();
				
				if(horWayOfMovement<0)
				A.x = backUpperBound.x + 3/Global.RATIO;
				else
				A.x = backLowerBound.x - 3/Global.RATIO;
				
				A.y = _body.GetWorldCenter().y;
				
				var B:b2Vec2 = A.Copy();
				B.x = Global.player._body.GetPosition().x + (Global.player._width / 2 + 4) / Global.RATIO * horWayOfMovement;

				if (PathToPlayerClear(A, B))
				{
					dontMove = false;
					ReverseMovement();
					
					pursuit = true;
					playerNotDetectedCounter = 0;
				}
			}
			else
			playerNotDetectedCounter++;
			
			
			
			if (playerNotDetectedCounter > 20)
				pursuit = false;
				
				
			if (!prevPursuitStatus && pursuit)
				Global.GAME.BearRoarSound.play();
			
		}

		override public function childSpecificUpdating():void 
		{
			consistentHorWayOfMovCounter++;

			if(Global.player != null)
			CheckForPlayer();
			else
			pursuit = false;

			var groundSurfaceCheckLenght:Number = 12;
		
			if (pursuit)
			groundSurfaceCheckLenght = 6;

			if (!CheckForGroundSurface(groundSurfaceCheckLenght, horWayOfMovement))
			{
				if (pursuit)
				dontMove = true;
				else
				{
					dontMove = false;
					ReverseMovement();
				}
			}

			if (_contactNum && playerNotDetectedCounter)
			{
				dontMove = false;
				pursuit = false;	
			}
			
			if (!pursuit)
			{	
				if (Math.abs(_body.GetLinearVelocity().x) < 0.05 && _grounded )
					smallSpeedCounter++
				else
				smallSpeedCounter = 0;
				
				if (smallSpeedCounter == 2)
				{
					pursuit = false;
					smallSpeedCounter = 0;
					ReverseMovement();
				}
			}
			else
			smallSpeedCounter = 0;

			if (pursuit)
			speed = pursuitSpeed;
			else 
			{
				speed = regularSpeed;
				dontMove = false;
			}
			
			if(!dontMove)
			_body.ApplyImpulse(new b2Vec2(horWayOfMovement * speed, 0), _body.GetWorldCenter());
			
			determineOrientation();
			super.childSpecificUpdating();
		}
		
		override public function preDestroyUpdating():void 
		{
			if (_body != null)
			Global.world.DestroyBody(_body);
			
			_costume.scaleX *= 0.8;
			_costume.scaleY *= 0.8;
			
			head.scaleX = _costume.scaleX;
			head.scaleY = _costume.scaleY;
			
			leftHand.scaleX = _costume.scaleX;
			leftHand.scaleY = _costume.scaleY;
			
			rightHand.x = _costume.x + 11.75 * orientation * _costume.scaleX;
			
			
			rightHand.scaleX = _costume.scaleX * 0.9;
			rightHand.scaleY = _costume.scaleY*0.9;
			
			if (Math.abs(_costume.scaleY) < 0.2)
			_destroy = true;
			
			super.preDestroyUpdating();
		}
		
		override public function destroy():void 
		{
			super.destroy();	
			head.parent.removeChild(head);
			leftHand.parent.removeChild(leftHand);
			rightHand.parent.removeChild(rightHand);
		}
		
		override public function updateRotation():void 
		{

		}
		
		override public function StopAnimation():void 
		{
			
			head.stop();
			leftHand.stop();
			rightHand.stop();
			super.StopAnimation();
		}
		
		override public function Reanimate():void 
		{
			leftHand.play();
			rightHand.play();
			
			if (leftHand.currentFrame == 28)
				leftHand.stop();
			
			if (rightHand.currentFrame == 28)
				rightHand.stop();
			
			super.Reanimate();
		}
		
		override protected function updateCostumePositionAndRotation():void 
		{
			super.updateCostumePositionAndRotation();
			
			head.x = _costume.x;
			head.y = _costume.y;
			leftHand.x = _costume.x;
			leftHand.y = _costume.y;
			rightHand.x = _costume.x + 11.75 * orientation;
			rightHand.y = _costume.y - 1.55;
		}
	}
}