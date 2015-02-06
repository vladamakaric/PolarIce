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
	public class Level3 extends Level
	{
		public function Level3(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			_playerPos.Set(30, 300);
			
			_iceCubesToCollect = 7;
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
			
			_allActors.push(new BuncyPlatform(new b2Vec2(606, 341)));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 345), 213, 155, 4, 0, [3,2 ,4, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(431, 345), 260, 155, 4, 0, [4,5 ,4, 3]);
			Functions.AddStaticBlockPlatform(new b2Vec2(211, 123), 262, 33, 5, 0, [4, 5, 4, 3, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(165, -195), 60, 90, 1, 0, [1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(165, -133), 500, 53, 8, 0, [4, 5, 4, 3, 4, 2 , 5 , 5]);
			Functions.AddStaticBlockPlatform(new b2Vec2(273, -347), 180, 40, 3, 0, [3 , 5 , 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(402, -558), 150, 42, 2, 0, [1 , 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(63, -678), 285, 50, 5, 0, [3 , 5 , 4 , 5, 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(581, -1015), 100, 110, 2, 0, [2 , 1]);
			Functions.AddStaticBlockPlatform(new b2Vec2(159, -929), 540, 60, 8, 0, [3, 5, 5, 3, 5, 4 , 5 , 3]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(542, -1136), 130, 43, 3, 0, [3 , 5 , 4]);
			Functions.AddStaticBlockPlatform(new b2Vec2(505, -1260), 170, 43, 3, 0, [4 , 5 , 6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(466, -1382), 210, 43, 4, 0, [4, 5 , 4, 3]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(560, -1882), 110, 110, 2, 0, [7 , 9]);
			Functions.AddStaticBlockPlatform(new b2Vec2(460, -1793), 240, 116, 3, 0, [5, 4, 6]);
			Functions.AddStaticBlockPlatform(new b2Vec2(347, -1704), 340, 106, 4, 0, [3, 5, 3, 4, 5 , 5 , 5]);
			Functions.AddStaticBlockPlatform(new b2Vec2(233, -1612), 460, 110, 5, 0, [4, 5, 4, 3, 2 , 5 , 5]);
			
			
			
			
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(146, -1517), 520, 57, 7, 0, [4, 5, 4, 3, 2 , 5 , 5]);
			
			
			
			_allActors.push(new Cannon(new b2Vec2(618, -1015), -90 + 8));
			
			
			_allActors.push(new Cannon(new b2Vec2(580, -1136), -90 + 8));
			_allActors.push(new Cannon(new b2Vec2(545, -1260), -90 + 8));
			_allActors.push(new Cannon(new b2Vec2(500, -1382), -90 + 8));
			
			
			
			_allActors.push(new SpikeStrip(new b2Vec2(213, 400), 227, 80, SpikeStrip.UP, 100)); 
			_allActors.push(new SpikeStrip(new b2Vec2(225, -183), 435, 50, SpikeStrip.UP, 100)); 
			
			_allActors.push(new BasicEnemy(new b2Vec2(526, 322)));
			_allActors.push(new BasicEnemy(new b2Vec2(250, -820)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(290, -1633)));
			_allActors.push(new BasicEnemy(new b2Vec2(420, -1724)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(500, -1812)));
			_allActors.push(new BasicEnemy(new b2Vec2(600, -1900)));
			
			_allActors.push(new MediumEnemy(new b2Vec2(350, 90)));
			
			_allActors.push(new VerticalMovingPlatform(126, -119, 93, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform(70, 485, -990, 1, new Mjalc())); 
			
			_allActors.push(new HorizontalMovingPlatform(70, 455, -1106, 1, new Mjalc())); 
			_allActors.push(new HorizontalMovingPlatform(70, 421, -1232, 1, new Mjalc())); 
			_allActors.push(new HorizontalMovingPlatform(70, 384, -1360, 1, new Mjalc())); 
			
			_allActors.push(new PushingEnemy(new b2Vec2(386, -408), 75, 110, 9, 10)); 
			_allActors.push(new PushingEnemy(new b2Vec2(503, -600), 75, 75, 9, 10)); 
			_allActors.push(new PushingEnemy(new b2Vec2(239, -739), 105, 120, 9, 10));
			
			_allActors.push(new LaserEmiter(new b2Vec2(0,16), LaserEmiter.RIGHT, 2.25147474, 0.5 ));
			
			_allActors.push(new HeartCollectible(new b2Vec2(590, -807)));
			_allActors.push(new HeartCollectible(new b2Vec2(270, -1170)));
			
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(253, 79)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(442, -395)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(90, -728)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(133, -1061)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(135, -1290)));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(270, -1773)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(600, -2050)));
			
			
			
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