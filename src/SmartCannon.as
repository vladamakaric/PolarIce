package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class SmartCannon extends Actor
	{
		var cannonBarrelSprite:MovieClip;
		var timeAfterLastShot:Number = 0;
		var left:Boolean = false;
		var rotateBarrel:Boolean = false;
		var rotationDirection:Number = 1;
		var angleIncrement:Number = 3;
		var fire:Boolean = false;
		var groundPosition:b2Vec2;
		var barrelPivotPosition:b2Vec2;
		var goalAngle:Number;
		var fireStarted:Boolean = false;
		var rayCast:Boolean = true;
		
		public function SmartCannon(position:b2Vec2, angle:Number) 
		{
			super(new Sprite());
			
			
			groundPosition = position;
			cannonBarrelSprite = new GunBarrel();
			cannonBarrelSprite.gotoAndStop(18);
			barrelPivotPosition = position.Copy();
			barrelPivotPosition.y -= 15;
			
			
			cannonBarrelSprite.x = barrelPivotPosition.x;
			cannonBarrelSprite.y = barrelPivotPosition.y;
						
			if (angle < 0)
			{
				left = true;
				cannonBarrelSprite.scaleX *= -1;
				cannonBarrelSprite.rotation = angle + 90;
			}
			else
			cannonBarrelSprite.rotation = angle - 90;

		//	Sprite(_costume).addChild(newSprite);
			Sprite(_costume).addChild(cannonBarrelSprite);
			
			var stand:Sprite = new SmartCannonStand();
			
			stand.x = position.x;
			stand.y = position.y;
			
			Sprite(_costume).addChild(stand);

			
			cannonBarrelSprite.stop();
			Global.gameCanvas.addChild(_costume);
			
			
		}
		
		private function Callback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number ):Number
		{
			if (fixture.GetBody().GetUserData() is WalkingActor)
				return 1;
				
			if (fixture.GetBody().GetUserData() is FloorActor)
			{
				rayCast = false;
				return 0;
			}
			
			return 1;
		}
		
		private function PlayerVisible(A:b2Vec2 , B:b2Vec2):Boolean 
		{
			rayCast = true;
			Global.world.RayCast(Callback, A, B);
			return rayCast;
		}
		
		public function Aim()
		{
			if (Global.player == null)
			{

				fire = false;
				
				return;
			}

			var playerPos:b2Vec2 = Global.player._body.GetPosition().Copy();
			Functions.MultiplyB2Vec2ByRatio(playerPos);
			
			

			
			
			if (playerPos.y > groundPosition.y - 15)
				return;
				
			if (groundPosition.y - 15 - playerPos.y > Global.screenHeight * 0.5)
				return;
				
				
			var cpos:b2Vec2 = groundPosition.Copy();
			cpos.y -= 20;
			var ppos:b2Vec2 = playerPos.Copy();
			Functions.DivideB2Vec2ByRatio(ppos);
			Functions.DivideB2Vec2ByRatio(cpos);
			
			if (!PlayerVisible(ppos, cpos))
				return;
			
			if (left)
			{
				if (playerPos.x > groundPosition.x)
					return;

				var xDiff:Number = groundPosition.x - playerPos.x;
				
				var verticalDegradation:Number = ((xDiff*xDiff) / (480*480))* 80;
					
				playerPos.y -= verticalDegradation;
				
				var vecToPlayer:b2Vec2 = Functions.GetVectorFromAToB(barrelPivotPosition, playerPos);
				vecToPlayer.Normalize();
				
				var playAngle:Number = 90 - (Functions.GetProcessedAngleFromVector(vecToPlayer) * 180 / Math.PI - 270);
				
				goalAngle = playAngle;

				RotateBarrel();

			}
			else
			{
				if (playerPos.x < groundPosition.x)
					return;
				
				var xDiff:Number = groundPosition.x - playerPos.x;
				var yDiff:Number = groundPosition.y - playerPos.y;
				
				
				var verticalDegradation:Number = ((xDiff * xDiff) / (480 * 480)) * 80;
				
				var verticalDegradation2:Number = yDiff / 5;
					
				playerPos.y -= (verticalDegradation + verticalDegradation2);
				
				var vecToPlayer:b2Vec2 = Functions.GetVectorFromAToB(barrelPivotPosition, playerPos);
				vecToPlayer.Normalize();
				
				var playAngle:Number =  (Functions.GetProcessedAngleFromVector(vecToPlayer) * 180 / Math.PI) - 90;
				
				goalAngle = playAngle;

				RotateBarrel();
			}
		}
		
		public function RotateBarrel()
		{
			if (cannonBarrelSprite.currentFrame != 18 && cannonBarrelSprite.currentFrame > 13)
			return;
			
			var angle:Number =  90 - cannonBarrelSprite.rotation;

			if(!left)
				angle = cannonBarrelSprite.rotation;

			if (Math.abs(angle - goalAngle) < 2)
			{
				fire = true;
				return;
			}
			
			if (left)
			{	
				if (angle > goalAngle)
				rotationDirection = -1;
					else
				rotationDirection = 1;
			}
			else
			{
				if (angle > goalAngle)
				rotationDirection = -1;
					else
				rotationDirection = 1;
			}
			
			angle += angleIncrement * rotationDirection;

			
			if (!left)
			cannonBarrelSprite.rotation = angle;
			else
			cannonBarrelSprite.rotation = 90 - angle;
		}
		
		override public function childSpecificUpdating():void 
		{
			timeAfterLastShot++;
			Aim();
			
			if (timeAfterLastShot > 40 && fire && cannonBarrelSprite.currentFrame == 18)
			{
				cannonBarrelSprite.gotoAndPlay(1);
				fire = false;
			}
			
			if (cannonBarrelSprite.currentFrame == 13)
			{	
				Global.GAME.CannonShotSound.play();
				timeAfterLastShot = 0; 
				var cannonBallFiringPos:b2Vec2;
				
				var angleVector:b2Vec2;
				
				if(left)
				angleVector = new b2Vec2(Math.cos((180-cannonBarrelSprite.rotation) / 180 * Math.PI), -Math.sin((180-cannonBarrelSprite.rotation) / 180 * Math.PI));
				else
				angleVector = new b2Vec2(Math.cos((-cannonBarrelSprite.rotation) / 180 * Math.PI), -Math.sin((-cannonBarrelSprite.rotation) / 180 * Math.PI));
				
				var barrelLenght:b2Vec2 = angleVector.Copy();
				barrelLenght.Multiply(60);
				
				cannonBallFiringPos = new b2Vec2(cannonBarrelSprite.x, cannonBarrelSprite.y);
				cannonBallFiringPos.Add(barrelLenght);
				
				var newSprite:Sprite = new Sprite();
				newSprite.graphics.lineStyle(2, 0x00D900);
				newSprite.graphics.moveTo(cannonBarrelSprite.x, cannonBarrelSprite.y);
				newSprite.graphics.lineTo(cannonBallFiringPos.x , cannonBallFiringPos.y);

				var forceVector:b2Vec2 = angleVector.Copy();
				
				forceVector.Multiply(7);

				Global.allActors.push(new CannonBall(cannonBallFiringPos.Copy(), forceVector));
				
				
			}
			else if (cannonBarrelSprite.currentFrame == 18)
				cannonBarrelSprite.stop();
		}
		
		override public function StopAnimation():void 
		{
			cannonBarrelSprite.stop();
		}
		
		override public function GetPixelYCoord():Number 
		{
			return cannonBarrelSprite.y;
		}
		
		override public function Reanimate():void 
		{
			if (cannonBarrelSprite.currentFrame != 18)
			cannonBarrelSprite.play();
		}
	}
}