package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.media.SoundTransform;
	import flash.ui.Keyboard;
	import flash.media.SoundMixer;
	//import mochi.as3.*;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class Level extends State
	{
		public var _iceCubesToCollect:Number = 0;
		public var _iceCubesCollected:Number = 0;
		public var _levelComplete:Boolean = false;
		public var _levelCBlur:Number = 0;
		public var _levelCBlurCrement:Number = 0.5;
		
		public var _pauseAnimation:LevelPauseAnimMC;
		public var _levelCompleteAnimation:LevelCompleteAnim;
		public var _gameOverAnimation:gameOverAnim;
		public var _allActors:Array;
		public var _allParticleSystems:Array;
		public var _player:PlayerActor;
		public var _PSE:ParallaxScrollingEngine;
		public var _SE:SnowEngine;
		public var _height;
		public var _HUD:HUD;
		public var _endingPause:Boolean = false;
		public var _pausePressed:Boolean = false;
		public var _gameOver:Boolean = false;
		public var screenshot:Bitmap;
		public var _playerPos:b2Vec2;
		public var _laserBurning:Boolean = false;
		public var _laserFlowing:Boolean = false;
		public var djoleReno:MovieClip = null;
		
		
		
		
		public function Level(parent:DisplayObjectContainer) 
		{	
			super(parent);
			_playerPos = new b2Vec2(30, 400);
			
			
			_allActors = [];
			_allParticleSystems = [];
			_pauseAnimation = new LevelPauseAnimMC();
			_levelCompleteAnimation = new LevelCompleteAnim();
			_gameOverAnimation = new gameOverAnim();
			
			_pauseAnimation.pauseSlide1.soundBtn1.stop();
			_levelCompleteAnimation.stop();
			_gameOverAnimation.stop();
			//restartBtn1

			_pauseAnimation.pauseSlide1.soundBtn1.buttonMode = true;
			
//_levelCompleteAnimation.
			
			if(Global.SOUND)
			_pauseAnimation.pauseSlide1.soundBtn1.gotoAndStop(1);
			else
			_pauseAnimation.pauseSlide1.soundBtn1.gotoAndStop(2);
			
		//	trace(_pauseAnimation.soundBtn1);
			
			Global.allActors = _allActors;
			Global.stage = _canvas.stage;
			Global.gameCanvas = _canvas;
			Global.allParticles = _allParticleSystems;
			Global.currentLevel = this;
			
			SettupBox2D();
			_PSE = new ParallaxScrollingEngine();

			Global.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress );
			Global.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease );
		}

		
		private function updateCookie()
		{	
			Global.cookie.data.completed_levels = Global.levelUnlocked;		
			
			Global.cookie.flush();
		}
		
		private function goToNextLevel(e:MouseEvent):void 
		{
			if (Global.currentLevelIndx == 8)
				_changeToStateAfterFadeIn = LevelSelection;
			else
				_changeToStateAfterFadeIn = Global.levelClassArr[++Global.currentLevelIndx];
			
			startFadeIn();
		}
		
		override public function destroy():void 
		{
			Global.stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyPress );
			Global.stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyRelease );
			
			Global.allActors = null;
			Global.stage = null;
			Global.gameCanvas = null;
			Global.allParticles = null;
			Global.currentLevel = null;
			
			super.destroy();
		}
		
		private function soundOnOffClick(e:MouseEvent):void 
		{
			Global.SOUND = !Global.SOUND;
			
			if (Global.SOUND)
			{
				_pauseAnimation.pauseSlide1.soundBtn1.gotoAndStop(1);
				SoundMixer.soundTransform = new SoundTransform(1);
			}
			else
			{
				_pauseAnimation.pauseSlide1.soundBtn1.gotoAndStop(2);
				SoundMixer.soundTransform = new SoundTransform(0);
			}
		}
		
		private function restartLevel(e:MouseEvent):void 
		{
			_changeToStateAfterFadeIn = Global.GAME.nextStateClass;
			startFadeIn();
		}
		
		private function backToGame(e:MouseEvent):void 
		{
			_endingPause = true;
		}
		
		public function backToMainMenu(e:MouseEvent):void 
		{
			_changeToStateAfterFadeIn = MainMenu;
			startFadeIn();
			
		//	SimpleButton(_pauseAnimation.pauseSlide1.mainMenuBtn1).enabled = true;// enabled = false;
		//	SimpleButton()
		//	Button(_pauseAnimation.pauseSlide1.mainMenuBtn1).setMouseState("down");
			SimpleButton(_pauseAnimation.pauseSlide1.mainMenuBtn1).enabled = false;
		}
		
		private function onKeyRelease(keyboardEvent:KeyboardEvent):void 
		{
			if ( keyboardEvent.keyCode == 80)
				_pausePressed = false;
		}
		
		private function onKeyPress(keyboardEvent:KeyboardEvent):void 
		{
			if ( keyboardEvent.keyCode == 80 && !_pausePressed && !_levelComplete)
			{
				_pausePressed = true;
				
				if (_pause)
					_endingPause = true;
				else
				_pause = true;
			}
		}

		public function postConstruction()
		{
			addPlayer();
			_SE = new SnowEngine();
			_HUD = new HUD();
		}
		
		public function setLevelHeightAndCreateBoundingBox(height:Number)
		{
			_height = height;
			Functions.AddInvisibleRectangle(new b2Vec2(-20, Global.screenHeight), Global.screenWidth + 40, 20);
			Functions.AddInvisibleRectangle(new b2Vec2( -20, -_height + Global.screenHeight), 20, _height);
			Functions.AddInvisibleRectangle(new b2Vec2( Global.screenWidth, -_height + Global.screenHeight), 20, _height);	
		}
		
		public function addPlayer()
		{
			_player = new PlayerActor(_playerPos);
			_allActors.push(_player);
			Global.player = _player;	
		}
		
		private function updateCamera()
		{
			_canvas.y = -_player._body.GetPosition().y * Global.RATIO + Global.screenHeight / 2;

			if(_canvas.y < 0 )
				_canvas.y = 0; 
				
			if (_canvas.y > _height - Global.screenHeight)
			_canvas.y = _height - Global.screenHeight;
			
			Global.upperCameraLimit = -Global.gameCanvas.y;
			Global.lowerCameraLimit = Global.screenHeight - Global.gameCanvas.y;
		}
		
		override public function logic():void 
		{
			var currentLaserBurning:Boolean = false;
			var currentLaserFlowing:Boolean = false;
			
			super.logic();
			var positionOfActors:b2Vec2 = new b2Vec2();
			_canvas.graphics.clear();
			
			Global.world.Step(1 / 24, 10, 10); //prvi parametar: kolko sekundi je proslo u b2d svetu
			updateCamera();
			_PSE.Update();
			_SE.Update();
			_HUD.update(_player);
	
			for each(var partSys:ParticleSystem in _allParticleSystems)
			{
				if (partSys.update())
				{
					partSys.destroy();
					_allParticleSystems.splice(_allParticleSystems.indexOf(partSys), 1);
				}
			}
			
			for (var i:int = 0; i < _allActors.length; i++) 
			{
				var actor:Actor = _allActors[i];
				
				if (actor._destroy)
				{
	
					if (actor is PlayerActor)
					{
						_gameOver = true;
						_pause = true;
						return;
					}
	
					
					actor.destroy();
					_allActors.splice(i, 1);
					i--;
				/*
					if (playa)
					{
						
						_levelComplete = true;
						_pause = true;
						return;
						
						
						
						_player = null;
						_player = new PlayerActor(new b2Vec2(30, 400));
						Global.player = _player;
						_allActors.push(_player);
					}*/
				}
				else
				{	
					var leeway:Number = 300;
					var upperLimit:Number = Global.upperCameraLimit - leeway;
					var lowerLimit:Number = Global.lowerCameraLimit + leeway;
					
					if (!actor._preDestroy)
					{	
						if (actor is LaserEmiter)
						{
							if (LaserEmiter(actor).laser._end != null)
							{
								var tipPointY:Number = LaserEmiter(actor).laser._end.y * Global.RATIO;
								
								if (!( tipPointY > (lowerLimit -leeway*0.87) || tipPointY < (upperLimit  +leeway*0.87) ))
								{
									//lasertip visible
									
									if (LaserEmiter(actor).laser._burning)
									{
										currentLaserBurning = true;
										
										if (!_laserBurning)
										{
											_laserBurning = true;
											Global.GAME.laserBurnChannel = Global.GAME.LaserBurnSound.play(0, int.MAX_VALUE);
										}
									}
									else
									{
										currentLaserFlowing = true;
										
										if (!_laserFlowing)
										{
											_laserFlowing = true;
										//	Global.GAME.laserNoiseChannel = Global.GAME.LaserFlowSound.play(0, int.MAX_VALUE);
										}
									}
									
								}
							}
						}
						
						if (actor is LaserEmiter && LaserEmiter(actor).angle == Math.PI)
						{
							actor.handleKeyEvents();
							actor.update();
						}
						else
						if (actor is Bullet || actor is CannonBall || actor is SnowBallCollectible || actor is IceCubeCollectable || actor is VerticalMovingPlatform)
						{
							actor.handleKeyEvents();
							actor.update();
						}
						else
						{

							var actorY:Number;

							//actor.GetPixelPosition(positionOfActors);
							actorY = actor.GetPixelYCoord();
							
							if (actorY > (lowerLimit -leeway) || actorY < (upperLimit  +leeway) )
							{
								actor._visible = false;
							}
							else
							actor._visible = true;
							
							
							if (actorY > lowerLimit || actorY < upperLimit)
							{
								
								//actor.StopAnimation();
								if (actor._body != null)
								{	
									actor._body.SetAwake(false);
								}
								
								
								continue;
							}
							
							if (actor._body != null && !actor._body.IsAwake())
							{
								actor._body.SetAwake(true);
							}

							actor.handleKeyEvents();
							actor.update();
						}
					}
					else
						actor.preDestroyUpdating();
				}
			}
			
			if (!currentLaserBurning)
			{
				_laserBurning = false;
				if(Global.GAME.laserBurnChannel != null)
				Global.GAME.laserBurnChannel.stop();
			}
			
			if (!currentLaserFlowing)
			{
				_laserFlowing = false;
		//		if(Global.GAME.laserNoiseChannel != null)
		//		Global.GAME.laserNoiseChannel.stop();
			}
		}
		
		public function hideUnseenObjects()
		{
			var child:DisplayObject;
			for (var i:int = 0; i < _canvas.numChildren; i++ )
			{
				child = _canvas.getChildAt(i);
				
				if (child.y + child.height / 2 < Global.upperCameraLimit || child.y - child.height / 2 > Global.lowerCameraLimit)
					child.visible = false;
				else
				child.visible = true;
			}
		}
		
		private function SettupBox2D():void 
		{
			var gravity:b2Vec2 = new b2Vec2(0, 35);
			Global.world = new b2World(gravity, true /*do not simulate sleeping obj*/ );
			
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			_canvas.addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(Global.RATIO);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			Global.world.SetDebugDraw(debugDraw);
			Global.world.SetContactListener(new CustomContactListener());
		}
		
		public function addEskimoBazookaExplosion(position:b2Vec2):void
		{
			var sssps:SpotSmokePS = new SpotSmokePS(_canvas, position, 10, 0.45, 1, 0.12, 1, 1.3, 0x00ccff, 1, 5, 1.6);
			_allParticleSystems.push(sssps);
		}
		
		public function addCannonBallExplosion(position:b2Vec2, basesc:Number)
		{
			var shrpPS = new ShrapnelPS2(_canvas, new b2Vec2(0,0), 1.2*basesc, position.Copy(), 0.6);
		//	var smokePS = new ExplosionPS(_canvas, position.Copy(), 3, 1.026, 0.1, 0.7, 0.01, 0.8 , 0.3, 3, 3, 0xF87431, 11, 0.2 , 0.45,  3); 
			var smokePS = new ExplosionPS(_canvas, position, 8, 1.017, 0.1, 0.7, 0.014, 0.8 , 0.3, 1, 3, 0xF87431, 11, 0.2 , basesc,  2); 
			
			//var smokePS = new ExplosionPS(_canvas, position, 8, 1.02, 0.1, 0.7, 0.008, 0.8 ,0.3, 3, 3, 0xF87431, 11, 0.2 , basesc,  2); 
			_allParticleSystems.push(shrpPS);
			_allParticleSystems.push(smokePS);
		}
		
		public function addSnowBallExplosion(position:b2Vec2, normalVec:b2Vec2, basesc:Number):void 
		{
			var sssps:SpotSmokePS = new SpotSmokePS(_canvas, position, 10, 0.45, 1, 0.085, 1, 1, 0xffffff, 1, 5, 2.2);
			_allParticleSystems.push(sssps);
			
			var particleSys:ShrapnelPS = new ShrapnelPS(_canvas, normalVec, basesc, position);
			_allParticleSystems.push(particleSys);
		}
		
		override public function startPauseLogic():void 
		{

			
			_pauseAnimation.pauseSlide1.restartBtn1.addEventListener(MouseEvent.MOUSE_DOWN, restartLevel);
			_pauseAnimation.pauseSlide1.mainMenuBtn1.addEventListener(MouseEvent.MOUSE_DOWN, backToMainMenu);
			_pauseAnimation.pauseSlide1.resumeBtn1.addEventListener(MouseEvent.MOUSE_DOWN, backToGame);
			_pauseAnimation.pauseSlide1.soundBtn1.addEventListener(MouseEvent.MOUSE_DOWN, soundOnOffClick);
			
			for (var i:int = 0; i < _allActors.length; i++) 
			{
				var actor:Actor = _allActors[i];
				actor.StopAnimation();
				
				/*
				if (actor._body != null && !(actor is SnowBallCollectible || actor is IceCubeCollectable || actor is Bullet || actor is CannonBall || ))
					actor._body.SetAwake(false);*/
			}		
			
			if (_levelComplete)
			startLevelCompleteLogic();
			else if (_gameOver)
			gameOverStartLogic();
			else
			{
				_pauseAnimation.x = 0;
				_pauseAnimation.y = Global.upperCameraLimit;
				
				_pauseAnimation.gotoAndPlay(1);
				_canvas.addChild(_pauseAnimation);
				
				djoleReno = new MovieClip();
				
				djoleReno.x = 17;
				djoleReno.y = Global.upperCameraLimit + 70;
				_canvas.addChild(djoleReno);

			//	MochiAd.showClickAwayAd( {clip:djoleReno, id:Global.GAME._mochiads_game_id}); 
			}

			super.startPauseLogic();	
			

		}
		
		override public function endPauseLogic():void 
		{
			if(djoleReno!=null)
			djoleReno.parent.removeChild(djoleReno);

			djoleReno = null;
			
			_pauseAnimation.pauseSlide1.restartBtn1.removeEventListener(MouseEvent.MOUSE_DOWN, restartLevel);
			_pauseAnimation.pauseSlide1.mainMenuBtn1.removeEventListener(MouseEvent.MOUSE_DOWN, backToMainMenu);
			_pauseAnimation.pauseSlide1.resumeBtn1.removeEventListener(MouseEvent.MOUSE_DOWN, backToGame);
			_pauseAnimation.pauseSlide1.soundBtn1.removeEventListener(MouseEvent.MOUSE_DOWN, soundOnOffClick);
			
			for (var i:int = 0; i < _allActors.length; i++) 
			{
				var actor:Actor = _allActors[i];
				actor.Reanimate();
			}	
			
			Global.GAME.stage.focus = Global.GAME.stage;
			super.endPauseLogic();
		}

		public function startLevelCompleteLogic():void
		{
			SoundMixer.stopAll();
			Global.currentBackgroundMusic = -1;
			Global.GAME.backgroundMusicChannel = Global.GAME.LevelCompleteMusic.play();
			
			Global.levelUnlocked[Global.currentLevelIndx + 1] = true;
			updateCookie();
			
			var bd:BitmapData = new BitmapData(Global.screenWidth, Global.screenHeight);
			bd.draw(Global.GAME.stage);// , new Matrix(1, 0, 0, 1, 0, -Global.upperCameraLimit));
			screenshot = new Bitmap(bd);

			screenshot.y = Global.upperCameraLimit;
			_levelCompleteAnimation.x = Global.screenWidth/2;
			_levelCompleteAnimation.y = Global.upperCameraLimit + Global.screenHeight/2;

			_canvas.addChild(screenshot);
			_levelCompleteAnimation.gotoAndPlay(1);
			_canvas.addChild(_levelCompleteAnimation);
			
			
			////////////////////////////////
			djoleReno = new MovieClip();
			
			djoleReno.x = 327;
			djoleReno.y = Global.upperCameraLimit + 155;
			_canvas.addChild(djoleReno);

			//MochiAd.showClickAwayAd( { clip:djoleReno, id:Global.GAME._mochiads_game_id } ); 
			///////////////////////////////////////
		}
		
		public function levelCompleteLogic():void
		{
			if (_levelCompleteAnimation.currentFrame == 46)
			{
				_levelCompleteAnimation.levelCompleteSlide1.restartLvlBtn.addEventListener(MouseEvent.MOUSE_DOWN, restartLevel);
				_levelCompleteAnimation.levelCompleteSlide1.mainMenuBtn1.addEventListener(MouseEvent.MOUSE_DOWN, backToMainMenu);
				_levelCompleteAnimation.levelCompleteSlide1.nextLvlBtn1.addEventListener(MouseEvent.MOUSE_DOWN, goToNextLevel);	
			}
			
			if (_levelCompleteAnimation.currentFrame == 50)
			{
				_levelCompleteAnimation.stop();
				return;
			}
	
			_levelCBlur += _levelCBlurCrement;
			screenshot.x -= 1;
			screenshot.y -= 1;
			screenshot.scaleY = screenshot.scaleX *= 1.003;
			screenshot.filters = [new BlurFilter(_levelCBlur, _levelCBlur)];
			
			

		}
		
		
		
		private function gameOverStartLogic():void
		{
			SoundMixer.stopAll();
			Global.currentBackgroundMusic = -1;
			Global.GAME.backgroundMusicChannel = Global.GAME.GameOverMusic.play();
			
			var bd:BitmapData = new BitmapData(Global.screenWidth, Global.screenHeight);
			bd.draw(Global.GAME.stage);// , new Matrix(1, 0, 0, 1, 0, -Global.upperCameraLimit));
			screenshot = new Bitmap(bd);

			screenshot.y = Global.upperCameraLimit;
			_gameOverAnimation.x = Global.screenWidth/2;
			_gameOverAnimation.y = Global.upperCameraLimit + Global.screenHeight/2;

			_canvas.addChild(screenshot);
			_gameOverAnimation.gotoAndPlay(1);
			_canvas.addChild(_gameOverAnimation);
			
			///////////////////////////////
			djoleReno = new MovieClip();
			
			djoleReno.x = 320;
			djoleReno.y = Global.upperCameraLimit + 140;
			_canvas.addChild(djoleReno);

		//	MochiAd.showClickAwayAd( { clip:djoleReno, id:Global.GAME._mochiads_game_id } ); 
			////////////////////////////////////////////////////////////////////////////////
		}
		
		
		private function gameOverLogic():void
		{
			if (_gameOverAnimation.currentFrame == 55)
			{
				_gameOverAnimation.gameOvrSlide1.restartBtn1.addEventListener(MouseEvent.MOUSE_DOWN, restartLevel);
				_gameOverAnimation.gameOvrSlide1.mainMenuBtn1.addEventListener(MouseEvent.MOUSE_DOWN, backToMainMenu);
			}
			
			if (_gameOverAnimation.currentFrame == 70)
			{
				_gameOverAnimation.stop();
				return;
			}
	
			_levelCBlur += _levelCBlurCrement;
			screenshot.x -= 1;
			screenshot.y -= 1;
			screenshot.scaleY = screenshot.scaleX *= 1.003;
			screenshot.filters = [new BlurFilter(_levelCBlur, _levelCBlur, 3)];
		}
		
		override public function pauseLogic():void 
		{
			super.pauseLogic();

			if (_gameOver)
			{
				gameOverLogic();
				return;
			}
			
			
			if (_levelComplete)
			{
				levelCompleteLogic();
				return;
			}
			
			if (_pauseAnimation.currentFrame == 11 && !_endingPause)
			_pauseAnimation.stop();
			
			if (_pauseAnimation.currentFrame == 11 && _endingPause)
				_pauseAnimation.play();
			
			if (_pauseAnimation.currentFrame == 21)
			{	
				_canvas.removeChild(_pauseAnimation);
				_pauseAnimation.stop();
				_pause = false;

					endPauseLogic();
					_pauseCounter = 0;
				
				_endingPause = false;
			}
		}
	}
}
