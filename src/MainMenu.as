package  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class MainMenu extends State
	{
		
		//var newGameButton:NewGameButton;
		var playButton:PlayButton;
		var creditsButton:CreditsBtn;
		var soundToggle:ZvucniMC;
		public var _SE:SnowEngine;
		
		
		public function MainMenu(parent:DisplayObjectContainer) 
		{
			super(parent);
			Global.gameCanvas = _canvas;
			playButton = new PlayButton();
			playButton.addEventListener(MouseEvent.MOUSE_DOWN, mouseClickPlayButton);
			playButton.x = 320;
			playButton.y = 375;
			
			creditsButton = new CreditsBtn();
			creditsButton.addEventListener(MouseEvent.MOUSE_DOWN, mouseClickCreditsButton);
			creditsButton.x = 320;
			creditsButton.y = 435;
			
			soundToggle = new ZvucniMC();			
			soundToggle.x = 600;
			soundToggle.y = 33;
			
			soundToggle.addEventListener(MouseEvent.MOUSE_DOWN, soundToggleOnClick);
			
			soundToggle.scaleX = soundToggle.scaleY = 0.6;
			
			if (Global.SOUND)
			soundToggle.gotoAndStop(1);
			else
			soundToggle.gotoAndStop(2);
			
			soundToggle.buttonMode = true;
			
			var bg:Sprite = new SkyBG();
			var sun:Sprite = new Sunce1();
			var firstMountain:MovieClip = new SSM();
			var secondMountain:MovieClip = new SMM();
			var thirdMountain:MovieClip = new SBM();
			
			bg.scaleY = 0.6;
			
			bg.x = 0;
			bg.y = Global.screenHeight - 200;
			
			
			sun.x = 100;
			sun.y = 100;
			
			thirdMountain.scaleX = thirdMountain.scaleY = 0.7;
			secondMountain.scaleX = secondMountain.scaleY = 0.85;
			firstMountain.scaleX = firstMountain.scaleY = 0.5;
			firstMountain.x = secondMountain.x = thirdMountain.x = 0;
			
			firstMountain.y = Global.screenHeight-175;
			secondMountain.y = Global.screenHeight-110;
			thirdMountain.y =  Global.screenHeight;
			
			
			
			_canvas.addChild(bg);
			_canvas.addChild(sun);
			_canvas.addChild(firstMountain);
			_canvas.addChild(secondMountain);
			_canvas.addChild(thirdMountain);
			_canvas.addChild(playButton);
			_canvas.addChild(creditsButton);
			_canvas.addChild(soundToggle);
			_canvas.addChild(new TitleScreen());
			
			Global.upperCameraLimit = -Global.gameCanvas.y;
			Global.lowerCameraLimit = Global.screenHeight - Global.gameCanvas.y;
			_SE = new SnowEngine();
			
			if (Global.currentBackgroundMusic != Global.MENUMUSIC)
			{
				SoundMixer.stopAll();
				Global.currentBackgroundMusic = Global.MENUMUSIC;
				Global.GAME.backgroundMusicChannel = Global.GAME.MenusMusic.play(0, int.MAX_VALUE);
			}
		}
		
		private function soundToggleOnClick(e:MouseEvent):void 
		{
			Global.SOUND = !Global.SOUND;
			
			if (Global.SOUND)
			{
				soundToggle.gotoAndStop(1);
				SoundMixer.soundTransform = new SoundTransform(1);
			}
			else
			{
				soundToggle.gotoAndStop(2);
				SoundMixer.soundTransform = new SoundTransform(0);
			}
		}
		
		private function mouseClickCreditsButton(e:MouseEvent):void 
		{
			_changeToStateAfterFadeIn = Credits;
			startFadeIn();
		}
		
		override public function destroy():void 
		{
			playButton.removeEventListener(MouseEvent.MOUSE_DOWN, mouseClickPlayButton);
			super.destroy();
		}
		
		private function mouseClickPlayButton(e:MouseEvent):void 
		{
			_changeToStateAfterFadeIn = LevelSelection;
			startFadeIn();
			//Global.GAME.ChangeState(LevelSelection);
		}
		
		override public function logic():void 
		{
			_SE.Update();
			super.logic();
		}
	}

}

