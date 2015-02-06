package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	//import mochi.as3.*;
	
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class LevelSelection extends State
	{
		var levelFrameArr:Array;
		var levelNum:int = 9;
		public var _SE:SnowEngine;
		var mainMenuBtn:MainMenuBtn;
		public var adHolder:MovieClip;
	//	var _
		public function LevelSelection(parent:DisplayObjectContainer) 
		{
			super(parent);
			Global.gameCanvas = _canvas;
			Global.stage = _canvas.stage;
			levelFrameArr = [];
			
			mainMenuBtn = new MainMenuBtn();
			mainMenuBtn.addEventListener(MouseEvent.MOUSE_DOWN, backToMainMenu);
			
			
		//	mainMenuBtn.scaleX = mainMenuBtn.scaleY = 0.6; 
			
			mainMenuBtn.x = 180;
			mainMenuBtn.y = 440;
			
			var bg:Sprite = new SkyBG();
			var sun:Sprite = new Sunce1();
			

			_canvas.addChild(bg);
			_canvas.addChild(sun);
			_canvas.addChild(mainMenuBtn);

			
			sun.x = 100;
			sun.y = 100;
			bg.x = 0;
			bg.y = Global.screenHeight;
			
			sun.scaleX = sun.scaleY = 2;
			
			var inf:LevelSelectionInfo = new LevelSelectionInfo();
			_canvas.addChild(inf);
			
			setUpAllLevelThumbnails();
			
			Global.upperCameraLimit = -Global.gameCanvas.y;
			Global.lowerCameraLimit = Global.screenHeight - Global.gameCanvas.y;
			
			Global.stage.addEventListener(MouseEvent.CLICK, mouseClick);
			Global.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			Global.upperCameraLimit = -Global.gameCanvas.y;
			Global.lowerCameraLimit = Global.screenHeight - Global.gameCanvas.y;
			_SE = new SnowEngine();

			
			adHolder = new MovieClip();
			adHolder.x = 331;
			adHolder.y = 131;
			_canvas.addChild(adHolder);

			//MochiAd.showClickAwayAd( {clip:adHolder, id:Global.GAME._mochiads_game_id}); 
			//uMochiAd.showClickAwayAd({clip:[mochiMC], id:"75909bba404b445b"});
		}
		
		private function mouseClick(e:MouseEvent):void 
		{
			
			var mousePos:b2Vec2 = new b2Vec2(e.stageX, e.stageY);
			
			var hitFrameIndx:int = -1;
			
			for (var i:int = 0; i < levelFrameArr.length; i++ )
			{
				if(!Global.levelUnlocked[i])
				continue;
				
				if (levelFrameArr[i].hitTestPoint(mousePos.x, mousePos.y))
				{
					hitFrameIndx = i;
					Global.currentLevelIndx = i;
					
					levelFrameArr[i].gotoAndStop(3);
					//Global.GAME.ChangeState(ActualGame);
					_changeToStateAfterFadeIn = Global.levelClassArr[Global.currentLevelIndx];
					startFadeIn();
					break;
				}
			}
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			updateLevelThumbnails(new b2Vec2(e.stageX, e.stageY));
		}
		
		override public function destroy():void 
		{
			Global.stage.removeEventListener(MouseEvent.CLICK, mouseClick);
			Global.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			super.destroy();
		}
		
		public function updateLevelThumbnails(mousePos:b2Vec2)
		{
			var hitFrameIndx:int = -1;
			
			for (var i:int = 0; i < levelFrameArr.length; i++ )
			{
				if (levelFrameArr[i].hitTestPoint(mousePos.x, mousePos.y))
				{
					hitFrameIndx = i;
					levelFrameArr[i].gotoAndStop(2);
					break;
				}
			}
			
			for (var i:int = 0; i < levelFrameArr.length; i++ )
			{
				if (i == hitFrameIndx)
				continue;
				
				levelFrameArr[i].gotoAndStop(1);
			}
			
			//Global.stage.mouseX
		}
		
		public function setUpAllLevelThumbnails()
		{
			var levelFrame:LevelBorderMC = new LevelBorderMC();
			
			var horBorderWidth:Number = 158;
			
			var verBordeHeight:Number = 105;
			
			var topLeftCornerOfBoux:b2Vec2 = new b2Vec2(horBorderWidth-140, verBordeHeight);
			
			var bottomRightCornerOfBoux:b2Vec2 = new b2Vec2(Global.screenWidth - horBorderWidth -140, Global.screenHeight - verBordeHeight); 
			
			bottomRightCornerOfBoux.y += 15;
			topLeftCornerOfBoux.y += 15;
			var bouxWidth:Number = bottomRightCornerOfBoux.x - topLeftCornerOfBoux.x;
			
			var bouxHeight:Number = bottomRightCornerOfBoux.y - topLeftCornerOfBoux.y;
			
			var totalHorizSpaceOccupiedByThumbs:Number = 3 * levelFrame.width;
			
			var totalFreeHorSpaceBetweenThumbs:Number = bouxWidth - totalHorizSpaceOccupiedByThumbs;
			var horizSpaceBetweenTwoThumbs:Number = totalFreeHorSpaceBetweenThumbs / 2-10;
			
			var currX:Number = topLeftCornerOfBoux.x + levelFrame.width/2;
			var currY:Number = topLeftCornerOfBoux.y + levelFrame.height / 2;
			//var xIncrement:Number = 
		
			var yStep:Number = (bouxHeight - levelFrame.height)/2;

			
			for (var i:int = 0; i < levelNum; i++ )
			{
				var newLvlFrame:LevelBorderMC = new LevelBorderMC();
				
				
				newLvlFrame.stop();
				newLvlFrame.x = currX;
				newLvlFrame.y = currY;
				newLvlFrame.buttonMode = true;
				
				
				//////////////////
				
			//	if(levelUnlocked[i])
			
				var backgroundThumb:MovieClip;
			
			if (Global.levelUnlocked[i])
			{
				backgroundThumb = new Global.unlockedLevelPictureClasses[i]();
			}
			else
				backgroundThumb = new pLockBGForLvlFrame();
			
				backgroundThumb.x = currX;
				backgroundThumb.y = currY;
				backgroundThumb.buttonMode = true;
				
				_canvas.addChild(backgroundThumb);
				/////////////////////
				
				levelFrameArr.push(newLvlFrame);
				
				_canvas.addChild(newLvlFrame);
				if ((!((i+1)%3)) && i)
				{
					currX = topLeftCornerOfBoux.x + levelFrame.width / 2;
					currY += yStep;
				}
				else
					currX += levelFrame.width + horizSpaceBetweenTwoThumbs;
			}
			
			for (var i:int = 0; i < levelNum; i++ )
			{
				levelFrameArr[i].parent.removeChild(levelFrameArr[i]);
				_canvas.addChild(levelFrameArr[i]);
			}
		}
		
		override public function logic():void 
		{
			_SE.Update();
			super.logic();
		}
		
		private function backToMainMenu(e:MouseEvent):void 
		{
			_changeToStateAfterFadeIn = MainMenu;
			startFadeIn();
			//Global.GAME.ChangeState(MainMenu);// ( new NavigationEvent( NavigationEvent.MAIN_MENU ) );
		}
	}

}