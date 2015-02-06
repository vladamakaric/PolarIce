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
	public class Level2 extends Level
	{
		public function Level2(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			_iceCubesToCollect = 8;
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
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 440), 300, 50, 5, 0, [4,2,3,5,2]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(200, 380), 260, 120, 4, 0, [3,2 ,4, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(482, 226), 200, 45, 3, 0, [3, 2 , 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(262, 131), 120, 38, 3, 0, [2, 2, 3]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 0), 200, 60, 5, 0, [2, 4, 2, 3, 4]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2(258, -166), 200, 50, 3, 0, [5, 4, 4]);
			 
			Functions.AddStaticBlockPlatform(new b2Vec2(380, -600), 290, 60, 5, 0, [5, 3, 4, 4, 5]);
			Functions.AddStaticBlockPlatform(new b2Vec2(200, -680), 120, 45, 3, 0, [5, 4, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -760), 140, 55, 3, 0, [5, 4, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(214, -950), 265, 65, 5, 0, [4, 3, 3, 4, 5]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(112, -1100), 120, 40, 3, 0, [4, 3, 3]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(400 , -1180), 200, 50, 3, 0, [4, 4, 3]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(60 , -1325), 220, 53, 4, 0, [5, 3, 4, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(300, -1570), 360, 75, 6, 0, [5, 4, 3, 3, 4, 5]);
			
			
			
			
			///////////////////

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