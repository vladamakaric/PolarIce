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
	public class Level1 extends Level
	{
		public function Level1(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			_iceCubesToCollect = 9;
			setLevelHeightAndCreateBoundingBox(3500);
			
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
			
			
			
			
			
			
			
			var CLMAJ:CLMoveAndJump = new CLMoveAndJump();
			CLMAJ.x = 500;
			CLMAJ.y = 221;
			_canvas.addChild(CLMAJ);
			
			var CLIC:CLIceCubes = new CLIceCubes();
			CLIC.x = 180;
			CLIC.y = 360;
			_canvas.addChild(CLIC);
			
			var CLWS:CLWSpikes = new CLWSpikes();
			CLWS.x = 148;
			CLWS.y = 120;
			_canvas.addChild(CLWS);
			
			var CLHC:CLHeartCollectable = new CLHeartCollectable();
			CLHC.x = 447;
			CLHC.y = -60;
			_canvas.addChild(CLHC);
			
			
			var CLPE:CLPenquinEnemy = new CLPenquinEnemy();
			CLPE.x = 375;
			CLPE.y = -230;
			_canvas.addChild(CLPE);

			var CLPB:CLPolarBear = new CLPolarBear();
			CLPB.x = 155;
			CLPB.y = -780;
			_canvas.addChild(CLPB);
			
			var CLSB:CLSnowBalls = new CLSnowBalls();
			CLSB.x = 82;
			CLSB.y = -1223;
			_canvas.addChild(CLSB);
			
			
			var CLBP:CLBuncyPlatform = new CLBuncyPlatform();
			CLBP.x = 370;
			CLBP.y = -950;
			_canvas.addChild(CLBP);
			
			
			var CLEI:CLEskimoInfo = new CLEskimoInfo();
			CLEI.x = 424;
			CLEI.y = -1420;
			_canvas.addChild(CLEI);
			
			var CLSLB:CLSlidingBlocks = new CLSlidingBlocks();
			CLSLB.x = 400;
			CLSLB.y = -1666;
			_canvas.addChild(CLSLB);
			
			var CLLW:CLLaserWarning = new CLLaserWarning();
			CLLW.x = 500;
			CLLW.y = -1993;
			_canvas.addChild(CLLW);
			
			var CLPP:CLPressP = new CLPressP();
			CLPP.x = 580;
			CLPP.y = 460;
			_canvas.addChild(CLPP);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 460), 640, 30, 7, 0, [4,2, 2, 5,3,2,2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(412, 340), 260, 55, 3, 0, [1, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 225), 240, 35, 5, 0, [1, 2, 2, 2, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(318, 90), 140, 30, 4, 0, [1, 2, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(470, -14), 200, 50, 3, 0, [1, 2, 1, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(53, -128), 270, 60, 5, 0, [1, 2, 3, 1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(170, -410), 210, 33, 5, 0, [2, 2, 3, 1, 2]); 
			Functions.AddStaticBlockPlatform(new b2Vec2(400, -520), 100, 33, 2, 0, [1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(190, -635), 100, 33, 2, 0, [1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(336, -775), 340, 60, 6, 0, [4,2, 2,3,2,2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1000), 100, 33, 2, 0, [1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(400, -1052), 100, 33, 2, 0, [1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(500, -1185), 140, 45, 3, 0, [1, 1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(370, -1290), 100, 33, 2, 0, [1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1357), 300, 60, 6, 0, [2,4, 3, 2 ,3,2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(285, -1522), 100, 33, 2, 0, [1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(56, -1677), 190, 43, 3, 0, [2, 2,3]);
			Functions.AddStaticBlockPlatform(new b2Vec2(324, -1786), 235, 48, 3, 0, [3, 4,3]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1896), 196, 50, 3, 0, [5, 4,4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(488, -2112), 200, 50, 4, 0, [6, 5,4,6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -2370), 200, 50, 4, 0, [5, 4, 4, 6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(276, -2433), 68, 33, 2, 0, [1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(428, -2486), 68, 33, 2, 0, [1, 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(576, -2550), 68, 33, 2, 0, [1, 1]); 
			Functions.AddStaticBlockPlatform(new b2Vec2(244, -2688), 196, 52, 3, 0, [5, 4, 4]);
			///////////////////
			
			
			
			
			_allActors.push(new Cannon(new b2Vec2( 25, -1000), 56));
			_allActors.push(new SmartCannon(new b2Vec2( 25, -2370), 56));
			//////////
			_allActors.push(new BuncyPlatform(new b2Vec2(260, -870))); 
			
			/////////////////////
			_allActors.push(new VerticalMovingPlatform(-200, -400, 75, 1, new Mjalc()));
			_allActors.push(new VerticalMovingPlatform( -1984, -2092, 410, 1, new Mjalc()));
			_allActors.push(new VerticalMovingPlatform(-1984, -2092, 280, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform(150, 530, -2262, 1, new Mjalc(), 211));
			/////////////////////
			
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(80, 432)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(144, 432)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(216, 432)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(394, 39)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(448, -570)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(575, -1224)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(290, -2800)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(350, -2800)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(410, -2800)));
			////////////////////////////
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(205, -1263)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(249, -1258)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(298, -1265)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(249, -1223)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(205, -1221)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(298, -1225)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(249, -1173)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(298, -1171)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(205, -1175)));
			////
			
			_allActors.push(new HeartCollectible(new b2Vec2(587, -47)));
			_allActors.push(new HeartCollectible(new b2Vec2(77, -447)));
			_allActors.push(new HeartCollectible(new b2Vec2(245, -666)));
			_allActors.push(new HeartCollectible(new b2Vec2(452, -1082)));
			_allActors.push(new HeartCollectible(new b2Vec2(422, -1319)));
			_allActors.push(new HeartCollectible(new b2Vec2(340, -1548)));
			_allActors.push(new HeartCollectible(new b2Vec2(50, -1984)));
			_allActors.push(new HeartCollectible(new b2Vec2(540, -2146)));
			_allActors.push(new HeartCollectible(new b2Vec2(600, -2146)));
			////////
			
			
			
			
			_allActors.push(new SpikeStrip(new b2Vec2(0, 183), 77 , 42, SpikeStrip.UP, 100)); 
			
			
			
			////////////////////
			
			_allActors.push(new PushingEnemy(new b2Vec2(158, -1718), 50, 80, 8, 9)); 
			_allActors.push(new PushingEnemy(new b2Vec2(508, -1822), 110, 45, 8, 9)); 
			
			
			///////////////////
			_allActors.push(new BasicEnemy(new b2Vec2(160, -160)));
			_allActors.push(new BasicEnemy(new b2Vec2(238, -433)));
			_allActors.push(new BasicEnemy(new b2Vec2(300, -433)));
			_allActors.push(new BasicEnemy(new b2Vec2(360, -433)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(140, -1949)));
			_allActors.push(new BasicEnemy(new b2Vec2(240, -2290)));
			
			_allActors.push(new MediumEnemy(new b2Vec2(467, -817)));
			_allActors.push(new MediumEnemy(new b2Vec2(315, -2717)));
			
			_allActors.push(new HardEnemy(new b2Vec2(138, -1383)));
			_allActors.push(new BasicEnemy(new b2Vec2(73, -2413)));
			//////////////////////
			
			_allActors.push(new LaserEmiter(new b2Vec2(488, -2091), LaserEmiter.LEFT, -Math.PI/2));
			
		/*	
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

			_allActors.push(new LaserEmiter(new b2Vec2(320, 350), LaserEmiter.UP, Math.PI*2 - 0.5));
			
			

			//_allActors.push(new LaserEmiter(new b2Vec2(400, 400), LaserEmiter.DOWN, Math.PI));
			
			//_allActors.push(new LaserEmiter(new b2Vec2(0, 250), LaserEmiter.RIGHT, Math.PI/2));
			
			_allActors.push(new LaserEmiter(new b2Vec2(Global.stage.stageWidth, -20), LaserEmiter.LEFT, Math.PI * 1.5));
*/
			
			if (Global.currentBackgroundMusic != Global.TIER1MUSIC)
			{
				Global.currentBackgroundMusic = Global.TIER1MUSIC;
				Global.GAME.backgroundMusicChannel.stop();
				Global.GAME.backgroundMusicChannel = Global.GAME.Tier1Music.play(0, int.MAX_VALUE);
			}

			

			postConstruction();
		}
	}
}