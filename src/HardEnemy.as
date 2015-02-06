package  
{
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Transform;
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
	public class HardEnemy extends WalkingEnemy
	{
		//var newSprite:Sprite = null;
		
		var horWayOfMovement:Number = -1;
		var speed:Number = 0.3*4;		
		var regularSpeed:Number = 0.3*4;
		var pursuitSpeed:Number = 1.2*4;
		var jumpHorizontalSpeed:Number = 0.34*4;
		var dontMove:Boolean = false;
		
		var pursuit:Boolean = false;
		
		var playerVisible:Boolean = false;
		
		
		var canFireBullet:Boolean = true;
		var orientation:Number = 1;
		var consistentHorWayOfMovCounter:Number = 0;
		
		var upperWidth:Number;
		
		var smallSpeedCounter:Number = 0;
		
		var playerNotDetectedCounter:Number = 0;
		
		var playerIntersection:Boolean = false;
		
		var timeAfterLastBulletFired:Number = 51;
		
		var jumpCounter:Number = 0;
		
		public function HardEnemy(position:b2Vec2) 
		{
			super(new EskimoMC());
			//MovieClip(_costume).stop();
			_health = 2;
			
			_width = 24;
			_height = 42;
			
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
			fixtureDef.restitution = 0;
			fixtureDef.friction = 0.2;
			fixtureDef.density = 4;
			
			_body.CreateFixture(fixtureDef);
			
			SetupGroundedSensor(1);
			
			_body.SetBullet(true);
			_body.SetUserData(this);
			_body.SetFixedRotation(true);
			_body.SetLinearDamping(3);
			
			Global.gameCanvas.addChild(_costume);
			updateCostumePositionAndRotation();
		}
		
		public function ReverseMovement()
		{
			if (_grounded)
			{
				horWayOfMovement *= -1;
				consistentHorWayOfMovCounter = 0;
			}
		}
		
		private function determineOrientation():void
		{
			if (consistentHorWayOfMovCounter > 2)
			{
				if (horWayOfMovement * _body.GetLinearVelocity().x >= 0)
				{
					orientation = horWayOfMovement;
					_costume.scaleX = horWayOfMovement;
				}
			}
			
			
			MovieClip(_costume).nextFrame();
			MovieClip(_costume).play();	
			
			if (!_grounded)
			MovieClip(_costume).stop();
			
			if (dontMove)
			MovieClip(_costume).gotoAndStop(16);
			
		/*	if (pursuit)
			MovieClip(_costume).gotoAndStop(2);
			else
			MovieClip(_costume).gotoAndStop(1);*/
		}
		
		private function TryJump():void
		{		
			if (_grounded)
				jumpCounter = 0;

			var groundClearance = 90;

			if (_body.GetLinearVelocity().x * horWayOfMovement < 0)
				groundClearance = 60;
			
			if (!jumpCounter)
			{
				if(_grounded)
				if (CheckForGroundSurface(groundClearance, horWayOfMovement))
				{
					_body.ApplyImpulse( new b2Vec2(0, - 7*2 ), _body.GetWorldCenter());
					jumpCounter++;
					
					_grounded = false;
				}
			}
		}
		
		private function CheckForPlayer()
		{
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
			
/*
			if (newSprite != null)
			{
				newSprite.parent.removeChild(newSprite);
				newSprite = null;
			}
			
			newSprite = new Sprite();
			
			newSprite.graphics.lineStyle(2, 0x00D900);
			newSprite.graphics.moveTo(backBox.lowerBound.x*Global.RATIO, backBox.lowerBound.y*Global.RATIO);
			newSprite.graphics.lineTo(backBox.upperBound.x * Global.RATIO, backBox.upperBound.y * Global.RATIO);

			newSprite.graphics.moveTo(frontBox.lowerBound.x*Global.RATIO, frontBox.lowerBound.y*Global.RATIO);
			newSprite.graphics.lineTo(frontBox.upperBound.x * Global.RATIO, frontBox.upperBound.y * Global.RATIO);*/
			////////////////////////////////////////////////////////////////////////////////////////////////////////

			var playerAABB:b2AABB = Global.player._body.GetFixtureList().GetNext().GetAABB();

			if (frontBox.TestOverlap(playerAABB))
			{
				//dontMove = false;
				//ReverseMovement();
				
				playerNotDetectedCounter = 0;
				pursuit = true;
			}
			else if (backBox.TestOverlap(playerAABB) && Global.player._grounded)
			{
				dontMove = false;
				ReverseMovement();
				
				pursuit = true;
				playerNotDetectedCounter = 0;
			}
			else
			playerNotDetectedCounter++;
			
			if (playerNotDetectedCounter > 30)
				pursuit = false;
			
			//Global.gameCanvas.addChild(newSprite);
		}
		
		
		private function BulletPathClear(fixture:b2Fixture):Boolean
		{
			canFireBullet = false;
			return 0;
		}
		
		
		private function fireBullet():void
		{
			if (timeAfterLastBulletFired > 50 && horWayOfMovement == orientation && _health == 2)
			{
				var bulletStartingPos:b2Vec2 = _body.GetWorldCenter().Copy();
				bulletStartingPos.Multiply(Global.RATIO);
				
				bulletStartingPos.x += orientation * (_width / 2 + 9);
				bulletStartingPos.y -= _height * 0.4;
				/////////////////////////////////////////////////////////////////////
				var circleShape:b2CircleShape = new b2CircleShape(5 / Global.RATIO );
				var pos:b2Vec2 = bulletStartingPos.Copy();
				Functions.DivideB2Vec2ByRatio(pos);
				var trans:b2Transform = new b2Transform(pos, new b2Mat22());
				canFireBullet = true;
				Global.world.QueryShape(BulletPathClear, circleShape, trans);
				
				if (canFireBullet)
				{
					Global.GAME.SnowBallFireSound.play();
					timeAfterLastBulletFired = 0;
					Global.allActors.push(new Bullet(this, bulletStartingPos, new b2Vec2(0.5 * orientation, -0.45)));
				}
			}
		}
		
		private function Callback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number ):Number
		{
			if (fixture.GetBody().GetUserData() is WalkingEnemy || fixture.GetBody().GetUserData() is PlayerActor)
			{
				return 1;
			}
			
			rayCast = false;
			return 0;
		}
		
		private function PlayerVisible(A:b2Vec2 , B:b2Vec2):Boolean 
		{
			rayCast = true;
			Global.world.RayCast(Callback, A, B);
			return rayCast;
		}
		
		private function SimulateMemory():void
		{
			if (!_grounded)
				return;
			
			if (!PlayerVisible(_body.GetPosition(), Global.player._body.GetPosition()))
				return;
				
			playerVisible = true;
				
			
			if (_body.GetPosition().x > Global.player._body.GetPosition().x)
			{
				if (horWayOfMovement > 0)
					dontMove = false;
				
				horWayOfMovement = -1;
			}
			else
			{
					
				if (horWayOfMovement < 0)
					dontMove = false;
				
				horWayOfMovement = 1;
			}
		}
		
		
		override public function UpdateHealthBy(updtAmount:Number) 
		{
			super.UpdateHealthBy(updtAmount);
			
			if (_health == 1)
			{
				_costume.parent.removeChild(_costume);
				_costume = new EskimoMCNoBazuka();
				Global.gameCanvas.addChild(_costume);
				
				var pixPos:b2Vec2 = _body.GetPosition().Copy();
				Functions.MultiplyB2Vec2ByRatio(pixPos);
				Global.currentLevel.addEskimoBazookaExplosion(pixPos);
			}
		}
		
		private function HandlePursuit()
		{
			if (!pursuit)
			return;
			
			
			SimulateMemory();
			
			
			if (!playerVisible)
				return;
			
			var xDiff:Number = Math.abs(Global.player._body.GetPosition().x - _body.GetPosition().x);
			
			if (xDiff < 90 / Global.RATIO)
			{
				TryJump();
			}
			else
			{
				fireBullet();
			}	
		}
		
		override public function childSpecificUpdating():void 
		{
			playerVisible = false;
			timeAfterLastBulletFired++;
			consistentHorWayOfMovCounter++;

			if (jumpCounter && jumpCounter < 7)
			{
				jumpCounter++;
				_body.ApplyImpulse( new b2Vec2(0, -(7 - jumpCounter)*2 ), _body.GetWorldCenter());	
			}
			
			
			if (Global.player != null)
			{
				CheckForPlayer();
				HandlePursuit();
			}
			else 
			pursuit = false;
			
			var groundClearance:Number = 15;
			
			if (pursuit)
			groundClearance = 4;
			
			
			if(_grounded)
			if (!CheckForGroundSurface(groundClearance, horWayOfMovement))
			{
				if (pursuit)
				dontMove = true;
				else
				{
					dontMove = false;
					ReverseMovement();
				}
			}
			
			if (!pursuit)
			{
				if (Math.abs(_body.GetLinearVelocity().x) < 0.09 && _grounded )
					smallSpeedCounter++
				else
				smallSpeedCounter = 0;

				if (smallSpeedCounter == 2)
				{
					smallSpeedCounter = 0;
					ReverseMovement();
				}
			}
			else
			smallSpeedCounter = 0;

			if (_grounded)
				speed = regularSpeed;
				else
				speed = jumpHorizontalSpeed;
		
			if (!pursuit)
				dontMove = false;
			
			if(!dontMove)
			_body.ApplyImpulse(new b2Vec2(horWayOfMovement * speed, 0), _body.GetWorldCenter());
			
			//if(Math.random() > 0.67)
			//TryJump();
			
			determineOrientation();
			super.childSpecificUpdating();
		}
		
		override public function StopAnimation():void 
		{
			/*
			for (var i:int = 0; i < MovieClip(_costume).numChildren; i++ )
			{
				var child = MovieClip(_costume).getChildAt(i);
				
				if (child is MovieClip)
				{
					
					
				MovieClip(child).stop();
				}
			}*/
			
			MovieClip(_costume).stop();
			super.StopAnimation();
		}
		
		override public function Reanimate():void 
		{
			for (var i:int = 0; i < MovieClip(_costume).numChildren; i++ )
			{
				var child = MovieClip(_costume).getChildAt(i);
				
				if (child is MovieClip)
				MovieClip(child).play();
			}
			
			super.Reanimate();
		}
		
		override public function preDestroyUpdating():void 
		{
			if (_body != null)
			Global.world.DestroyBody(_body);
			
			_costume.scaleX *= 0.8;
			_costume.scaleY *= 0.8;
			
			if (Math.abs(_costume.scaleY) < 0.2)
			_destroy = true;
			
			super.preDestroyUpdating();
		}
		
		
	}

}