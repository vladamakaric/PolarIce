package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class HeartCollectible extends Actor
	{
		
		public function HeartCollectible(position:b2Vec2) 
		{
			super(new MaloSrce());
			_costume.x = position.x;
			_costume.y = position.y;
			
			_body = Functions.CircleGenerator(position, _costume.width / 2, 7, 0, 0);
			_body.SetType(b2Body.b2_staticBody);
			_body.GetFixtureList().SetSensor(true);
			_body.SetUserData(this);
			

			Global.gameCanvas.addChild(_costume);
		}
		
		override protected function updateCostumePositionAndRotation():void 
		{
			//super.updateCostumePositionAndRotation();
		}
		
		override public function preDestroyUpdating():void 
		{
			
			
			
			if (_body != null)
			Global.world.DestroyBody(_body);
			
			_costume.scaleX *= 0.7;
			_costume.scaleY *= 0.7;
			
			if (Math.abs(_costume.scaleY) < 0.2)
			_destroy = true;
			
			super.preDestroyUpdating();
		}
		
	}

}