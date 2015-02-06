package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class BuncyPlatform extends Actor
	{
		var _width:Number;
		var _height:Number;
		
		public function BuncyPlatform(position:b2Vec2) 
		{
			super(new BouncyPlatformMC());
			
			_width = _costume.width;
			_height = _costume.height;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			position.x /= Global.RATIO;
			position.y /= Global.RATIO;
			bodyDef.position = position;
			bodyDef.type = b2Body.b2_staticBody;
			_body = Global.world.CreateBody(bodyDef);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(_width/2/Global.RATIO, _height/2/Global.RATIO);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			fixtureDef.restitution = 0;
			fixtureDef.friction = 0.2;
			_body.CreateFixture(fixtureDef);
			
			/*
			//botom triangle
			var bTshape:b2PolygonShape = new b2PolygonShape();	
			var bTArr:Array = [ new b2Vec2( _width / 2 / Global.RATIO, _height / 2 / Global.RATIO), new b2Vec2(-_width / 2 / Global.RATIO, _height / 2 / Global.RATIO), new b2Vec2(0, 0)];			
			bTshape.SetAsArray(bTArr, 3);
			var bTfixDef:b2FixtureDef = new b2FixtureDef();
			bTfixDef.shape = bTshape;
			bTfixDef.friction = 0.2;
			bTfixDef.density = 1;
			_body.CreateFixture(bTfixDef);
			
			
			//left triangle
			var lTshape:b2PolygonShape = new b2PolygonShape();	
			var lTArr:Array = [ new b2Vec2( -_width / 2 / Global.RATIO, _height / 2 / Global.RATIO), new b2Vec2( - _width / 2 / Global.RATIO, -_height / 2 / Global.RATIO), new b2Vec2(0, 0)];			
			lTshape.SetAsArray(lTArr, 3);
			var lTfixDef:b2FixtureDef = new b2FixtureDef();
			lTfixDef.shape = lTshape;
			lTfixDef.friction = 0.2;
			_body.CreateFixture(lTfixDef);
			
			//right triangle
			var rTshape:b2PolygonShape = new b2PolygonShape();	
			var rTArr:Array = [ new b2Vec2( _width / 2 / Global.RATIO, -_height / 2 / Global.RATIO), new b2Vec2(  _width / 2 / Global.RATIO, _height / 2 / Global.RATIO), new b2Vec2(0, 0)];			
			rTshape.SetAsArray(rTArr, 3);
			var rTfixDef:b2FixtureDef = new b2FixtureDef();
			rTfixDef.shape = rTshape;
			rTfixDef.friction = 0.2;
			_body.CreateFixture(rTfixDef);
			
			//upper triangle
			var uTshape:b2PolygonShape = new b2PolygonShape();	
			var uTArr:Array = [ new b2Vec2( -_width / 2 / Global.RATIO, -_height / 2 / Global.RATIO), new b2Vec2(_width / 2 / Global.RATIO, -_height / 2 / Global.RATIO), new b2Vec2(0, 0)];			
			uTshape.SetAsArray(uTArr, 3);
			var uTfixDef:b2FixtureDef = new b2FixtureDef();
			uTfixDef.shape = uTshape;
			//uTfixDef.friction = 0;
			uTfixDef.restitution = 4;
			//uTfixDef.density = 1;
			_body.CreateFixture(uTfixDef);*/
			
		/*	var lTriangle:b2PolygonShape = new b2PolygonShape();	
			var lowerTriangle:Array = [ new b2Vec2( -_width / 2 / Global.RATIO, -_height / 2 / Global.RATIO), new b2Vec2(_width / 2 / Global.RATIO, -_height / 2 / Global.RATIO), new b2Vec2(0, 0)];			
			lTriangle.SetAsArray(lowerTriangle, 3);
			var lowerTfixDef:b2FixtureDef = new b2FixtureDef();
			lowerTfixDef.shape = lTriangle;
			lowerTfixDef.friction = 0.2;
			_body.CreateFixture(lowerTfixDef);
			*/
			
			_body.SetUserData(this);
			_body.ResetMassData();
			Global.gameCanvas.addChild(_costume);
			updateCostumePositionAndRotation();
			//_costume.alpha = 0.2;
		}
		
		public function bounceAnimation():void
		{
			//Global.GAME.BounceSound.play();
			MovieClip(_costume).gotoAndPlay(2);
		}
		
		override public function childSpecificUpdating():void 
		{
			if (MovieClip(_costume).currentFrame == 1)
				MovieClip(_costume).stop();
			
			super.childSpecificUpdating();
		}
		
	}

}