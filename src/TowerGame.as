package  
{
	import Box2D.Collision.b2AABB;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.net.SharedObject;
	import flash.media.Sound;
	import mochi.as3.*;

	
	
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class TowerGame extends MovieClip
	{
		var _mochiads_game_id:String = "25878dd82fd3a71c";
		var nextStateClass:Class = MainMenu;
		var currentState:State;
		var changeState:Boolean = false;
		
		var backgroundMusicChannel:SoundChannel;
		var laserBurnChannel:SoundChannel;
		
		var ThrowSound:Sound;
		var CannonShotSound:Sound;
		var ExplosionSound:Sound;
		var SnowBallSound:Sound;
		var BounceSound:Sound;
		var StompSound:Sound;
		var SnowBallFireSound:Sound;
		var IceCollectSound:Sound;
		var HeartCollectSound:Sound;
		var SnowBallCollectSound:Sound;
		var LifeLostSound:Sound;
		var PickUpSound:Sound;
		var ScreamSound:Sound;
		var JumpSound:Sound;
		var LaserBurnSound:Sound;
		var BearRoarSound:Sound;
		
		var LevelCompleteMusic:Sound;
		var GameOverMusic:Sound;
		var CongratsMusic:Sound;
		
		var MenusMusic:Sound;
		var Tier1Music:Sound;
		var Tier2Music:Sound;
		var Tier3Music:Sound;
		//var ThrowSound:Sound;
		
		
		public function TowerGame() 
		{
			
			
			
			ThrowSound = new SFXThrow();
			CannonShotSound = new SFXCannonShot();
			ExplosionSound = new SFXExplosion();
			SnowBallSound = new SFXSnowBall();
			BounceSound = new SFXBounce();
			StompSound = new SFXPop();
			SnowBallFireSound = new SFXSBFire();
			IceCollectSound = new SFXIceCollect();
			HeartCollectSound = new SFXHeartCollected();
			SnowBallCollectSound = new SFXSBCollect();
			LifeLostSound = new SFXLifeLost();
			PickUpSound = new SFXPickUp();
			ScreamSound = new SFXScream();
			JumpSound = new SFXJump();			
			LaserBurnSound = new SFXLaserBurn();
			BearRoarSound = new SFXBear();
			
			
			MenusMusic = new M_Menus();
			LevelCompleteMusic = new M_LvlComplete();
			GameOverMusic = new M_GameOver();
			Tier1Music = new M_Tier1();
			Tier2Music = new M_Tier2();
			Tier3Music = new M_Tier3();
			CongratsMusic = new M_Congrats();
			
			backgroundMusicChannel = new SoundChannel();
			laserBurnChannel = new SoundChannel();
			
			Global.GAME = this;
			Global.blackScreen = new BlackScreen();
			Global.levelUnlocked = [ true, false, false, false, false, false, false, false, false ];
			Global.unlockedLevelPictureClasses = [ L1Thumb, L2Thumb, L3Thumb, L4Thumb, L5Thumb, L6Thumb, L7Thumb, L8Thumb, L9Thumb ] ;
			Global.levelClassArr = [Level1, Level2, Level3, Level5, Level4, Level7, Level6, Level9, Level8 ];
			levelClassArr:Array;
			
			BakeCookies();
/*
			Global.blackScreen.graphics.beginFill(0x000000); // choosing the colour for the fill, here it is red
			Global.blackScreen.graphics.drawRect(0, 0, Global.screenWidth, Global.screenHeight); // (x spacing, y spacing, width, height)
			Global.blackScreen.graphics.endFill();
			*/
			currentState = new MainMenu(this);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
			/*
			addEventListener(NavigationEvent.NEW_GAME, newGame);
			addEventListener(NavigationEvent.MAIN_MENU, mainMenu);
			addEventListener(NavigationEvent.CHANGE_STATE, changeState);*/
			addEventListener(Event.ENTER_FRAME, Update);
			Global.GAME.addChild(Global.blackScreen);
		}
		
		public function BakeCookies()
		{
			Global.cookie = SharedObject.getLocal("polarIceLevels");
			//var levels = new Array();
			
			if (Global.cookie.data.completed_levels == undefined)
				Global.cookie.data.completed_levels = new Array(1, 0, 0, 0, 0, 0, 0, 0, 0);
				//Global.cookie.data.completed_levels = [];
				
			Global.levelUnlocked = Global.cookie.data.completed_levels;
		}

		public function ChangeState(st:Class)
		{
			nextStateClass = st;
			changeState = true;
		}
		
		private function Update(e:Event):void 
		{
			Global.TIME++;
			currentState.handleEvents();

			if (currentState._fade)
			{
				currentState.fadeLogic();
			}
			else if (currentState._pause)
			{
				currentState.pauseLogic();
			}
						
		
			if(!currentState._pause)
				currentState.logic();
				
			if (changeState)
			{
				changeState = false;
				Global.blackScreen.alpha = 1;	
				Global.GAME.removeChild(Global.blackScreen);
				Global.GAME.addChild(Global.blackScreen); 
				
			//	MochiAd.showInterLevelAd({clip:root, id:"75909bba404b445b", res:"640x480"});
				
				currentState.destroy();
				currentState = null;
				currentState = new nextStateClass(this);
				stage.focus = stage;

				Global.GAME.removeChild(Global.blackScreen);
				Global.GAME.addChild(Global.blackScreen); 
				//setChildIndex(Global.blackScreen, numChildren - 1);
			}
			
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
	}

}