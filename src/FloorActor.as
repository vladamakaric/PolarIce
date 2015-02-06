package  
{
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class FloorActor extends Actor
	{
		public function FloorActor(myCostume:DisplayObject)  
		{
			super(myCostume);
		}
		
		override public function updateRotation():void 
		{
			//super.updateRotation();
		}
		
	}

}