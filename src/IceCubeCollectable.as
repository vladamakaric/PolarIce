package  
{
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class IceCubeCollectable extends Actor
	{
		var speed:Number = 0.2;
		var vertMovDir:Number = 1;
		var offset:Number = 1 / Global.RATIO;
		var startY:Number;
		var flyingSpeed:Number = 15;
		var startDistanceToGoal:Number = 0;
		
		public function IceCubeCollectable(position:b2Vec2) 
		{
			//super(new SnowBall2());
			super(new IceCube3D());
			startY = position.y / Global.RATIO + offset * Math.random();
			
			if (Math.random() > 0.5)
			vertMovDir = -1;
			
			position.y += Math.random() * 5 - 2.5;
			
			_body = Functions.CircleGenerator(position, _costume.width / 2, 7, 0, 0);
			_body.GetFixtureList().SetSensor(true);
			_body.SetUserData(this);
			Global.gameCanvas.addChild(_costume);
			_body.ApplyForce(new b2Vec2(0, -35 * _body.GetMass()), _body.GetPosition());
				//				_body.ApplyForce(new b2Vec2(0, 0.2), _body.GetPosition());
					//_body.ApplyImpulse(new b2Vec2(0, speed/2), _body.GetPosition());
					
			updateCostumePositionAndRotation();
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
			var bigSnowBallPos:b2Vec2 = new b2Vec2(Global.currentLevel._HUD.iceCubeCounter.x, Global.currentLevel._HUD.iceCubeCounter.y);
			
			
			var velocity:b2Vec2 = Functions.GetVectorFromAToB(costumePos, bigSnowBallPos);
			var lenght:Number = velocity.Length();
			
			if(!startDistanceToGoal)
			{
				startDistanceToGoal = lenght;
			}

			
			_costume.scaleX = _costume.scaleY = lenght/startDistanceToGoal*0.5 + 0.5;
			
			
			if (lenght < flyingSpeed + Global.currentLevel._HUD.snowBallCounter.width/2)
			{
				Global.GAME.IceCollectSound.play();
				_destroy = true;
				Global.currentLevel._iceCubesCollected++;
				Global.currentLevel._HUD.glowSBCounter2 = 1;
				
				
				
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