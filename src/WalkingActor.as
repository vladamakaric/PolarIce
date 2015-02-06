package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class WalkingActor extends Actor
	{
		public var _groundedCounter:Number = 0;
		public var _grounded:Boolean=false;	
		public var _width:Number;
		public var _height:Number;
		public var _health:Number;

		public function WalkingActor(myCostume:DisplayObject)  
		{
			super(myCostume);
		}
		
		public function healthDecreasedToZerohHandler()
		{
			_preDestroy = true;
		}
		
		override public function childSpecificUpdating():void 
		{
		//	determineGroundedness();
			super.childSpecificUpdating();
		}
		
		public function determineGroundedness()
		{
			if (_groundedCounter>0)
				_grounded = true;
				else
				_grounded = false;
		}
		
		public function UpdateHealthBy(updtAmount:Number)
		{
			_health += updtAmount;
			
			if (_health < 1)
			{
				healthDecreasedToZerohHandler();
			}
		}
		
		protected function SetupGroundedSensor(xSensorIndent:Number, addToBottom:Number = 0):void
		{
			var sensorFixtureDef:b2FixtureDef = new b2FixtureDef();
			var sensorShape:b2PolygonShape = new b2PolygonShape();
			sensorShape.SetAsOrientedBox((_width - 2*xSensorIndent) / 2 / Global.RATIO, 4 / Global.RATIO + addToBottom, new b2Vec2(0, _height / 2 / Global.RATIO - 4 / Global.RATIO));
			
			sensorFixtureDef.shape = sensorShape;
			sensorFixtureDef.isSensor = true;
			_body.CreateFixture(sensorFixtureDef);
		}
		

		
	}

}