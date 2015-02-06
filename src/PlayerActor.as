package  
{
	import Box2D.Collision.b2BoundValues;
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class PlayerActor extends WalkingActor
	{
		var snowBallCount:Number = 0;
		var dieToTheRight:Number = 1;
		var spikeImpalementCounter:int = 0;
		
		////////////////////////////
		public var horGroundImpuls = 1.2;
		public var horAirImpuls = 0.62;
		
		public var jumpCounter:Number = 0; 
		public var JUMP:Boolean = false;
		public var LEFT:Boolean = false;
		public var RIGHT:Boolean = false;
		public var FIRE:Boolean = false;
		
		public var fired:Boolean = false;
		public var orientation:Number = 1;
		
		public var canFireBullet:Boolean = true;
		public var active:Boolean = true;
		
		public var noLeftOrRightCounter:Number = 0;
		
		public var currAngle:Number;
		public var prevAngle:Number;
		public var rotatedCounter:Number = 0;
		
		public var maxDeactivateBlinkingCounter:Number = 9;
		public var deactivationBlinkingCounter:Number = 0;
		public var transparencyDeactivateDirection:Number = -1;
		public var transparencyDeactivateAmount:Number = 0.26;
		public var postBlinkingCollision:Boolean = false;
		
		public var throwingArm:MovieClip;
		
		public var preDestroyCounter:Number = 0;
		
		public var heartCollectedCounter:Number = 0;
		public var startGlowAngle:Number = -Math.PI/2;
		public var currentGlowAngle:Number;
		
		public var djoleNiz:Array = [ 4, 3.4, 3.2, 3.1, 3, 2.9, 2.8, 2.6, 2.5, 2.4, 2];
		
		public function PlayerActor(position:b2Vec2) 
		{
			super(new PlayerMC());
			
			_health = 3;
			_width = 20;
			_height = 38;
			
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
			_body.CreateFixture(fixtureDef);
			SetupGroundedSensor(1);
			
			_body.SetBullet(true);
			_body.SetUserData(this);
			_body.SetLinearDamping(2);
			currAngle = _body.GetAngle();
			
			throwingArm = new RIgracaAnimSvetla();
			Global.gameCanvas.addChild(_costume);
			Global.gameCanvas.addChild(throwingArm);
			Global.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress );
			Global.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease );
		}
		
		public function disableJumpAcceleration()
		{
			jumpCounter = 15;
		}
		
		public function BounceUpAnimation()
		{
			MovieClip(_costume).gotoAndPlay(19);
		}
		
		override public function UpdateHealthBy(updtAmount:Number)
		{
			if (updtAmount == -1)
				Global.GAME.LifeLostSound.play();
			
			super.UpdateHealthBy(updtAmount);
			
			if (_health == 1 || _health == 2)
			{
				active = false;
				Global.player = null;
			}
		}
		
		private function blinkingCollisionDetectionCallback(fixture:b2Fixture):Boolean
		{
			if (fixture.GetBody().GetUserData() is WalkingEnemy)
			{
				postBlinkingCollision = true;
				return 0;
			}
			
			return 1;
		}
		
		public function determineSideOfDeathBlow(contact:b2Contact)
		{
			var man:b2WorldManifold = new b2WorldManifold();
			contact.GetWorldManifold(man);
			
			if (man.m_points[0].x > _body.GetPosition().x)
				dieToTheRight = -1;
				else
				dieToTheRight = 1;
				
		}
		
		public function CollisionDetectionAfterBlinking():Boolean
		{	
			if (spikeImpalementCounter)
				return true;
			
			postBlinkingCollision = false;
			Global.world.QueryAABB(blinkingCollisionDetectionCallback, _body.GetFixtureList().GetNext().GetAABB());
			
			return postBlinkingCollision;
		}
		
		public function playerDeactivateUpdate()
		{	
			if(maxDeactivateBlinkingCounter>deactivationBlinkingCounter)
			{
				_costume.alpha += transparencyDeactivateDirection * transparencyDeactivateAmount;
				
				if (_costume.alpha < 0)
				{
					_costume.alpha = 0;
					transparencyDeactivateDirection = 1;
					deactivationBlinkingCounter++;
				}
				else if (_costume.alpha > 1)
				{
					_costume.alpha = 1;
					transparencyDeactivateDirection = -1;
					deactivationBlinkingCounter++;
				}
			}	
			else
			{
				_costume.alpha = 1;
				deactivationBlinkingCounter = 0;
				active = true;
				Global.player = this;
				
				if (CollisionDetectionAfterBlinking())
					UpdateHealthBy( -1);	
			}
		}
		
		private function BulletPathClear(fixture:b2Fixture):Boolean
		{
			if (fixture.GetBody().GetUserData() != null)
			{
				if (fixture.GetBody().GetUserData() is FloorActor || fixture.GetBody().GetUserData() is WalkingActor)
				{
					canFireBullet = false;
					return 0;
				}
			}
			
			return 1;
		}
		
		
		private function handleHeartPickupGlow()
		{
			
			if (heartCollectedCounter)
			{
			
				if (heartCollectedCounter == 1)
				{
					currentGlowAngle = startGlowAngle;
				}
				
				heartCollectedCounter++;
				currentGlowAngle += 0.2;
				
				var blurKoef:Number = 20*Math.abs(Math.cos(currentGlowAngle));
				
				var gf:GlowFilter = new GlowFilter(0xFFFFFF, 1, blurKoef, blurKoef);
				_costume.filters = [gf];
				
				if (currentGlowAngle > Math.PI * 1.5)
				{
					_costume.filters = [];
					heartCollectedCounter = 0;
				}
			}
		}
		
		override public function handleKeyEvents():void 
		{	
			if (!active)
				playerDeactivateUpdate();
			
			super.handleKeyEvents();

			if (FIRE && !fired)
			{
				var bulletStartingPos:b2Vec2 = _body.GetWorldCenter().Copy();
				bulletStartingPos.Multiply(Global.RATIO);
				
				bulletStartingPos.x += orientation * (_width / 2 + 9);
				bulletStartingPos.y -= _height * 0.4;
				
				var circleShape:b2CircleShape = new b2CircleShape(5 / Global.RATIO );
				canFireBullet = true;
				
				var pos:b2Vec2 = bulletStartingPos.Copy();
				Functions.DivideB2Vec2ByRatio(pos);
				
				var trans:b2Transform = new b2Transform(pos, new b2Mat22());
				Global.world.QueryShape(BulletPathClear, circleShape, trans);
				
				if (canFireBullet && snowBallCount)
				{
					Global.GAME.ThrowSound.play();
					
					snowBallCount--;
				
					fired = true;
					
					if(throwingArm.currentFrame!=35)
					throwingArm.gotoAndPlay(19);
					
					Global.allActors.push(new Bullet(this, bulletStartingPos, new b2Vec2(0.5 * orientation, -0.45)));
					
				}
			}
			
			if (JUMP)
			{
				if (  (!jumpCounter && _grounded) || (jumpCounter > 0 && jumpCounter < 8) )
				{
					var addedImpuls:Number = 0;
					
					if (!jumpCounter)
					{
						Global.GAME.JumpSound.play();
						//addedImpuls = Math.abs(10);
					}
					
					jumpCounter++;
					
					_body.ApplyImpulse( new b2Vec2(0, -(djoleNiz[jumpCounter] +1.35) ), _body.GetWorldCenter());
				}
			}
			else
			jumpCounter = 0;
			
			var currentHorImpuls;
			
			if (_grounded)
			currentHorImpuls = horGroundImpuls;
			else 
			currentHorImpuls = horAirImpuls;
			
			
			if (throwingArm.currentFrame == 18)
			{
				//if(throwingArm.)
				
				throwingArm.gotoAndStop(1);
			}
			
			if (_grounded)
			{
				if (throwingArm.currentFrame == 35)
				throwingArm.play();
				
				if (throwingArm.currentFrame == 29)
				throwingArm.gotoAndStop(1);
				
				if (MovieClip(_costume).currentFrame == 18)
				MovieClip(_costume).gotoAndPlay(1);
				
				if (10 > noLeftOrRightCounter)
				{
					if (Math.abs(_body.GetLinearVelocity().x) > 5)
					{
						MovieClip(_costume).nextFrame();
						
						if (MovieClip(_costume).currentFrame == 18)
						MovieClip(_costume).gotoAndPlay(1);
						
						MovieClip(_costume).play();

						throwingArm.nextFrame();
						
						if (throwingArm.currentFrame == 18)
							throwingArm.gotoAndStop(1);
						
						throwingArm.play();

					}
					else
					if (Math.abs(_body.GetLinearVelocity().x) < 0.1)
					{
						MovieClip(_costume).gotoAndStop(4);
					
				//	MovieClip(_costume).stop();
				
						if (throwingArm.currentFrame == 1)
							throwingArm.stop();
						
				//		if (Math.abs(_body.GetLinearVelocity().x) < 1)
				//		{
				//			MovieClip(_costume).gotoAndStop(5);
				//		}
					}
					else
					{
					//	MovieClip(_costume).nextFrame();
						MovieClip(_costume).play();
						throwingArm.play();
					}
				}
				else
				{
					
					//if(MovieClip(_costume).currentFrame!=27)
						MovieClip(_costume).gotoAndStop(4);
					
				//	MovieClip(_costume).stop();
				
						if (throwingArm.currentFrame == 1)
							throwingArm.stop();
				}
				
				
				
			}
			else
			{
	
				//throwingArm.stop();
				
				if (_body.GetLinearVelocity().y > 0 || Math.abs(_body.GetLinearVelocity().y ) < 8)
				{
					if(throwingArm.currentFrame < 19)
					throwingArm.gotoAndPlay(29);
					
					if (throwingArm.currentFrame > 19 && throwingArm.currentFrame < 34)
					throwingArm.gotoAndPlay(34);
					
					if (throwingArm.currentFrame == 35)
						throwingArm.stop();
				}
				
				if (_body.GetLinearVelocity().y > 0)
				{

					
					if (MovieClip(_costume).currentFrame == 27)
						MovieClip(_costume).stop();
					else
						MovieClip(_costume).play();
				}
				else 
				{
					if (MovieClip(_costume).currentFrame < 19)
				MovieClip(_costume).gotoAndPlay(19);
				
				if (MovieClip(_costume).currentFrame == 23)
					MovieClip(_costume).stop();
				}
				
			}
			
			
			if (LEFT)
			{
				noLeftOrRightCounter = 0;
				orientation = -1;
				_body.ApplyImpulse( new b2Vec2( -currentHorImpuls, 0), _body.GetWorldCenter());
			}
			else
			if (RIGHT)
			{
				noLeftOrRightCounter = 0;
				orientation = 1;
				_body.ApplyImpulse( new b2Vec2( currentHorImpuls, 0), _body.GetWorldCenter());
			}
			else
			noLeftOrRightCounter++;
				
			_costume.scaleX = orientation;

			
			handleHeartPickupGlow();
			
			
			
		}
		
		private function onKeyRelease(keyboardEvent:KeyboardEvent):void 
		{
			if ( keyboardEvent.keyCode == Keyboard.SPACE )
				JUMP = false;
			else if ( keyboardEvent.keyCode == Keyboard.LEFT )
				LEFT = false;
			else if ( keyboardEvent.keyCode == Keyboard.RIGHT )
				RIGHT = false;
			else if ( keyboardEvent.keyCode == 88 )
			{
				fired = false;
				FIRE = false;
			}
		}
		
		private function onKeyPress(keyboardEvent:KeyboardEvent):void 
		{
			if ( keyboardEvent.keyCode == Keyboard.SPACE )
				JUMP = true;
			else if ( keyboardEvent.keyCode == Keyboard.LEFT )
				LEFT = true;
			else if ( keyboardEvent.keyCode == Keyboard.RIGHT )
				RIGHT = true;
			else if ( keyboardEvent.keyCode == 88 )
				FIRE = true;
			
		}
		
		override protected function updateCostumePositionAndRotation():void 
		{
			super.updateCostumePositionAndRotation();
			
			throwingArm.alpha = _costume.alpha;
			throwingArm.x = _costume.x;
			throwingArm.y = _costume.y;
			throwingArm.scaleX = _costume.scaleX;
			throwingArm.scaleY = _costume.scaleY;
		}
		
		
		
		override public function preDestroyUpdating():void 
		{
			
			
			//_body.SetAngle(Math.PI / 2);
			
			Global.player = null;
			//preDestroyCounter++;
			
			
			if (!preDestroyCounter)
			{
				var prevLinearVelocity:b2Vec2 = _body.GetLinearVelocity().Copy();
				var prevAngularVellocity:Number = _body.GetAngularVelocity();
				
				var bodyDef:b2BodyDef = new b2BodyDef();	  
				bodyDef.position = _body.GetPosition().Copy();
				bodyDef.type = b2Body.b2_dynamicBody; 
				Global.world.DestroyBody(_body);
				
				_body = Global.world.CreateBody(bodyDef);
				
				var shape:b2PolygonShape = new b2PolygonShape();
				
				shape.SetAsBox(_width/2/Global.RATIO, (_height/2 - _width/2) /Global.RATIO);
				
/*
				var spikeHeight:Number = _height / 5;
				var bodyArr:Array = [ 
				new b2Vec2( 0 - 1, _height / 2) , 
				new b2Vec2( -_width / 3, _height / 2 - spikeHeight/3),
				new b2Vec2(  -_width / 2, _height / 2 - spikeHeight) ,
				new b2Vec2( -_width / 2, -spikeHeight), 
				new b2Vec2( -_width / 3, (-_height / 2) + spikeHeight/3),
				new b2Vec2( 0 , -_height / 2) , 
				new b2Vec2( _width / 3,  (-_height / 2) + spikeHeight/3),
				new b2Vec2(  _width / 2, - spikeHeight) , 
				new b2Vec2( _width / 2 , _height / 2 - spikeHeight ),
				new b2Vec2( _width / 3, _height / 2 - spikeHeight/3),
				];	
				
				Functions.DivideB2Vec2ArrayByRatio(bodyArr);		
				shape.SetAsArray(bodyArr, 10);*/
				
				var fixtureDef:b2FixtureDef = new b2FixtureDef();
				fixtureDef.shape = shape;
				fixtureDef.restitution = 0;
				fixtureDef.friction = 0.0001;
				fixtureDef.density = 2;
				_body.CreateFixture(fixtureDef);

				
				var circleShape:b2CircleShape = new b2CircleShape(_width/2 / Global.RATIO );
				var wheelFixtureDef:b2FixtureDef = new b2FixtureDef();
				wheelFixtureDef.shape = circleShape;
				wheelFixtureDef.restitution = 0;
				wheelFixtureDef.friction = 0.00001;
				wheelFixtureDef.density = 2;
				circleShape.SetLocalPosition(new b2Vec2(0, (_height / 2 - _width / 2) / Global.RATIO));
				_body.CreateFixture(wheelFixtureDef);
				
				
				var circleShape2:b2CircleShape = new b2CircleShape(_width/2 / Global.RATIO );
				var wheelFixtureDef2:b2FixtureDef = new b2FixtureDef();
				wheelFixtureDef2.shape = circleShape2;
				wheelFixtureDef2.restitution = 0;
				wheelFixtureDef2.friction = 0.00001;
				wheelFixtureDef2.density = 2;
				circleShape2.SetLocalPosition(new b2Vec2(0, -(_height / 2 - _width / 2) / Global.RATIO));
				_body.CreateFixture(wheelFixtureDef2);
				
				_body.SetBullet(true);
				_body.SetUserData(this);
				_body.SetLinearDamping(2);
				_body.SetLinearVelocity(prevLinearVelocity);
				_body.SetAngularVelocity(prevAngularVellocity);
				_body.ApplyTorque(1.2*dieToTheRight);
				_body.ResetMassData();
				
				MovieClip(_costume).gotoAndStop(5);
				throwingArm.stop();
			}
			
			preDestroyCounter++;
			
			updateCostumePositionAndRotation();
			
			throwingArm.rotation = _costume.rotation;
			
			prevAngle = currAngle;
			currAngle = _body.GetAngle();
			
			if (!Functions.ProcessedAngleDifferenceSmallerThan(Functions.halfPI * 0.7, 0, Functions.getProcessedAngle(_body.GetAngle())))
			{
				if (Math.abs(prevAngle-currAngle) < 0.07)
				rotatedCounter++;
			}
			else
				rotatedCounter = 0;
			
			if (rotatedCounter > 20)
				_destroy = true;
		}
		
		override public function healthDecreasedToZerohHandler()
		{
			super.healthDecreasedToZerohHandler();
			_body.SetFixedRotation(false);
			_body.GetFixtureList().SetDensity(2);
			_body.GetFixtureList().GetNext().SetDensity(2);
		}
		
		override public function StopAnimation():void 
		{
			super.StopAnimation();
			throwingArm.stop();
		}
		
		override public function Reanimate():void 
		{
			super.Reanimate();
		}
		
		override public function destroy():void 
		{
			super.destroy();
			throwingArm.parent.removeChild(throwingArm);
		}
	}
}