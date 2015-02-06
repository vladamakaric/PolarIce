package  
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Neki gari
	 */
	public class SnowFlake 
	{
		//private var _snowflake:Sprite;

		private var i:Number;
		private var k:Number;
		private var rad:Number;

		private static var NUM_SNOWFLAKE_TYPES:Number=7;
		private static var FALLING_SPEED:Number=5;
		private static var WIND_SPEED:Number=5;
		private static var ROTATION_SPEED:Number=4;
		public var _snowflake:Sprite;
		
		public function SnowFlake(parent:DisplayObjectContainer) 
		{
			//trace(parent);
			var _ranSnowflake:int = (Math.random() * NUM_SNOWFLAKE_TYPES)+1;
			//_snowflake = new Bitmap(SnowEngine.snowFBD);
	
			switch(_ranSnowflake)
			{
				case 1:
					_snowflake = new SnowFlake1();
					break;
				case 2:
					_snowflake = new SnowFlake2();
					break;
				case 3:
					_snowflake = new SnowFlake3();
					break;
				case 4:
					_snowflake = new SnowFlake4();
					break;
				case 5:
					_snowflake = new SnowFlake5();
					break;
				case 6:
					_snowflake = new SnowFlake6();
					break;
				case 7:
					_snowflake = new SnowFlake7();
					break;
				case 8:
					_snowflake = new SnowFlake8();
					break;
				
			}
			
			
		//	_snowflake = new 
			//_snowflake = 
			_snowflake.x=(Math.random()*Global.screenWidth);
			_snowflake.y=(Math.random()*Global.screenHeight);
			//_snowflake.parent=this;

			i=1+Math.random()*2;
			k=-Math.PI+Math.random()*Math.PI;
			rad=0;

			//giving each snowflake unique characteristics
			_snowflake.scaleX = _snowflake.scaleY = Math.random()*0.4 + 0.1;
			//_snowflake.alpha = Math.random()*0.2 + 0.8;		
			
			parent.addChild(_snowflake);
		}
		
		public function Update() {
			//putting it all together
			rad += (k/180)*Math.PI;
			_snowflake.x -= Math.cos(rad);
			_snowflake.y += i;
			
			if (_snowflake.y>=  Global.lowerCameraLimit) {
				_snowflake.y = -FALLING_SPEED + Global.upperCameraLimit;
				_snowflake.x = -WIND_SPEED+Math.random()*Global.screenWidth;
			}

			if (_snowflake.y < Global.upperCameraLimit - FALLING_SPEED)
			{
				_snowflake.y = Global.lowerCameraLimit;
				_snowflake.x = -WIND_SPEED+Math.random()*Global.screenWidth;
			}
			
			if ((_snowflake.x >= Global.screenWidth) || (_snowflake.x<=0)) {
				_snowflake.x = -WIND_SPEED+Math.random()*Global.screenWidth;
				_snowflake.y = -FALLING_SPEED + Global.upperCameraLimit;
			}		

			_snowflake.rotation+=ROTATION_SPEED;
		}
		
	}

}

