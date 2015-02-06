package  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class State extends EventDispatcher
	{
		var _changeToStateAfterFadeIn:Class = null;
		var _canvas:MovieClip;
		var _fade:Boolean = true;
		var _fadeDir:Number = -1;
		var _fadeCounter:Number = 0;
		var _fadeCrementNum:Number = 9;
		var _fadeCrement:Number = 1 / _fadeCrementNum;
		var _pause:Boolean = false;
		var _pauseCounter:int = 0;
		
		public function State(parent:DisplayObjectContainer) 
		{
			_canvas = new MovieClip();	
			parent.addChild(_canvas);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		public function startFadeIn()
		{
			_fadeCounter = 0;
			_fadeDir = 1;
			_fade = true;
		}
		
		public function pauseLogic():void
		{
			if (!_pauseCounter)
			startPauseLogic();
			
			_pauseCounter++;
		}
		
		public function endPauseLogic():void
		{
			
		}
		
		public function startPauseLogic():void
		{
			
		}
		
		public function fadeLogic():void 
		{
			if (!_fadeCounter)
			{
				if (_fadeDir>0)
				{
					Global.blackScreen.alpha = 0;
					Global.GAME.addChild(Global.blackScreen);
					//_canvas.addChild(_blackScreen);
					//_blackScreen
				}
				else
				{
					Global.blackScreen.alpha = 1;
					//_canvas.addChild(_blackScreen);
				}
				
				Global.blackScreen.x = 0;
				Global.blackScreen.y = 0;
			}
			
			_fadeCounter++;
			Global.blackScreen.alpha += _fadeDir * _fadeCrement;
			
			if (_fadeCounter == _fadeCrementNum)
			{
				
				if (_fadeDir > 0)
				{
					Global.GAME.ChangeState(_changeToStateAfterFadeIn);
					
				}
				else
				Global.blackScreen.parent.removeChild(Global.blackScreen);
				
				_fade = false;
			}
		}
		
		public function logic():void { }
		public function handleEvents():void { }
		public function destroy():void 
		{ 
			_canvas.parent.removeChild(_canvas);
		}
	}

}