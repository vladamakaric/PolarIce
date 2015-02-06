package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class PushingEnemy extends FloorActor
	{
		var trailMaxLenght:Number = 20;
		var maxSpeed:Number = 5;
		var speedTrail:Sprite = null;
		var _width:Number;
		var _height:Number;
		var moving = true;
		var horWayOfMovement:Number = 1;
		var rayCast:Boolean = false;
		var speed:Number = 24;
		var standingWalkingActorsCount:Number = 0;
		
		
		public function PushingEnemy(position:b2Vec2, width:Number, height:Number, mxSpeed:Number, movSpeed:Number ) 
		{
			super(new SlidingIce1());
			
			maxSpeed = mxSpeed;
			speed = movSpeed;
			_width = width;
			_height = height;
			
			_costume.width = _width;
			_costume.height = _height;
	
			
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
			fixtureDef.density = 13500/(_width*_height);
			
			_body.CreateFixture(fixtureDef);
			
			_body.SetBullet(true);
			_body.SetUserData(this);
			_body.SetFixedRotation(true);
			_body.SetLinearDamping(3);

			updateCostumePositionAndRotation();
			
			var myGlow:GlowFilter = new GlowFilter();
			myGlow.alpha = 0.5;
			myGlow.color = 0x00FFFF;
			//myGlow.blurX = 40* (Math.abs(_body.GetLinearVelocity().x)/10) + 13; 
			
			myGlow.blurX = 16; 
			myGlow.blurY = 16; 
			
			//myGlow.strength = 
			_costume.filters = [myGlow];
			speedTrail = new Sprite();
			
			
			
			var rectangle:Shape = new Shape(); // initializing the variable named rectangle
			rectangle.graphics.beginFill(0x00FFFF); // choosing the colour for the fill, here it is red
			rectangle.alpha = 0.5;
			rectangle.graphics.drawRect(-trailMaxLenght/2, -_costume.height/2, trailMaxLenght ,_costume.height); // (x spacing, y spacing, width, height)
			rectangle.graphics.endFill();
			speedTrail.addChild(rectangle);
			
			var myBlur:BlurFilter = new BlurFilter();
			myBlur.quality = 2;
		//	myBlur.blurX = 50* ((Math.abs(_body.GetLinearVelocity().x)+1)/10); ;
			myBlur.blurX = 30;
			//myBlur.blurY = 10;
			speedTrail.filters = [myBlur];
			
			Global.gameCanvas.addChild(speedTrail);
			Global.gameCanvas.addChild(_costume);
			DrawSpeedTrail();
		}
		
		public function DrawSpeedTrail()
		{
			speedTrail.y = _body.GetPosition().y * Global.RATIO;
			speedTrail.x = _body.GetPosition().x * Global.RATIO - ((_width / 2) * horWayOfMovement);
			speedTrail.width = 35 * (Math.abs(_body.GetLinearVelocity().x) / maxSpeed);	
			speedTrail.alpha = (Math.abs(_body.GetLinearVelocity().x) / maxSpeed);
		}
		
		override public function childSpecificUpdating():void 
		{
			if (standingWalkingActorsCount == 0)
			{
				_body.SetLinearDamping(3);
				moving = true;
			}
				else
				{
					_body.SetLinearDamping(30);
				moving = false;
				}
				
				
				
			//var groundClearance:Number = 1000 / (_width*2);	
			
			
			if(moving)
			if (!CheckForGroundSurface(14, horWayOfMovement))
				horWayOfMovement *= -1;
			
			//_costume.scaleX = horWayOfMovement;

			if (Math.abs(_body.GetLinearVelocity().x) < maxSpeed || horWayOfMovement * _body.GetLinearVelocity().x < 0)
			_body.ApplyImpulse(new b2Vec2(horWayOfMovement * speed, 0), _body.GetWorldCenter());

			DrawSpeedTrail();
			
			super.childSpecificUpdating();
		}
		
		private function IsLineBlocked(A:b2Vec2 , B:b2Vec2):Boolean 
		{
			rayCast = false;
			Global.world.RayCast(Callback, A, B);
			return rayCast;
		}
		
		private function Callback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number ):Number
		{
			if (fixture.GetBody().GetUserData() != null)
			{
				if (fixture.GetBody().GetUserData() is FloorActor)
				{
					rayCast = true;
					return 0;
				}
				else
				{
					return 1;
				}
			}
			
			
			
			return 0;
			
		}
		
		protected function CheckForGroundSurface(horOffset:Number, sideToOffset:Number  /*From which side to offset (-1, 1) */ ):Boolean
		{
			var A:b2Vec2 = _body.GetWorldCenter().Copy();
			
			A.y += _height * 0.4 / Global.RATIO;
			A.x += (_width / 2 + horOffset) / Global.RATIO * sideToOffset;
			
			var B:b2Vec2 = new b2Vec2(A.x,A.y);
			B.y += (_height * 0.2) / Global.RATIO;
			
			/*
			if (newSprite != null)
			{
				newSprite.parent.removeChild(newSprite);
				newSprite = null;
			}
			
			newSprite = new Sprite();
			
			newSprite.graphics.lineStyle(2, 0x00D900);
			newSprite.graphics.moveTo(A.x*Global.RATIO, A.y*Global.RATIO);
			newSprite.graphics.lineTo(B.x * Global.RATIO, B.y * Global.RATIO);
			Global.gameCanvas.addChild(newSprite);
			*/
			return IsLineBlocked(A, B);
		}
		
		override public function GetPixelYCoord():Number 
		{
			return super.GetPixelYCoord() - _height/2;
		}
	}

}