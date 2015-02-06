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
	public class HorizontalMovingPlatform extends FloorActor
	{
		
		var height:Number;
		var width:Number;
		var left:Number;
		var right:Number;
		var yPos:Number;
		var maxSpeed:Number = 1.3;
		var horMovDirection:Number=1;
		var pathLenght:Number;
		
		var speedTrail:Sprite;
		var speedTrail2:Sprite;
		
		var trailMaxLenght:Number = 15;
		//var trailMaxLenght2:Number = 13;
		public function HorizontalMovingPlatform(l:Number, r:Number, y:Number, speed:Number, sprite:Sprite, customPosX:Number = 0) //napraviti custom start ako je neki 
		{
			super(sprite);
			
			if (Math.random() > 0.5)
			horMovDirection = -1;
			
			width = sprite.width;
			height = sprite.height;
			left = l;
			right = r;
			yPos = y;
			pathLenght = right - left;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			
			if(customPosX == 0)
			bodyDef.position.Set((left + width / 2 + (pathLenght - width) * Math.random()) / Global.RATIO, yPos / Global.RATIO);
			else
			bodyDef.position.Set(customPosX/ Global.RATIO, yPos / Global.RATIO);
			
			bodyDef.type = b2Body.b2_dynamicBody;
			  
			_body = Global.world.CreateBody(bodyDef);
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(width/2   / Global.RATIO, height/2  / Global.RATIO);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			fixtureDef.restitution = 0;
			fixtureDef.friction = 0.1;
			_body.CreateFixture(fixtureDef);

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
			if (horMovDirection==1)
			{
				if (_body.GetPosition().x * Global.RATIO + width / 2 > right)
				horMovDirection = -1;
			}
			else
			{
				if (_body.GetPosition().x * Global.RATIO - width / 2 < left)
				horMovDirection = 1;	
			}
			
			var lenghtToCenter:Number = Math.abs(_body.GetPosition().x *Global.RATIO - (left + right)/2)+1;
			var lenghtOfRoad = right - left;
			
			var closenesToBordersKoeff = 1- (lenghtToCenter+1)/(lenghtOfRoad/2);
			
			if(Math.abs(_body.GetLinearVelocity().x)<0.99 )
			_body.ApplyImpulse(new b2Vec2(horMovDirection*0.7, 0), _body.GetWorldCenter());
			
			if (_body.GetPosition().y * Global.RATIO > yPos)
				_body.ApplyImpulse(new b2Vec2(0, -((_body.GetPosition().y * Global.RATIO)-yPos)*0.2 -1), _body.GetWorldCenter());
			
			updateSpeedTrail();
			super.childSpecificUpdating();
		}
		
		override public function GetPixelYCoord():Number 
		{
			return super.GetPixelYCoord() - height/2;
		}
		
	}

}