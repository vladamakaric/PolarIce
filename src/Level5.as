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
	 * @author Anaximen
	 */
	
	public class Level5 extends Level
	{
		public function Level5(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			_playerPos.Set(36, 300);
			
			_iceCubesToCollect = 6;
			setLevelHeightAndCreateBoundingBox(2570);
			
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
			
			_allActors.push(new BuncyPlatform(new b2Vec2(610, -834)));
			_allActors.push(new BuncyPlatform(new b2Vec2(515, -1090)));
			_allActors.push(new BuncyPlatform(new b2Vec2(610, -1332)));
			_allActors.push(new BuncyPlatform(new b2Vec2(515, -1556)));
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 345), 130, 75, 2, 0, [3, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(188, 345), 108, 85, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(360, 345), 100, 85, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(527, 345), 140, 85, 2, 0, [7, 6]);
			Functions.AddStaticBlockPlatform(new b2Vec2( -20, 410), 680, 70, 10, 0, [10, 9, 11, 8, 7, 12, 9, 12, 4, 8]);
			
			_allActors.push(new Cannon(new b2Vec2( 586, 345), -83, 30));
			_allActors.push(new SmartCannon(new b2Vec2( 235, -1069), 50));
			_allActors.push(new SmartCannon(new b2Vec2( 235, -1361), 50));
 
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(380, 150), 110, 44, 2, 0, [2, 3]);
			
			
			
			
			
			_allActors.push(new SpikeStrip(new b2Vec2(0, 145), 381, 45, SpikeStrip.UP, 100));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 190), 540, 50, 6, 0, [7, 9, 12, 4, 8, 10]);
			
			
			
			
			
			
			
			
			_allActors.push(new PushingEnemy(new b2Vec2(155, -1507), 37, 66, 11, 12)); 
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 65), 100, 40, 2, 0, [2, 2]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -200), 100, 40, 2, 0, [2,2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -452), 400, 50, 6, 0, [10, 9, 7, 12, 4, 8]);
			Functions.AddStaticBlockPlatform(new b2Vec2(40, -587), 100, 40, 2, 0, [2,2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(40, -851), 100, 40, 2, 0, [2,2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(162, -722), 100, 40, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(285, -854), 100, 40, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(285, -587), 100, 40, 2, 0, [2, 2]);
			
			
			
			
			
			_allActors.push(new SpikeStrip(new b2Vec2(0, -1072), 197, 48, SpikeStrip.UP, 100));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(197, -1069), 103, 47, 2, 0, [2,2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1024), 300, 50, 4, 0, [9, 7, 4, 8]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1164), 90, 50, 2, 0, [5, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1315), 43, 46, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1653), 43, 46, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(80, -1471), 117, 50, 3, 0, [3, 5, 4]);
			
			
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(218, -1361), 74, 40, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(570, -1806), 74, 40, 2, 0, [2, 2]);
			
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2(87, -1806), 250, 60, 4, 0, [ 9, 7, 4, 8]);
			
			
			
			
			
			_allActors.push(new VerticalMovingPlatform(78, -185, 233, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform( 360, 560, -273, 1, new Mjalc(), 360));
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(450, 125)));
			_allActors.push(new BasicEnemy(new b2Vec2(30, 30)));
			_allActors.push(new BasicEnemy(new b2Vec2(355, -308)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(90, -610)));
			_allActors.push(new BasicEnemy(new b2Vec2(328, -610)));
			_allActors.push(new BasicEnemy(new b2Vec2(90, -873)));
			_allActors.push(new BasicEnemy(new b2Vec2(328, -873)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(20, -1340)));
			_allActors.push(new BasicEnemy(new b2Vec2(20, -1680)));
			_allActors.push(new BasicEnemy(new b2Vec2(200, -1834)));
			//_allActors.push(new BasicEnemy(new b2Vec2(170, -1834)));
			//_allActors.push(new BasicEnemy(new b2Vec2(230, -1834)));
			
			
			_allActors.push(new HardEnemy(new b2Vec2(61, -1188)));
			_allActors.push(new LaserEmiter(new b2Vec2(208, -1746), LaserEmiter.DOWN,  Math.PI , 0.1));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(525, 44)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(400, 44)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(437, -13)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(492, -13)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(35, -910)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(85, -910)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(135, -910)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(35, -955)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(85, -955)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(135, -955)));
			
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(326, 371)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(52, -17)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(215, -766)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(16, -1239)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(128, -1584)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(606, -1867)));
			
			
			_allActors.push(new HeartCollectible(new b2Vec2(606, -1830)));
			_allActors.push(new HeartCollectible(new b2Vec2(92, -662)));
			
			
			/*
			_allActors.push(new VerticalMovingPlatform(-640, -830, 82, 1, new Mjalc()));
			_allActors.push(new VerticalMovingPlatform(-640, -830, 566, 1, new Mjalc()));
			_allActors.push(new VerticalMovingPlatform(172, 106, 572, 1, new Mjalc()));
			
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(344, -1030), 85, 35, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(234, -1165), 85, 35, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(344, -1318), 85, 35, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(234, -900), 85, 35, 2, 0, [2, 2]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(554, -950), 85, 40, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -950), 85, 40, 2, 0, [2, 2]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(195, -1448), 100, 40, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(366, -1448), 100, 40, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1607), 85, 40, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(541, -1607), 100, 40, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(196, -1765), 265, 60, 5, 0, [4, 5, 4, 3, 6]);
			//232, 
			
			Functions.AddStaticBlockPlatform(new b2Vec2(150, -1992), 158, 42, 3, 0, [6, 4, 5]);
			
			
			_allActors.push(new SpikeStrip(new b2Vec2(154, -1950), 151, 27, SpikeStrip.DOWN, 100)); 
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(363, -1992), 158, 42, 4, 0, [4, 6, 4, 5]);
			
			
			_allActors.push(new SpikeStrip(new b2Vec2(367, -1950), 151, 27, SpikeStrip.DOWN, 100));
			
			
			
			
			_allActors.push(new SmartCannon(new b2Vec2( 20, -1995), 50));
			_allActors.push(new Cannon(new b2Vec2( 20, -950), 86));
			_allActors.push(new Cannon(new b2Vec2( 620, -950), -86));
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -2327), 158, 42, 2, 0, [4, 6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(257, -2462), 158, 42, 4, 0, [5, 4, 6, 8]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -2140), 61, 43, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(580, -2140), 61, 43, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1995), 61, 43, 1, 0, [1]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1995), 61, 43, 1, 0, [1]);
			
			_allActors.push(new HorizontalMovingPlatform( 233, 465, -2226, 1, new Mjalc()));
			

			_allActors.push(new PushingEnemy(new b2Vec2(570, 293), 42, 61, 11, 12)); 
			_allActors.push(new PushingEnemy(new b2Vec2(290, -875), 72, 62, 11, 12));
			_allActors.push(new PushingEnemy(new b2Vec2(334, -1812), 75, 87, 11, 12));
			
			_allActors.push(new LaserEmiter(new b2Vec2(0, -1435), LaserEmiter.RIGHT,  Math.PI / 2, 1));
			
			_allActors.push(new LaserEmiter(new b2Vec2(640, -1435), LaserEmiter.LEFT,  -Math.PI / 2, 1));
			
			_allActors.push(new LaserEmiter(new b2Vec2(212, -1408), LaserEmiter.DOWN,  Math.PI , 0.1));
			_allActors.push(new LaserEmiter(new b2Vec2(450, -1408), LaserEmiter.DOWN,  Math.PI ,  0.1));
			
			
			
			
			
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(36, 230)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(36, 170)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(36, 110)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(329, -400)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(329, -460)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(329, -520)));
			
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(333, -1580)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(333, -1615)));
			
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(535, 235)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(22, -600)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(333, -1423)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(333, -1973)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(341, -2507)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(30, -2170)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(30, -2406)));
			
			
			_allActors.push(new HeartCollectible(new b2Vec2(616, -584)));
			_allActors.push(new HeartCollectible(new b2Vec2(333, -1541)));
			_allActors.push(new HeartCollectible(new b2Vec2(608, -2168)));
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(208, 150)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(380, 4)));
			_allActors.push(new BasicEnemy(new b2Vec2(524, -153)));
			_allActors.push(new BasicEnemy(new b2Vec2(92, -531)));
			_allActors.push(new BasicEnemy(new b2Vec2(192, -531)));
			_allActors.push(new MediumEnemy(new b2Vec2(140, -531)));
			_allActors.push(new HardEnemy(new b2Vec2(520, -531)));
			
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(380, -1050)));
			_allActors.push(new BasicEnemy(new b2Vec2(380, -1333)));
			_allActors.push(new BasicEnemy(new b2Vec2(262, -1187)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(60, -1627)));
			_allActors.push(new BasicEnemy(new b2Vec2(592, -1627)));
			_allActors.push(new BasicEnemy(new b2Vec2(400, -2012)));
			_allActors.push(new BasicEnemy(new b2Vec2(420, -2012)));
			_allActors.push(new BasicEnemy(new b2Vec2(440, -2012)));
			_allActors.push(new MediumEnemy(new b2Vec2(231, -2012)));
			_allActors.push(new HardEnemy(new b2Vec2(120, -2352)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(300, -2484)));
			_allActors.push(new BasicEnemy(new b2Vec2(350, -2484)));
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