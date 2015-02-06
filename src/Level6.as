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
	
	public class Level6 extends Level
	{
		public function Level6(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			_playerPos.Set(34, 290);
			
			_iceCubesToCollect = 7;
			setLevelHeightAndCreateBoundingBox(3240);
			
			var PL1:Sprite = new SkyBG3();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL1, new b2Vec2(0, Global.screenHeight), - (_height - Global.screenHeight) + PL1.height));
			
			var SUN1:Sprite = new Mesec1();
			_PSE.addNewParallaxLayer(new ParallaxLayer(SUN1, new b2Vec2(180, 100), - (_height - Global.screenHeight) + 250));
			
			var PL4:Sprite = new SmallMountainsS3();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL4, new b2Vec2(100, Global.screenHeight +40), - (_height - Global.screenHeight) + PL4.height + 300));
			
			var PL3:Sprite = new MMSP3();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL3, new b2Vec2(0, Global.screenHeight), - (_height - Global.screenHeight) + PL3.height + 390));
			
			var PL2:Sprite = new BMSP3();
			_PSE.addNewParallaxLayer(new ParallaxLayer(PL2, new b2Vec2(0, Global.screenHeight), - (_height - Global.screenHeight) + PL2.height*2.35));
			
			_allActors.push(new BuncyPlatform(new b2Vec2(330, -235)));
			
			
			_allActors.push(new SpikeStrip(new b2Vec2(100, 410), 605, 70, SpikeStrip.UP, 100)); 
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 345), 100, 140, 2, 0, [3, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(168, 171), 90, 90, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(332, 25), 90, 90, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(487, -131), 90, 90, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -510), 250, 40, 6, 0, [5, 6, 4, 7, 8, 5]);
			Functions.AddStaticBlockPlatform(new b2Vec2(390, -510), 260, 40, 5, 0, [5, 4, 7, 3, 5]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(450, 327), 140, 30, 3, 0, [4, 5, 3]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(196, -734), 265, 60, 5, 0, [4, 5, 4, 3, 6]);
			
			
			
			
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
			
			
			if (Global.currentBackgroundMusic != Global.TIER3MUSIC)
			{
				Global.currentBackgroundMusic = Global.TIER3MUSIC;
				Global.GAME.backgroundMusicChannel.stop();
				Global.GAME.backgroundMusicChannel = Global.GAME.Tier3Music.play(0, int.MAX_VALUE);
			}
			
			postConstruction();
		}
	}
}