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
	public class Level9 extends Level
	{
		public function Level9(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			
			_playerPos.Set(33, 300);
			
			_iceCubesToCollect = 8;
			setLevelHeightAndCreateBoundingBox(3170);
			
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
			
			_allActors.push(new BuncyPlatform(new b2Vec2(606, -736)));
			
			
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 370), 218, 115, 3, 0, [3,4, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(396, 413), 318, 80, 4, 0, [3, 2 , 4, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 195), 85, 30, 2, 0, [3,2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 0), 220, 60, 4, 0, [6, 7 , 5, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(422, -190), 270, 55, 4, 0, [7, 6 , 6, 5]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -340), 60, 65, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -290), 210, 46, 3, 0, [4, 6 , 5]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -485), 55, 35, 1, 0, [1]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2(420, -505), 140, 40, 4, 0, [1,2,3,2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2(76, -625), 143, 37, 3, 0, [1, 3, 2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2(421, -723), 243, 43, 5, 0, [6, 4, 5, 6, 5]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -800), 60, 38, 1, 0, [1]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(63, -950), 160, 37, 4, 0, [7, 6 , 6, 5]);
			Functions.AddStaticBlockPlatform(new b2Vec2(65, -1200), 164, 39, 3, 0, [5, 6 , 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(539, -1228), 145, 45, 2, 0, [5, 6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1433), 210, 46, 3, 0, [4, 6 , 5]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(587, -1530), 60, 38, 1, 0, [1]); // top
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -1590), 60, 45, 1, 0, [1]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(583, -1854), 60, 40, 2, 0, [6,7]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(445, -1960), 64, 42, 2, 0, [7, 7]);
			Functions.AddStaticBlockPlatform(new b2Vec2(443, -2143), 61, 39, 1, 0, [1]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(583, -2050), 60, 45, 2, 0, [8,7]);
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2(0, -2140), 243, 43, 5, 0, [6, 4, 5, 6, 5]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(96, -2400), 140, 55, 2, 0, [8, 7]);
			Functions.AddStaticBlockPlatform(new b2Vec2(411, -2400), 142, 55, 2, 0, [5, 7]);
			
			_allActors.push(new SpikeStrip(new b2Vec2(218, 418), 178, 62, SpikeStrip.UP, 100)); 
			_allActors.push(new SpikeStrip(new b2Vec2(60, -330), 120, 40, SpikeStrip.UP, 100)); 
			
			
			_allActors.push(new VerticalMovingPlatform(313, 47, 513, 1, new Mjalc()));
			_allActors.push(new VerticalMovingPlatform(-850, -1363, 465, 1, new Mjalc()));
			
			
			_allActors.push(new HorizontalMovingPlatform(52, 190, -1713, 1, new Mjalc(), 189));
			_allActors.push(new HorizontalMovingPlatform(460, 585, -1713, 1, new Mjalc(), 461));
			
			
			
			_allActors.push(new BuncyPlatform(new b2Vec2(606, -307)));
			
			_allActors.push(new BuncyPlatform(new b2Vec2(606, -2246)));
			_allActors.push(new BuncyPlatform(new b2Vec2(35, -2246)));
			
			
			
			
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(25, 85)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(28, -508)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(307, -780)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(25, -1090)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(25, -1200)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(25, -1310)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(320, -1910)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(320, -2565)));
			
			
			////////////
			
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(281, 201)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(320, 201)));
			
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(568, -1250)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(613, -1250)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(593, -1284)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(612, -1872)));
			
			
			_allActors.push(new HeartCollectible(new b2Vec2(30, -863)));
			_allActors.push(new HeartCollectible(new b2Vec2(30, -1620)));
			_allActors.push(new HeartCollectible(new b2Vec2(613, -2077)));
			
			
			
			
			///////////
			_allActors.push(new BasicEnemy(new b2Vec2(22, 170)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(142, -647)));
			_allActors.push(new BasicEnemy(new b2Vec2(8, -820)));
			_allActors.push(new BasicEnemy(new b2Vec2(30, -820)));
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(117, -1065)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(197, -1749)));
			_allActors.push(new BasicEnemy(new b2Vec2(454, -1749)));
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(475, -1983)));
			_allActors.push(new BasicEnemy(new b2Vec2(475, -2163)));	
			_allActors.push(new BasicEnemy(new b2Vec2(25, -2165)));
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(426, -2420)));
			_allActors.push(new BasicEnemy(new b2Vec2(456, -2420)));
			_allActors.push(new BasicEnemy(new b2Vec2(487, -2420)));
			_allActors.push(new BasicEnemy(new b2Vec2(500, -2420)));

			_allActors.push(new PushingEnemy(new b2Vec2(118, -996), 52, 90, 10, 11));
			_allActors.push(new PushingEnemy(new b2Vec2(145, -1251), 60, 100, 9, 10)); 
			_allActors.push(new PushingEnemy(new b2Vec2(180, -2424), 55, 55, 12, 13)); 
			
			
			_allActors.push(new SmartCannon(new b2Vec2( 22, -340), 56));
			_allActors.push(new SmartCannon(new b2Vec2( 610, -1530), -56));
			
			
			_allActors.push(new Cannon(new b2Vec2( 25, 0), 90 - 14));
			
			
			
			_allActors.push(new MediumEnemy(new b2Vec2(102, -2170)));
			_allActors.push(new MediumEnemy(new b2Vec2(470, 380)));
			
			
			
			_allActors.push(new HardEnemy(new b2Vec2(38, -1460)));
			_allActors.push(new HardEnemy(new b2Vec2(534, -316)));
			
			_allActors.push(new LaserEmiter(new b2Vec2(223, -933), LaserEmiter.RIGHT, Math.PI / 2, 0.05 ));
			
		//	_allActors.push(new IceCubeCollectable(new b2Vec2(135, 1290)));
			///////////////////
/*
			_allActors.push(new Cannon(new b2Vec2( 620, -600), -60));
			
			//_allActors.push(new SmartCannon(new b2Vec2( 25, -2370), 56));
			//////////
			_allActors.push(new BuncyPlatform(new b2Vec2(44, -305))); 
			
			/////////////////////
			//_allActors.push(new VerticalMovingPlatform(-200, -400, 75, 1, new Mjalc()));

			_allActors.push(new HorizontalMovingPlatform(115, 550, -250, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform(150, 470, -350, 1, new Mjalc(), 151));
			_allActors.push(new HorizontalMovingPlatform(237, 400, -450, 1, new Mjalc(), 151));
			
			/////////////////////
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(64, 316)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(140, 316)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(39, -600)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(89, -600)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(500, -1330)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(350, -1725)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(465, -1725)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(580, -1725)));
			
			////////////////////////////
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(78, -1484)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(120, -1484)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(78, -1555)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(120, -1555)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(56, -1520)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(98, -1520)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(141, -1520)));
			
			////
		
			_allActors.push(new HeartCollectible(new b2Vec2(566, 181)));
			_allActors.push(new HeartCollectible(new b2Vec2(280, 985)));
			////////
			
			_allActors.push(new SpikeStrip(new b2Vec2(460, 400), 200, 80, SpikeStrip.UP, 100)); 
			_allActors.push(new SpikeStrip(new b2Vec2(346, -997), 125, 47, SpikeStrip.UP, 100)); 

			////////////////////
			
			_allActors.push(new PushingEnemy(new b2Vec2(200, -1375), 100, 100, 11, 12)); 
			_allActors.push(new PushingEnemy(new b2Vec2(500, -1213), 55, 55, 11, 12)); 
			
			
			/////////////////// 
			_allActors.push(new BasicEnemy(new b2Vec2(250, 360)));
			_allActors.push(new BasicEnemy(new b2Vec2(270, 360)));
			_allActors.push(new BasicEnemy(new b2Vec2(300, 360)));
			_allActors.push(new BasicEnemy(new b2Vec2(63, -21)));
			_allActors.push(new BasicEnemy(new b2Vec2(166, -370)));
			_allActors.push(new BasicEnemy(new b2Vec2(57, -780)));
			_allActors.push(new HardEnemy(new b2Vec2(553, -1600)));
			//////////////////////
*/
			

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