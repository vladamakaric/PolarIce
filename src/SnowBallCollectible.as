package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class SnowBallCollectible extends Actor
	{
		var speed:Number = 0.2;
		var vertMovDir:Number = 1;
		var offset:Number = 1 / Global.RATIO;
		var startY:Number;
		var flyingSpeed:Number = 35;
		var startDistanceToGoal:Number = 0;
		
		public function SnowBallCollectible(position:b2Vec2) 
		{
			super(new SnowBall2());
			//super(new IceCube());
			startY = position.y / Global.RATIO + offset*Math.random();
			
			_body = Functions.CircleGenerator(position, _costume.width / 2, 7, 0, 0);
			//_body.SetType(b2Body.b2_staticBody);
			_body.GetFixtureList().SetSensor(true);
			_body.SetUserData(this);
			
			Global.gameCanvas.addChild(_costume);
			
			_body.ApplyForce(new b2Vec2(0, -35 * _body.GetMass()), _body.GetPosition());
				//				_body.ApplyForce(new b2Vec2(0, 0.2), _body.GetPosition());
					//_body.ApplyImpulse(new b2Vec2(0, speed/2), _body.GetPosition());
		}
		
		override public function childSpecificUpdating():void 
		{
			if ((_body.GetPosition().y > startY + offset) && vertMovDir>0)
			{
				vertMovDir = -1;
				_body.ApplyImpulse(new b2Vec2(0, -speed), _body.GetPosition());
			//	_body.ApplyForce(new b2Vec2(0, -1), _body.GetPosition());
				
			}
				else
				if ( (_body.GetPosition().y < startY - offset) && vertMovDir < 0)
				{
					vertMovDir = 1;
					_body.ApplyImpulse(new b2Vec2(0, speed), _body.GetPosition());
					//_body.ApplyForce(new b2Vec2(0, 1), _body.GetPosition());
				}
			
				_body.ApplyImpulse(new b2Vec2(0, vertMovDir*speed), _body.GetPosition());
				
			super.childSpecificUpdating();	
		}
		
		override public function preDestroyUpdating():void 
		{
			if (_body != null)
				Global.world.DestroyBody(_body);

			var costumePos:b2Vec2 = new b2Vec2(_costume.x, _costume.y);
			var bigSnowBallPos:b2Vec2 = new b2Vec2(Global.currentLevel._HUD.snowBallCounter.x, Global.currentLevel._HUD.snowBallCounter.y);

			var velocity:b2Vec2 = Functions.GetVectorFromAToB(costumePos, bigSnowBallPos);
			var lenght:Number = velocity.Length();
			
			if(!startDistanceToGoal)
			{
				startDistanceToGoal = lenght;
			}

			_costume.scaleX = _costume.scaleY = lenght/startDistanceToGoal*0.5 + 0.5;

			if (lenght < flyingSpeed + Global.currentLevel._HUD.snowBallCounter.width/2)
			{
				Global.GAME.SnowBallCollectSound.play();
				_destroy = true;
				Global.currentLevel._player.snowBallCount++;
				Global.currentLevel._HUD.glowSBCounter = 1;
				
				
				
				return;
			}

			velocity.Normalize();
			velocity.Multiply(flyingSpeed);

			_costume.x += velocity.x;
			_costume.y += velocity.y;
			
			super.preDestroyUpdating();
		}
		
	}

}