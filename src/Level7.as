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
	public class Level7 extends Level
	{
		public function Level7(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			_iceCubesToCollect = 7;
			setLevelHeightAndCreateBoundingBox(3100);
			
			var PL1:Sprite = new SkyBG2();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL1, new b2Vec2(0, Global.screenHeight), - (_height - Global.screenHeight) + PL1.height));
			
			
			var SUN1:Sprite = new Sunce2();
			_PSE.addNewParallaxLayer(new ParallaxLayer(SUN1, new b2Vec2(130, 70), - (_height - Global.screenHeight) + 370));
			
			
			var PL4:Sprite = new SmallMountainsS2();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL4, new b2Vec2(100, Global.screenHeight +40), - (_height - Global.screenHeight) + PL4.height + 300));
			
		
			var PL3:Sprite = new MMSP2();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL3, new b2Vec2(0, Global.screenHeight), - (_height - Global.screenHeight) + PL3.height + 390));
			
			var PL2:Sprite = new BMSP2();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL2, new b2Vec2(0, Global.screenHeight), - (_height - Global.screenHeight) + PL2.height*2.35));
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 440), 300, 50, 4, 0, [2,3,5,4]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(208, 386), 465, 110, 7, 0, [5, 6, 4,5,5,7,6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(313, 144), 105, 33, 2, 0, [5, 6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(434, 61), 160, 43, 3, 0, [5, 7, 6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -165), 400, 60, 6, 0, [4, 6, 5, 5, 4, 7]);
			Functions.AddStaticBlockPlatform(new b2Vec2(190, -340), 500, 30, 6, 0, [5, 4, 5,7,4,7]);
			Functions.AddStaticBlockPlatform(new b2Vec2(312, -530), 200, 35, 4, 0, [3, 4, 5, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(100, -647), 110, 33, 2, 0, [7, 8]);
			Functions.AddStaticBlockPlatform(new b2Vec2(308, -793), 220, 39, 3, 0, [9, 7, 10]);
			Functions.AddStaticBlockPlatform(new b2Vec2( -20, -910), 210, 47, 4, 0, [9, 7, 10, 8]);
			Functions.AddStaticBlockPlatform(new b2Vec2( -20, 224), 250, 43, 4, 0, [9, 7, 10, 8]);
			Functions.AddStaticBlockPlatform(new b2Vec2(330, -1050), 340, 46, 4, 0, [3, 4, 5, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(84, -1187), 110, 36, 2, 0, [7, 8]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(151, -1936), 520, 40, 8, 0, [7, 8,8,6,9,6,7,8]);
			Functions.AddStaticBlockPlatform(new b2Vec2(424, -2043), 55, 45, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(294, -2120), 55, 45, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(173, -2230), 55, 45, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(306, -2319), 55, 45, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(510, -2319), 55, 45, 1, 0, [1]);
			
			
			
			
			
			/////////////////////
			_allActors.push(new VerticalMovingPlatform(-1262, -1450, 90, 1, new Mjalc(), -1290));
			_allActors.push(new VerticalMovingPlatform(-1360, -1520, 245, 1, new Mjalc(), -1450));
			_allActors.push(new VerticalMovingPlatform(-1430, -1590, 400, 1, new Mjalc(), -1590));
			_allActors.push(new VerticalMovingPlatform( -1500, -1660, 555, 1, new Mjalc(), -1600));
			
			_allActors.push(new BasicEnemy(new b2Vec2(90, -1310)));
			_allActors.push(new BasicEnemy(new b2Vec2(245, -1470)));
			_allActors.push(new BasicEnemy(new b2Vec2(400, -1610)));
			_allActors.push(new BasicEnemy(new b2Vec2(555, -1630)));
			
			
			_allActors.push(new HorizontalMovingPlatform(90, 410, -1800, 1, new Mjalc()));
			
			
			
			
			_allActors.push(new PushingEnemy(new b2Vec2(521, 13), 60, 90, 10, 11)); 
			
			_allActors.push(new PushingEnemy(new b2Vec2(405, -582), 45, 95, 9, 10)); 

			
			 
			_allActors.push(new HeartCollectible(new b2Vec2(257, -200)));
			_allActors.push(new HeartCollectible(new b2Vec2(400, -723)));
			_allActors.push(new HeartCollectible(new b2Vec2(146, -1230)));
			_allActors.push(new HeartCollectible(new b2Vec2(400, -1710)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(530, -245)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(580, -245)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(556, -205)));
			
			_allActors.push(new SpikeStrip(new b2Vec2(300, -234), 40, 69, SpikeStrip.UP, 100)); 
			_allActors.push(new SpikeStrip(new b2Vec2(193,-234), 40, 69, SpikeStrip.UP, 100)); 
			
			_allActors.push(new SmartCannon(new b2Vec2( 32, 224), 56));
			_allActors.push(new Cannon(new b2Vec2( 32, -165), 80));
			
			_allActors.push(new LaserEmiter(new b2Vec2(0, -510), LaserEmiter.RIGHT, Math.PI/2));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(590, 286)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(582, -1165)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(171, -686)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(243, -1719)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(203, -2329)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(432, -2470)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(600, -2470)));
			
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(304, 364)));
			
			_allActors.push(new MediumEnemy(new b2Vec2(360, 364)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(360, 364)));
			_allActors.push(new BasicEnemy(new b2Vec2(400, 364)));
			_allActors.push(new BasicEnemy(new b2Vec2(440, 364)));
			_allActors.push(new BasicEnemy(new b2Vec2(480, 364)));
			_allActors.push(new BasicEnemy(new b2Vec2(520, 364)));
			_allActors.push(new BasicEnemy(new b2Vec2(366, 122)));
			
			_allActors.push(new HardEnemy(new b2Vec2(345, -363)));
			_allActors.push(new MediumEnemy(new b2Vec2(421, -824)));
			_allActors.push(new BasicEnemy(new b2Vec2(451, -824)));
			_allActors.push(new MediumEnemy(new b2Vec2(95, -941)));
			_allActors.push(new BasicEnemy(new b2Vec2(369, -1076)));
			_allActors.push(new MediumEnemy(new b2Vec2(409, -1076)));
			_allActors.push(new BasicEnemy(new b2Vec2(450, -1076)));
			_allActors.push(new BasicEnemy(new b2Vec2(480, -1076)));
			//576, -236
			/*
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
			
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(80, 439)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(144, 439)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(216, 439)));
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
			*/
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
			
			if (Global.currentBackgroundMusic != Global.TIER2MUSIC)
			{
				Global.currentBackgroundMusic = Global.TIER2MUSIC;
				Global.GAME.backgroundMusicChannel.stop();
				Global.GAME.backgroundMusicChannel = Global.GAME.Tier2Music.play(0, int.MAX_VALUE);
			}

			postConstruction();
		}
	}
}