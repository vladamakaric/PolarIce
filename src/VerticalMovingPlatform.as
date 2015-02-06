package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class VerticalMovingPlatform extends FloorActor
	{
		var maxSpeed:Number = 5;
		var speed:Number;
		var height:Number;
		var width:Number;
		var up:Number;
		var down:Number;
		var xPos:Number;
		
		var verMovDirection:Number=1;
		var pathHeight:Number;
		var fTime:Boolean = true;
		var speedTrail:Sprite;
	//	var maxSpeed:Number = 5;
		
	var trailVisible:Boolean;
		
		var trailMaxLenght:Number = 15;
		public function VerticalMovingPlatform(d:Number, u:Number, x:Number, s:Number, sprite:Sprite, customY:Number = 0) 
		{
			super(sprite);
			
			if (Math.random() > 0.5)
			verMovDirection = -1;
			
			trailVisible = !Boolean(1 + verMovDirection);
			
			speed = 12.4;
			width = sprite.width;
			height = sprite.height;
			up = u;
			down = d;
			xPos = x;
			pathHeight = down - up;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			Math.random();
			
			if(!customY)
			bodyDef.position.Set( xPos / Global.RATIO, (up + height / 2 + (pathHeight - height) * Math.random()) / Global.RATIO);
			else
			bodyDef.position.Set( xPos / Global.RATIO, customY / Global.RATIO);
			
			bodyDef.type = b2Body.b2_dynamicBody;
			  
			_body = Global.world.CreateBody(bodyDef);
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(width / 2   / Global.RATIO, height / 2  / Global.RATIO);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			
			fixtureDef.density = 2.9;
			fixtureDef.restitution = 0;
			fixtureDef.friction = 0.1;
			_body.CreateFixture(fixtureDef);
			
			_body.SetFixedRotation(true);
			_body.ResetMassData();
			_body.SetUserData(this);
			_body.SetBullet(true);
			_body.SetLinearDamping(3);
			

			
			speedTrail = new Sprite();
			var rectangle:Shape = new Shape();
			rectangle.graphics.beginFill(0x00FAFF); 
			rectangle.alpha = 1;
			rectangle.graphics.drawRect(-_costume.width/2*0.83, -_costume.height/2, _costume.width*0.83 , trailMaxLenght); // (x spacing, y spacing, width, height)
			rectangle.graphics.endFill();
			speedTrail.addChild(rectangle);
			var myBlur:BlurFilter = new BlurFilter();
			myBlur.quality = 2;
			myBlur.blurY = 12;
			speedTrail.filters = [myBlur];
			
			updateCostumePositionAndRotation();
			updateSpeedTrail();
			
			Global.gameCanvas.addChild(speedTrail);
			Global.gameCanvas.addChild(_costume);
			
			
		}

		public function updateSpeedTrail()
		{
			speedTrail.height = trailMaxLenght/2 + trailMaxLenght/2;	
			speedTrail.y = _body.GetPosition().y * Global.RATIO + height/2 + speedTrail.height/2;
			speedTrail.x = _body.GetPosition().x * Global.RATIO;	
			speedTrail.alpha = 1 -  Math.random()*0.6;
		}
		
		override public function childSpecificUpdating():void 
		{
			if (trailVisible && _body.GetLinearVelocity().y > 0)
			{
				trailVisible = false;
				speedTrail.visible = false;
			}
			else if (!trailVisible && _body.GetLinearVelocity().y < 0)
			{
				trailVisible = true;
				speedTrail.visible = true;
			}

			if (verMovDirection==1)
			{
				if (_body.GetPosition().y * Global.RATIO + height / 2 > down)
				{
					verMovDirection = -1;
				}
			}
			else
			{
				if (_body.GetPosition().y * Global.RATIO - height / 2 < up)
				{
				verMovDirection = 1;	

				}
			}

		if (verMovDirection == -1)
			_body.ApplyImpulse(new b2Vec2(0, -speed), _body.GetWorldCenter());	
			
		if (verMovDirection == 1)
			_body.ApplyImpulse(new b2Vec2(0, -speed/3.2), _body.GetWorldCenter());	
			

		if (_body.GetPosition().x * Global.RATIO > xPos)
		_body.ApplyImpulse(new b2Vec2( -(_body.GetPosition().x * Global.RATIO - xPos), 0), _body.GetWorldCenter());	
		else
		_body.ApplyImpulse(new b2Vec2( (xPos - _body.GetPosition().x * Global.RATIO), 0), _body.GetWorldCenter());	

		
		updateSpeedTrail();
			super.childSpecificUpdating();
			
			
		}
		
		override public function GetPixelYCoord():Number 
		{
			return super.GetPixelYCoord() - height/2;
		}
		
	}

}