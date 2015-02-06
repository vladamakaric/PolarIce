package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class Cannon extends Actor
	{
		var cannonBarrelSprite:MovieClip;
		var angleVector:b2Vec2;
		var timeAfterLastShot:Number = 0;
		var cannonBallFiringPos:b2Vec2;
		
		var shotDelay:int;
		
		
		public function Cannon(position:b2Vec2, angle:Number, shDel:int = 50 ) 
		{
			super(new Sprite());
			
			shotDelay = shDel;
			
			
			cannonBarrelSprite = new GunBarrel();
			
			cannonBarrelSprite.x = position.x;
			cannonBarrelSprite.y = position.y - 15;
						
			if (angle < 0)
				cannonBarrelSprite.scaleX *= -1;
			
			if (angle > 0)
			{
				cannonBarrelSprite.rotation = angle - 90;
				angleVector = new b2Vec2(Math.cos((90 - angle) / 180 * Math.PI), -Math.sin((90 - angle) / 180 * Math.PI));
			}
			else
			{
				cannonBarrelSprite.rotation = angle + 90;
				angleVector = new b2Vec2(Math.cos((90 - angle) / 180 * Math.PI), -Math.sin((90 - angle) / 180 * Math.PI));	
			}

			var barrelLenght:b2Vec2 = angleVector.Copy();
			barrelLenght.Multiply(60);
			
			cannonBallFiringPos = new b2Vec2(cannonBarrelSprite.x, cannonBarrelSprite.y);
			cannonBallFiringPos.Add(barrelLenght);
			
			var newSprite:Sprite = new Sprite();
			newSprite.graphics.lineStyle(2, 0x00D900);
			newSprite.graphics.moveTo(position.x, position.y);
			newSprite.graphics.lineTo(position.x + angleVector.x, position.y + angleVector.y);

			Sprite(_costume).addChild(newSprite);
			Sprite(_costume).addChild(cannonBarrelSprite);
			
			var stand:Sprite = new CannonStand();
			
			stand.x = position.x;
			stand.y = position.y;
			
			Sprite(_costume).addChild(stand);

			cannonBarrelSprite.stop();
			Global.gameCanvas.addChild(_costume);
		}
		
		override public function StopAnimation():void 
		{
			cannonBarrelSprite.stop();
		}
		
		override public function Reanimate():void 
		{
				if (cannonBarrelSprite.currentFrame != 18)
				cannonBarrelSprite.play();
		}
		
		override public function GetPixelYCoord():Number 
		{
			return cannonBarrelSprite.y;
		}
		
		override public function childSpecificUpdating():void 
		{
			timeAfterLastShot++;
			
			
			if (cannonBarrelSprite.currentFrame == 18)
				cannonBarrelSprite.stop();
			
			if (timeAfterLastShot > shotDelay && _visible)
			{
				cannonBarrelSprite.play();
			
				if(timeAfterLastShot==shotDelay + 1)
					cannonBarrelSprite.gotoAndPlay(1);
					
				if (cannonBarrelSprite.currentFrame == 13)
				{	
					Global.GAME.CannonShotSound.play();
					timeAfterLastShot = 0; 
					
					var forceVector:b2Vec2 = angleVector.Copy();
					
					forceVector.Multiply(9);

					
					
					
					Global.allActors.push(new CannonBall(cannonBallFiringPos.Copy(), forceVector));
				}
				
			}
		}
	}
}


