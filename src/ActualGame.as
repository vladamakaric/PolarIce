package  
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class ActualGame extends Level
	{

		
		private var PINGVIN = false;

		private var MEDJED = false;

		private var ESKIM = false;

		private var LJAD = false;
		private var LJAD2 = false;

		private var BAUNSDATASS = false;
		
		private var HEARTC = false;
		private var SNOWBC = false;
		private var ICECC = false;
		
		public function ActualGame(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			_iceCubesToCollect = 9;
			setLevelHeightAndCreateBoundingBox(3000);
			
			/*
			var PL1:Sprite = new SkyBG();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL1, new b2Vec2(0, Global.screenHeight), - (_height - Global.screenHeight) + PL1.height));
			
			
			var SUN1:Sprite = new Sunce1();
			_PSE.addNewParallaxLayer(new ParallaxLayer(SUN1, new b2Vec2(100, 100), - (_height - Global.screenHeight) + 250));
			
			
			var PL4:Sprite = new SmallMountainsS1();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL4, new b2Vec2(100, Global.screenHeight +40), - (_height - Global.screenHeight) + PL4.height + 300));
			
		
			var PL3:Sprite = new MMSP1();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL3, new b2Vec2(0, Global.screenHeight), - (_height - Global.screenHeight) + PL3.height + 390));
			
			var PL2:Sprite = new BMSP1();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL2, new b2Vec2(0, Global.screenHeight), - (_height - Global.screenHeight) + PL2.height*2.35));
			*/
			
			_allActors.push(new VerticalMovingPlatform(400, 0, 530, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform(10, 400, -300, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform(10, 400, -400, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform(10, 400, -500, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform(10, 400, -600, 1, new Mjalc()));
			_allActors.push(new HardEnemy(new b2Vec2(240, 100)));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 350), 420, 50, 6, 0,  [2, 2, 3 , 2,  3, 1]);
			
			_allActors.push(new SmartCannon(new b2Vec2(50, 350), 80));
			//_allActors.push(new SmartCannon(new b2Vec2(550, 350), -80));
			Functions.AddStaticBlockPlatform(new b2Vec2(200, 130), 260, 60, 5, 0,  [2, 2, 3, 2,1]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(350, 20), 120, 40, 2, 0,  [2, 2, 3, 4]);
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2(0, -190), 200, 60, 1, 0,  [2, 2, 3, 1]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(330, -650), 270, 30, 4, 0,  [2, 2, 3, 4]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -750), 100, 40, 2, 0,  [2, 2, 3, 1]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(200, -850), 100, 40, 2, 0,  [2, 2, 3, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(400, -950), 200, 60, 4, 0,  [2, 2, 3, 1]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1100), 250, 20, 4, 0,  [2, 2, 3, 1]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(400, -1200), 240, 20, 5, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1340), 140, 50, 3, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(200, -1500), 140, 20, 2, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(400, -1700), 240, 20, 5, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(200, -1870), 140, 20, 2, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -2040), 140, 50, 5, 0,  [2, 2, 3, 1, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(200, -2170), 140, 20, 2, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(400, -2300), 240, 20, 5, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(200, -2420), 200, 50, 3, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -2540), 200, 30, 2, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(400, -2700), 240, 20, 5, 0,  [2, 2, 3, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(200, -2850), 240, 50, 5, 0,  [2, 2, 3, 1, 2]);
			
			_allActors.push(new SpikeStrip(new b2Vec2(290, 190), 100, 50 , SpikeStrip.DOWN, 100)); 
			_allActors.push(new SpikeStrip(new b2Vec2(100, 290), 200 , 60, SpikeStrip.UP, 100)); 
			
			_allActors.push(new SpikeStrip(new b2Vec2(600, 190), 40, 100 , SpikeStrip.LEFT, 100)); 
			_allActors.push(new SpikeStrip(new b2Vec2(0, 90), 70, 130 , SpikeStrip.RIGHT, 100)); 
			
			
			Global.stage.addEventListener(MouseEvent.CLICK, mouseClick);
			Global.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress );
			Global.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease );
			Global.stage.addEventListener(MouseEvent.MOUSE_MOVE, mousePosition);
			
			
			
			
			
			_allActors.push(new LaserEmiter(new b2Vec2(320, 350), LaserEmiter.UP, Math.PI*2 - 0.5));
			
			

			//_allActors.push(new LaserEmiter(new b2Vec2(400, 400), LaserEmiter.DOWN, Math.PI));
			
			//_allActors.push(new LaserEmiter(new b2Vec2(0, 250), LaserEmiter.RIGHT, Math.PI/2));
			
			_allActors.push(new LaserEmiter(new b2Vec2(Global.stage.stageWidth, -20), LaserEmiter.LEFT, Math.PI * 1.5));
			
			
			
			
			postConstruction();
		}
		
		override public function destroy():void 
		{	
			Global.stage.removeEventListener(MouseEvent.CLICK, mouseClick);
			Global.stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyPress );
			Global.stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyRelease );
			Global.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mousePosition);
			super.destroy();

		}
		
		private function mousePosition(e:MouseEvent):void 
		{

		}
		
		private function onKeyRelease(keyboardEvent:KeyboardEvent):void 
		{
			if ( keyboardEvent.keyCode == Keyboard.Q )
				PINGVIN = false;
			else if ( keyboardEvent.keyCode == Keyboard.W )
				MEDJED = false;
			else if ( keyboardEvent.keyCode == Keyboard.E )
				ESKIM = false;
			else if ( keyboardEvent.keyCode == Keyboard.R )
				LJAD = false;
			else if ( keyboardEvent.keyCode == Keyboard.T )
				LJAD2 = false;
			else if ( keyboardEvent.keyCode == Keyboard.Y )
				BAUNSDATASS = false;
			else if ( keyboardEvent.keyCode == Keyboard.U )
				SNOWBC = false;
			else if ( keyboardEvent.keyCode == Keyboard.I )
				HEARTC = false;
			else if ( keyboardEvent.keyCode == Keyboard.O )
				ICECC = false;
		}
		
		private function onKeyPress(keyboardEvent:KeyboardEvent):void 
		{
			if ( keyboardEvent.keyCode == Keyboard.Q )
				PINGVIN = true;
			else if ( keyboardEvent.keyCode == Keyboard.W )
				MEDJED = true;
			else if ( keyboardEvent.keyCode == Keyboard.E )
				ESKIM = true;
			else if ( keyboardEvent.keyCode == Keyboard.R )
				LJAD = true;
			else if ( keyboardEvent.keyCode == Keyboard.T )
				LJAD2 = true;
			else if ( keyboardEvent.keyCode == Keyboard.Y )
				BAUNSDATASS = true;
			else if ( keyboardEvent.keyCode == Keyboard.U )
				SNOWBC = true;
			else if ( keyboardEvent.keyCode == Keyboard.I )
				HEARTC = true;
			else if ( keyboardEvent.keyCode == Keyboard.O )
				ICECC = true;
		}
		
		private function mouseClick(e:MouseEvent):void 
		{
			/*
			var mcShit:CLtesting = new CLtesting();
			mcShit.x = e.stageX;
			mcShit.y = e.stageY - _canvas.y;
			Global.gameCanvas.addChild(mcShit);*/
			
			//_player._health++;
			
			/*
			var mcShit:MovieClip = new IceCubeBig();
			mcShit.x = e.stageX;
			mcShit.y = e.stageY - _canvas.y;
			Global.gameCanvas.addChild(mcShit);*/
		
		//_allActors.push(new IceCubeCollectable(new b2Vec2(e.stageX + 100, e.stageY - _canvas.y)));
		//_allActors.push(new IceCubeCollectable(new b2Vec2(e.stageX, e.stageY - _canvas.y)));
		//addCannonBallExplosion(new b2Vec2(e.stageX, e.stageY - _canvas.y), 1); 
		
		if(PINGVIN)
			_allActors.push(new BasicEnemy(new b2Vec2(e.stageX, e.stageY - _canvas.y))); 
			else
		if(MEDJED)
			_allActors.push(new MediumEnemy(new b2Vec2(e.stageX, e.stageY - _canvas.y))); 
			else		
		if(ESKIM)
			_allActors.push(new HardEnemy(new b2Vec2(e.stageX, e.stageY - _canvas.y))); 
			else			
		if(LJAD)
			_allActors.push(new PushingEnemy(new b2Vec2(e.stageX, e.stageY - _canvas.y), 50,50, 10, 20)); 
			else
		if(LJAD2)
			_allActors.push(new PushingEnemy(new b2Vec2(e.stageX, e.stageY - _canvas.y), 110,110, 4, 8));
			else	
		if(BAUNSDATASS)
			_allActors.push(new BuncyPlatform(new b2Vec2(e.stageX, e.stageY - _canvas.y))); 
			else
		if (HEARTC)
			_allActors.push(new HeartCollectible(new b2Vec2(e.stageX, e.stageY - _canvas.y)));
			else
		if (ICECC)
			_allActors.push(new IceCubeCollectable(new b2Vec2(e.stageX, e.stageY - _canvas.y)));
			else
		if (SNOWBC)
			_allActors.push(new SnowBallCollectible(new b2Vec2(e.stageX, e.stageY - _canvas.y)));
			
		//	else
		//	_player._body.SetPosition(new b2Vec2(e.stageX/Global.RATIO, (e.stageY - _canvas.y)/Global.RATIO));
		
			//_allActors.push(new BasicEnemy(new b2Vec2(e.stageX, e.stageY - _canvas.y))); 
			//else
		//	_allActors.push(new MediumEnemy(new b2Vec2(e.stageX, e.stageY - _canvas.y))); 
		}
		

	}
}