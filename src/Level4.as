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
	public class Level4 extends Level
	{
		public function Level4(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			_playerPos.Set(36, 300);
			
			_iceCubesToCollect = 7;
			setLevelHeightAndCreateBoundingBox(3500);
			
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
			
			_allActors.push(new BuncyPlatform(new b2Vec2(606, -630)));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 345), 74, 155, 2, 0, [3, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(182, 345), 130, 155, 3, 0, [3, 2, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 57), 320, 33, 7, 0, [3, 2, 3 , 4, 5, 3, 3]);
			Functions.AddStaticBlockPlatform(new b2Vec2(512, -128), 140, 35, 5, 0, [3, 4, 2,3 ,4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(72, -215), 330, 42, 5, 0, [5, 6, 8, 6 , 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(380, -520), 300, 62, 4, 0, [5, 6, 7, 6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -640), 70, 48, 2, 0, [3, 2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2(355, -885), 200, 48, 3, 0, [5, 8, 7]);	
			Functions.AddStaticIceBlockPlatform(new b2Vec2(0, -972), 190, 50, 3, 0, [6, 8, 5]);	
			Functions.AddStaticIceBlockPlatform(new b2Vec2(355, -1133), 210, 53, 4, 0, [6, 8, 5,7]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2(0, -1227), 205, 48, 3, 0, [7, 6, 8]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2(448, -1340), 230, 53, 4, 0, [6, 8, 5,9]);
			Functions.AddStaticBlockPlatform(new b2Vec2(540, -1500), 130, 45, 2, 0, [2, 3]);
			Functions.AddStaticBlockPlatform(new b2Vec2(-30, -1500), 130, 45, 2, 0, [4, 3]);
			Functions.AddStaticBlockPlatform(new b2Vec2(210, -1989), 240, 46, 3, 0, [3, 2, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -2310), 205, 50, 3, 0, [4, 3, 5]);
			
			_allActors.push(new SpikeStrip(new b2Vec2(74, 430), 110, 50, SpikeStrip.UP, 100)); 
			_allActors.push(new SpikeStrip(new b2Vec2(312, 430), 360, 50, SpikeStrip.UP, 100)); 
			
			_allActors.push(new VerticalMovingPlatform(350, 70, 488, 1, new Mjalc(), 349));
			_allActors.push(new VerticalMovingPlatform( -1400, -1740, 242, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform( 75, 585, -1837, 1, new Mjalc(), 76));
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(250, 320)));
			_allActors.push(new BasicEnemy(new b2Vec2(485, 311)));
			_allActors.push(new BasicEnemy(new b2Vec2(616, -150)));
			_allActors.push(new BasicEnemy(new b2Vec2(128, -356)));
			_allActors.push(new BasicEnemy(new b2Vec2(426, -906)));
			_allActors.push(new BasicEnemy(new b2Vec2(426, -1150)));
			_allActors.push(new BasicEnemy(new b2Vec2(80, -1250)));
			_allActors.push(new BasicEnemy(new b2Vec2(480, -1360)));
			_allActors.push(new BasicEnemy(new b2Vec2(80, -1880)));
			
			_allActors.push(new MediumEnemy(new b2Vec2(110, -2337)));
			_allActors.push(new MediumEnemy(new b2Vec2(542, -542)));
			
			
			_allActors.push(new HeartCollectible(new b2Vec2(600, -975)));
			_allActors.push(new HeartCollectible(new b2Vec2(240, -1575)));
			
			_allActors.push(new MediumEnemy(new b2Vec2(172, 30)));
			
			_allActors.push(new PushingEnemy(new b2Vec2(130, -270), 70, 125, 11, 12)); 
			_allActors.push(new PushingEnemy(new b2Vec2(337, -2064), 70, 160, 11, 12)); 
			
			_allActors.push(new LaserEmiter(new b2Vec2(0, -2110), LaserEmiter.RIGHT,  Math.PI / 2, 1));
			
			_allActors.push(new LaserEmiter(new b2Vec2(190, -963), LaserEmiter.RIGHT,  0.959931089, 0.09));
			
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(488, 228)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(488, 188)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(488, 148)));
			
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(250, -500)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(300, -540)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(577, -1531)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(621, -1531)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(600, -1569)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(125, 195)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(30, 30)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(618, -553)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(611, -1378)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(47, -1556)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(253, -2034)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(32, -2337)));
			
			
			_allActors.push(new SmartCannon(new b2Vec2( 25, -640), 56));
			_allActors.push(new Cannon(new b2Vec2( 25, -972), 86));
			
		//	_allActors.push(new IceCubeCollectable(new b2Vec2(135, 1290)));
			///////////////////
/*
			_allActors.push(new Cannon(new b2Vec2( 620, -600), -60));
			
			//
			//////////
			_allActors.push(new BuncyPlatform(new b2Vec2(44, -305))); 
			
			/////////////////////
			//

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