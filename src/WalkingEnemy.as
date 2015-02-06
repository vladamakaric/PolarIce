package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class WalkingEnemy extends WalkingActor
	{
		protected var rayCast:Boolean = false;
		var _contactNum:Number = 0;
	//	var _horWayOfMovement:Number;
		var newSprite:Sprite = null;
		
		public function WalkingEnemy(myCostume:DisplayObject)  
		{
			super(myCostume);
		}	
		
		protected function IsLineBlocked(A:b2Vec2 , B:b2Vec2):Boolean 
		{
			rayCast = false;
			Global.world.RayCast(GroundSurfaceCallback, A, B);
			return rayCast;
		}
		
		public function GroundSurfaceCallback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number ):Number
		{
			if (fixture.GetBody().GetUserData() != null)
			if (fixture.GetBody().GetUserData() is FloorActor)
			{
				rayCast = true;
				
				if(fixture.GetBody().GetUserData() is VerticalMovingPlatform || fixture.GetBody().GetUserData() is HorizontalMovingPlatform)
					rayCast = false;
				
				return 0;
			}
			
			rayCast = false;
			return 1;
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
	}

}