package  
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class HUD 
	{
		var heart:MovieClip;
		var snowBallCounter:MovieClip;
		var iceCubeCounter:MovieClip;
		
		var glowSBCounter2:Number = 0;
		var blurKoef2:Number = 1;
		
		var blurDir2:Number = 1;
		var blurSpeed2:Number = 5;
		
		var maxBlurKoef2:Number = 20;
		var maxSBC2:Number = 5;
		
		var glowSBCounter:Number = 0;
		var blurKoef:Number = 1;
		
		var blurDir:Number = 1;
		var blurSpeed:Number = 5;
		
		var maxBlurKoef:Number = 20;
		var maxSBC:Number = 5;
		
		public function HUD() 
		{
			heart = new VelikoSrce();
			snowBallCounter = new SnowBall3();
			iceCubeCounter = new IceCubeBig();
			heart.gotoAndStop(46);
			
			Global.gameCanvas.addChild(snowBallCounter);
			Global.gameCanvas.addChild(heart);
			Global.gameCanvas.addChild(iceCubeCounter);
		}
		
		public function update(player:PlayerActor)
		{
			heart.x = 640 - 42/2 -10;
			heart.y = -Global.gameCanvas.y + 38 / 2 + 10;
			snowBallCounter.y = -Global.gameCanvas.y + snowBallCounter.height/2 + 20 + 38;
			snowBallCounter.x = 640 - 10 - snowBallCounter.width/2;
			snowBallCounter.SnowBallNumber.text = player.snowBallCount.toString();
			
			iceCubeCounter.y = -Global.gameCanvas.y + snowBallCounter.height/2 + 20 + 38 + 40 + 7;
			iceCubeCounter.x = 640 - 9 - iceCubeCounter.width/2;
			iceCubeCounter.IceCubeNumberTXT.text = Global.currentLevel._iceCubesCollected.toString() + "/" + Global.currentLevel._iceCubesToCollect.toString();
			
			if ( player._health == 3 )
			{
				if (heart.currentFrame == 11)
					heart.gotoAndPlay(39);
				else
				if (heart.currentFrame == 46)
					heart.stop();
			}
			else
			if (player._health == 2)
			{
				if (heart.currentFrame == 46)
					heart.play();
				else
				if (heart.currentFrame == 11)
					heart.stop();
					else 
				if (heart.currentFrame == 21)
					heart.gotoAndPlay(31);
					else if (heart.currentFrame == 39)
					heart.gotoAndStop(11);
			}
			else
			if (player._health == 1)
			{
				if (heart.currentFrame == 11)
					heart.play();
				else
				if (heart.currentFrame == 21)
				heart.stop();
			}	
			else
			if (player._health == 0)
			{
				if (heart.currentFrame == 21)
					heart.play();
					else
				if (heart.currentFrame == 30)
				heart.stop();
			}
			
			if (glowSBCounter)
			{
				if (glowSBCounter == 1)
					blurDir = 1;

				glowSBCounter++;

				if (maxSBC < glowSBCounter)
					blurDir = -1;
								
				blurKoef += blurDir * blurSpeed;
				
				if (blurKoef > maxBlurKoef && blurDir ==1)
					blurKoef = maxBlurKoef;

				if (blurKoef < 0)
				{
					glowSBCounter = 0;
					snowBallCounter.filters = [];					
					return;
				}
										
				var gf:GlowFilter = new GlowFilter(0x93FFFF, 1, blurKoef, blurKoef);
				snowBallCounter.filters = [gf];
			}
			
			if (glowSBCounter2)
			{
				if (glowSBCounter2 == 1)
					blurDir2 = 1;

				glowSBCounter2++;

				if (maxSBC2 < glowSBCounter2)
					blurDir2 = -1;
								
				blurKoef2 += blurDir2 * blurSpeed2;
				
				if (blurKoef2 > maxBlurKoef2 && blurDir2 ==1)
					blurKoef2 = maxBlurKoef2;

				if (blurKoef2 < 0)
				{
					glowSBCounter2 = 0;
					iceCubeCounter.filters = [];
					
					if (Global.currentLevel._iceCubesCollected == Global.currentLevel._iceCubesToCollect)
					{
						Global.currentLevel._levelComplete = true;
						Global.currentLevel._pause = true;
					}
					
					return;
				}
										
				var gf:GlowFilter = new GlowFilter(0xDFFFFF, 1, blurKoef2, blurKoef2, 1.5,2);
				iceCubeCounter.filters = [gf];
			}
		}
		
	}

}