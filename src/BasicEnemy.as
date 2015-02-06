package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class BasicEnemy extends WalkingEnemy
	{
		
		var prevY:Number = 0;
		var screamCounter:int = 0;
		var screamed:Boolean = false;
		
		
		var horWayOfMovement:Number = -1;
		var speed:Number = 0.1;		
		var orientation:Number = 1;
		var consistentHorWayOfMovCounter:Number = 0;
		
		var upperWidth:Number;

		var currAngle:Number;
		var prevAngle:Number;
		var rotatedCounter:Number = 0;
		var spinningCounter:Number = 0;
		
		
		var pushedByPlayer:Boolean = false;
		var bounced:Boolean = false;
		
		public function BasicEnemy(position:b2Vec2) 
		{
			super(new PenguinMCOrigSize());
			
			_health = 1;
			_width = 20;
			_height = 36;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			position.x /= Global.RATIO;
			position.y /= Global.RATIO;
			bodyDef.position = position;
			bodyDef.type = b2Body.b2_dynamicBody;
			  
			_body = Global.world.CreateBody(bodyDef);
			var shape:b2PolygonShape = new b2PolygonShape();
			
			upperWidth = _width * 0.5;
			
			var bodyArr:Array = [ new b2Vec2( -upperWidth / 2 / Global.RATIO, -_height / 2 / Global.RATIO), new b2Vec2(upperWidth / 2 / Global.RATIO, -_height / 2 / Global.RATIO),
			new b2Vec2(_width / 2 / Global.RATIO, _height / 2 / Global.RATIO), new b2Vec2( -_width / 2 / Global.RATIO, _height / 2 / Global.RATIO)];			

			shape.SetAsArray(bodyArr, 4);

			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			fixtureDef.density = 0.5;
			fixtureDef.friction = 0.3;
			_body.CreateFixture(fixtureDef);
			SetupGroundedSensor(3);

			_body.ResetMassData();
			_body.SetUserData(this);
			_body.SetBullet(true);
			_body.SetLinearDamping(3);
			
			prevAngle = _body.GetAngle();

			Global.gameCanvas.addChild(_costume);
			updateCostumePositionAndRotation();
		}
		
		public function ReverseMovement()
		{
			if (!bounced && _grounded && !pushedByPlayer)
			{
				horWayOfMovement *= -1;
				consistentHorWayOfMovCounter = 0;
			}
		}
		
		private function determineOrientation():void
		{
			if(_grounded && !pushedByPlayer)
			if (consistentHorWayOfMovCounter > 2)
			{
				if (horWayOfMovement * _body.GetLinearVelocity().x >= 0)
				{
					orientation = horWayOfMovement;
					_costume.scaleX = horWayOfMovement;
				}
			}
		}
		
		private function CheckForDeath():void
		{
			prevAngle = currAngle;
			currAngle = _body.GetAngle();
			
			if (!_grounded && !Functions.ProcessedAngleDifferenceSmallerThan(Functions.halfPI * 0.7, 0, Functions.getProcessedAngle(_body.GetAngle())))
			{
				spinningCounter++;
				
				if (Math.abs(prevAngle-currAngle) < 0.01)
				rotatedCounter++;
			}
			else
			{
				spinningCounter = 0;
				rotatedCounter = 0;
			}
			
			if (rotatedCounter > 7)
				_preDestroy = true;
		}
		
		override public function GroundSurfaceCallback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number):Number 
		{
			rayCast = true;
			return 0;
		}

		
		override public function childSpecificUpdating():void 
		{
			consistentHorWayOfMovCounter++;

			if (_grounded && !pushedByPlayer)
			{
				if (!CheckForGroundSurface(6, horWayOfMovement))
				{
					ReverseMovement();
					bounced = true;
				}
			}
			
			if (bounced)
			{
				if (horWayOfMovement>0)
				{
					if (_body.GetLinearVelocity().x > 0.1)
					bounced = false;
				}
				else
				if (_body.GetLinearVelocity().x < -0.1)
				bounced = false;
			}
			
			if (_contactNum)
			{
				if(Math.random()>=0.5)
				ReverseMovement();
			}
			
			if(!bounced)
			if (Math.abs(_body.GetLinearVelocity().x) < 0.05 && _grounded )
				ReverseMovement();
				
			if(_grounded)
			_body.ApplyImpulse(new b2Vec2(horWayOfMovement * speed, 0), _body.GetWorldCenter());
			
			determineOrientation();
			CheckForDeath();
			
			if (prevY * Global.RATIO + 1 > _body.GetPosition().y * Global.RATIO)
				screamCounter = 0;
				
			if (_grounded)
				screamed = false;
			
			if (!screamed && !_grounded && !pushedByPlayer && _visible)
			{
				screamCounter++;
				if (screamCounter > 4)
				{
					Global.GAME.ScreamSound.play();
					screamed = true;
					screamCounter = 0;
				}
			}
			
			prevY = _body.GetPosition().y;
			super.childSpecificUpdating();
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
		
		override public function GetPixelYCoord():Number 
		{
			return super.GetPixelYCoord() + _height/2;
		}
		
	}
}
			