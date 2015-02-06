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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.media.SoundMixer;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class Level8 extends Level
	{
		
		public var _gameCompleteAnimation:GameCompleteAnim;
		public var _plCon:PlayerLCCongrats;
		
		public function Level8(parent:DisplayObjectContainer)  
		{
			super(parent);
			
			_gameCompleteAnimation = new GameCompleteAnim();
			_gameCompleteAnimation.stop();
			
			_plCon = new PlayerLCCongrats();
			_plCon.stop();
			
			
			_playerPos.Set(75, 300);
			
			_iceCubesToCollect = 9;
			setLevelHeightAndCreateBoundingBox(8000);
			
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
			
			Functions.AddStaticBlockPlatform(new b2Vec2(380, 338), 60, 40, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(380, 204), 60, 40, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(156, 268), 114, 142, 2, 0, [3, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, 400), 270, 90, 4, 0, [3, 2 , 4, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(432, 165), 230, 327, 4, 0, [2, 2 , 3, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(203, 72), 105, 42, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(557, -10), 105, 42, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(557, -260), 105, 42, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(342, -400), 54, 42, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(13, -419), 105, 42, 2, 0, [2, 2]);
			
			_allActors.push(new Cannon(new b2Vec2( 33, -590), 80));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(11, -590), 54, 42, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(204, -590), 221, 57, 5, 0, [3, 2 , 4, 2, 3]);
			
			_allActors.push(new BuncyPlatform(new b2Vec2(537, -363)));

			_allActors.push(new HorizontalMovingPlatform( 193, 475, -137, 1, new Mjalc()));
			_allActors.push(new HorizontalMovingPlatform( 65, 385, -285, 1, new Mjalc(), 115));
			
			_allActors.push(new BasicEnemy(new b2Vec2(115, -316)));			
			_allActors.push(new BasicEnemy(new b2Vec2(256, -1095)));
			_allActors.push(new BasicEnemy(new b2Vec2(396, -1095)));
			_allActors.push(new HorizontalMovingPlatform( 175, 321, -1062, 1, new Mjalc(), 256));
			_allActors.push(new HorizontalMovingPlatform( 321, 473, -1062, 1, new Mjalc(), 396));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(494, -715), 50, 40, 2, 0, [2, 2]);

			
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(595, -850), 50, 40, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(212, -917), 51, 53, 1, 0, [2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(370, -917), 51, 53, 1, 0, [2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(214, -875), 205, 43, 6, 0, [4, 3, 2 , 4, 2, 3]);
			
			//////////////
			_allActors.push(new SpikeStrip(new b2Vec2(212 + 51, -875 - 40), 370 - (212 + 51), 40, SpikeStrip.UP, 100));
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(545, -1216), 97, 32, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(462, -1343), 65, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(360, -1424), 65, 36, 2, 0, [2, 2]);
			
			
			_allActors.push(new Cannon(new b2Vec2( 30, -1333), 83));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(4, -1333), 65, 36, 2, 0, [2, 2]);
			
			_allActors.push(new SmartCannon(new b2Vec2( 22, -1660), 78));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(4, -1660), 65, 36, 2, 0, [2, 2]);
			
			_allActors.push(new HorizontalMovingPlatform( 175, 321, -1530, 1, new Mjalc(), 256));
			_allActors.push(new BasicEnemy(new b2Vec2(230, -1560)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(396, -1560)));
			_allActors.push(new HorizontalMovingPlatform( 321, 473, -1530, 1, new Mjalc(), 396));
			
			_allActors.push(new HorizontalMovingPlatform( 331, 607, -1680, 1, new Mjalc()));
			
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(446, -1840)));
			_allActors.push(new HorizontalMovingPlatform( 225, 500, -1807, 1, new Mjalc(), 446));
			
			_allActors.push(new HorizontalMovingPlatform( 20, 263, -1926, 1, new Mjalc()));
			
			
			
			_allActors.push(new SmartCannon(new b2Vec2( 617, -1904), -70));
			Functions.AddStaticBlockPlatform(new b2Vec2(575, -1904), 65, 36, 2, 0, [2, 2]);
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(433, -2092)));
			_allActors.push(new HorizontalMovingPlatform( 385, 635, -2060, 1, new Mjalc(),386));
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2(53, -2200), 194, 57, 5, 0, [4, 2, 3, 2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(367, -2300), 157, 47, 3, 0, [4, 5, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(494, -2444), 65, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(575, -2570), 65, 36, 2, 0, [2, 2]);
			
			
			_allActors.push(new SmartCannon(new b2Vec2( 19, -2532), 78));
			Functions.AddStaticBlockPlatform(new b2Vec2( -2, -2532), 65, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(575, -2830), 65, 36, 2, 0, [2, 2]);
			
			
			
			
			_allActors.push(new Cannon(new b2Vec2( 619, -3080), -70));
			Functions.AddStaticBlockPlatform(new b2Vec2(585, -3080), 65, 36, 2, 0, [2, 2]);
			
			_allActors.push(new BuncyPlatform(new b2Vec2(278, -2794)));
			_allActors.push(new BuncyPlatform(new b2Vec2(105, -3100)));
			Functions.AddStaticBlockPlatform(new b2Vec2(494, -2700), 65, 36, 2, 0, [2, 2]);
			
			///////////
			
			
			
			

			
			_allActors.push(new Cannon(new b2Vec2( 318 - 26, -3304), -80));
			_allActors.push(new Cannon(new b2Vec2( 318 + 26, -3304), 80));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(258, -3304), 116, 35, 2, 0, [3, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2( -2, -3468), 120, 35, 2, 0, [2, 2]);
			
			_allActors.push(new SpikeStrip(new b2Vec2(0, -3468 + 35), 114, 37, SpikeStrip.DOWN, 100));
			_allActors.push(new BuncyPlatform(new b2Vec2(468, -3287)));
			_allActors.push(new BuncyPlatform(new b2Vec2(319, -3596)));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(357, -3763), 65, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(447, -3882), 65, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2( 166, -3846), 116, 35, 2, 0, [2, 2]);
			_allActors.push(new SpikeStrip(new b2Vec2(166, -3846 + 35), 116, 37, SpikeStrip.DOWN, 100));
			_allActors.push(new SpikeStrip(new b2Vec2(166, -3846 - 37), 116, 37, SpikeStrip.UP, 100));
			
	
			Functions.AddStaticBlockPlatform(new b2Vec2( 340, -3846), 300, 35, 4, 0, [2, 3, 1, 2]);
			_allActors.push(new SpikeStrip(new b2Vec2(340, -3846 + 35), 300, 37, SpikeStrip.DOWN, 100));
			_allActors.push(new SpikeStrip(new b2Vec2(340, -3846 - 37), 452 - 340, 37, SpikeStrip.UP, 100));
			_allActors.push(new SpikeStrip(new b2Vec2(513, -3846 - 37), 132, 37, SpikeStrip.UP, 100));
			
			///
			
			_allActors.push(new SmartCannon(new b2Vec2( 617, -4009), -70));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(575, -4009), 68, 39, 2, 0, [2, 2]);
			
			_allActors.push(new BuncyPlatform(new b2Vec2(407, -4145)));
			_allActors.push(new BuncyPlatform(new b2Vec2(317, -4495)));
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -4611), 111, 36, 2, 0, [2, 2]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -4611), 111, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -4739), 111, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(0, -4879), 111, 36, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(525, -4611), 111, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(525, -4739), 111, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(525, -4879), 111, 36, 2, 0, [2, 2]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2(150, -4680), 111, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(150, -4798), 111, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(150, -4933), 111, 36, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(364, -4680), 111, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(364, -4798), 111, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(364, -4933), 111, 36, 2, 0, [2, 2]);
			
			_allActors.push(new BuncyPlatform(new b2Vec2(497, -5072)));
			
			/////////LASE

			
			Functions.AddStaticBlockPlatform(new b2Vec2(317, -5222), 65, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(527, -5222), 65, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(317, -5771), 65, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(527, -5771), 65, 36, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(40, -5771), 160, 36, 4, 0, [2,1, 3, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(381, -5512), 65, 36, 2, 0, [2, 2]);
			Functions.AddStaticBlockPlatform(new b2Vec2(455, -5648), 65, 36, 2, 0, [2, 2]);
			
			_allActors.push(new HorizontalMovingPlatform( 298, 638, -5391, 1, new Mjalc()));
			
			Functions.AddStaticBlockPlatform(new b2Vec2(-2, -6010), 100, 36, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(252, -6076), 65, 36, 2, 0, [2, 2]);
			
			
			_allActors.push(new SmartCannon(new b2Vec2( 22, -6153), 70));
			Functions.AddStaticBlockPlatform(new b2Vec2( -2, -6153), 65, 36, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(415, -6200), 65, 36, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(300, -6320), 65, 36, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2(544, -6320), 65, 36, 2, 0, [2, 2]);
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2( -2, -6433), 200, 57, 3, 0, [ 3, 2, 2]);
			
			_allActors.push(new VerticalMovingPlatform( -6565, -6890, 105, 1, new Mjalc()));
			
			
			
			_allActors.push(new SmartCannon(new b2Vec2( 19, -6992), 70));
			Functions.AddStaticBlockPlatform(new b2Vec2( -2, -6992), 65, 36, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2( 603, -7025), 65, 36, 2, 0, [3, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2( 215, -6890), 370, 65, 5, 0, [3, 2, 4, 3, 1]);
			
			
			
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2( 354, -7304), 98, 68, 2, 0, [2, 2]);
			
			Functions.AddStaticBlockPlatform(new b2Vec2( 310, -7239), 180, 40, 3, 0, [1, 2, 2]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2( 272, -7200), 265, 38, 3, 0, [3, 2, 4]);
			
			
			Functions.AddStaticBlockPlatform(new b2Vec2( 215, -7163), 370, 65, 4, 0, [2, 4, 3, 2]);
			
			

				
			///////////////////////
			
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 348 + 50 , -6560 - 37 - 37 - 37 - 37 - 37), 50, 37, 1, 0, [2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 348 + 50 , -6560 - 37 - 37 - 37), 50, 37, 1, 0, [2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 348 + 50 , -6560 - 37 - 37), 50, 37, 1, 0, [2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 348 + 50 , -6560 - 37), 50, 37, 1, 0, [2]);
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 348, -6560), 150, 37, 3, 0, [ 2, 2, 2]);
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 348, -6560+37), 50, 37, 1, 0, [2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 348, -6560+37 + 37), 50, 37, 1, 0, [2]);
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 348 + 100, -6560+37), 50, 37, 1, 0, [2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 348 + 100, -6560 + 37 + 37), 50, 37, 1, 0, [2]);
			
			
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 302, -6706), 98, 37, 2, 0, [ 2, 2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 450, -6706), 98, 37, 2, 0, [ 2, 2]);
			
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 299, -6821 + 3), 50, 37, 1, 0, [2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 299, -6821 +37 + 3), 50, 37, 1, 0, [2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 299, -6821 + 37 + 37 + 3), 50, 37, 1, 0, [2]);
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 499, -6821 + 3), 50, 37, 1, 0, [2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 499, -6821 +37 + 3), 50, 37, 1, 0, [2]);
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 499, -6821 + 37 + 37 + 3), 50, 37, 1, 0, [2]);
			
			Functions.AddStaticIceBlockPlatform(new b2Vec2( 380, -6800), 91, 62, 1, 0, [2]);
			
			_allActors.push(new SpikeStrip(new b2Vec2(268, 393), 166, 87, SpikeStrip.UP, 100));
			
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(412, 297)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(372, -428)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(396, -636)));
			
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(465, -1730)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(471, -3440)));
			//_allActors.push(new IceCubeCollectable(new b2Vec2(483, -3909)));
			
		//	_allActors.push(new IceCubeCollectable(new b2Vec2(316, -4781)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(614, -5754)));
			
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(414, -7457)));
			
			
			
			_allActors.push(new MediumEnemy(new b2Vec2(593, 142)));
			_allActors.push(new BasicEnemy(new b2Vec2(533, 142)));
			_allActors.push(new BasicEnemy(new b2Vec2(513, 142)));
			_allActors.push(new HardEnemy(new b2Vec2(228, 246)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(603, -37)));
			_allActors.push(new BasicEnemy(new b2Vec2(607, -1238)));
			_allActors.push(new BasicEnemy(new b2Vec2(396, -1444)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(156, -2216)));
			_allActors.push(new MediumEnemy(new b2Vec2(445, -2321)));
			_allActors.push(new BasicEnemy(new b2Vec2(516, -2468)));
			_allActors.push(new BasicEnemy(new b2Vec2(519, -2722)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(612, -2850)));
			
			_allActors.push(new HardEnemy(new b2Vec2(53, -4635)));
			_allActors.push(new HardEnemy(new b2Vec2(53, -4765)));
			_allActors.push(new HardEnemy(new b2Vec2(53, -4900)));
			
			_allActors.push(new HardEnemy(new b2Vec2(588, -4635)));
			_allActors.push(new HardEnemy(new b2Vec2(588, -4765)));
			_allActors.push(new HardEnemy(new b2Vec2(588, -4900)));
			
			_allActors.push(new MediumEnemy(new b2Vec2(210, -4710)));
			_allActors.push(new MediumEnemy(new b2Vec2(210, -4828)));
			
			_allActors.push(new MediumEnemy(new b2Vec2(422, -4710)));
			_allActors.push(new MediumEnemy(new b2Vec2(422, -4828)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(213, -4953)));
			_allActors.push(new BasicEnemy(new b2Vec2(253, -4953)));
			
			_allActors.push(new BasicEnemy(new b2Vec2(390, -4953)));
			_allActors.push(new BasicEnemy(new b2Vec2(440, -4953)));
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(351, -5800)));
			_allActors.push(new BasicEnemy(new b2Vec2(560, -5800)));
			_allActors.push(new BasicEnemy(new b2Vec2(270, -6100)));
			
			_allActors.push(new HardEnemy(new b2Vec2(50, -6043)));
			_allActors.push(new BasicEnemy(new b2Vec2(321, -6342)));
			
			
			_allActors.push(new BasicEnemy(new b2Vec2(90, -6457)));
			_allActors.push(new BasicEnemy(new b2Vec2(405, -7330)));
			
			
			_allActors.push(new PushingEnemy(new b2Vec2(330, -647), 63, 116, 11, 12)); 
			
			_allActors.push(new PushingEnemy(new b2Vec2(153, -5820), 50, 90, 11, 12)); 
			_allActors.push(new BasicEnemy(new b2Vec2(150, -5883)));
			
			_allActors.push(new LaserEmiter(new b2Vec2(413, -590 + 57), LaserEmiter.DOWN,  Math.PI, 1));
			_allActors.push(new LaserEmiter(new b2Vec2(558, -5222), LaserEmiter.UP,  0, 1));
			_allActors.push(new LaserEmiter(new b2Vec2(350, -5222), LaserEmiter.UP,  0, 1));
			_allActors.push(new LaserEmiter(new b2Vec2(318, -3304), LaserEmiter.UP,  0, 1));
			
			
			
			_allActors.push(new LaserEmiter(new b2Vec2(494, -696), LaserEmiter.LEFT,  Math.PI * 3 / 2, 1));
			
			
			_allActors.push(new LaserEmiter(new b2Vec2(640, -1054), LaserEmiter.LEFT,  Math.PI * 3 / 2, 1));
			_allActors.push(new LaserEmiter(new b2Vec2(0, -1054), LaserEmiter.RIGHT,  Math.PI / 2, 1));
			
			_allActors.push(new LaserEmiter(new b2Vec2(640, -1519), LaserEmiter.LEFT,  Math.PI * 3 / 2, 1));
			_allActors.push(new LaserEmiter(new b2Vec2(0, -1519), LaserEmiter.RIGHT,  Math.PI / 2, 1));
			
			var  lasernum:int = 7;
			var firstLX:int = 245;
			var lastLX:int = 555;
	
			var laserXStep:int = (lastLX - firstLX) / (lasernum - 1);
			
			for (var i:int = 0; i < lasernum; i++ )
				_allActors.push(new LaserEmiter(new b2Vec2( firstLX + i*laserXStep, -7163 + 65), LaserEmiter.DOWN,  Math.PI, 0.2));
			
			_allActors.push(new IceCubeCollectable(new b2Vec2(firstLX + 2*laserXStep - laserXStep/2, -6990)));
		//	_allActors.push(new IceCubeCollectable(new b2Vec2(firstLX + 4 * laserXStep - laserXStep / 2, -6990)));
			_allActors.push(new IceCubeCollectable(new b2Vec2(firstLX + 6*laserXStep - laserXStep/2, -6990)));
			
			
			
			
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(30, -456)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(60, -456)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(90, -456)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(30, -436)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(60, -436)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(90, -436)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(493, -1365)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(493, -1400)));
			
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(605, -2590)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(605, -2622)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(313, -3653)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(313, -3653 - 50)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(313, -3653 - 100)));
			
			_allActors.push( new SnowBallCollectible(new b2Vec2(413, -6762)));
			_allActors.push( new SnowBallCollectible(new b2Vec2(439, -6762)));
			
			
			_allActors.push(new HeartCollectible(new b2Vec2(317, -960)));
			_allActors.push(new HeartCollectible(new b2Vec2(140, -1986))); //cernobil
			
			
			_allActors.push(new HeartCollectible(new b2Vec2(313, -3830)));
			
			_allActors.push(new HeartCollectible(new b2Vec2(54, -4677)));
			_allActors.push(new HeartCollectible(new b2Vec2(586, -4677)));
			
			_allActors.push(new HeartCollectible(new b2Vec2(570, -6345)));
			
			_allActors.push(new HeartCollectible(new b2Vec2(420, -6689)));
			
			

			
			
			//void (*signal())(int bole);
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
		
		override public function startLevelCompleteLogic():void
		{
			SoundMixer.stopAll();
			Global.currentBackgroundMusic = -1;
			Global.GAME.backgroundMusicChannel = Global.GAME.CongratsMusic.play();
			
			var bd:BitmapData = new BitmapData(Global.screenWidth, Global.screenHeight);
			bd.draw(Global.GAME.stage);// , new Matrix(1, 0, 0, 1, 0, -Global.upperCameraLimit));
			screenshot = new Bitmap(bd);

			screenshot.y = Global.upperCameraLimit;
			_gameCompleteAnimation.x = Global.screenWidth/2;
			_gameCompleteAnimation.y = Global.upperCameraLimit + Global.screenHeight / 2;
			
			_plCon.x = 0;
			_plCon.y = Global.upperCameraLimit;

			_canvas.addChild(screenshot);
			_gameCompleteAnimation.gotoAndPlay(1);
			
			_plCon.gotoAndPlay(1);
			
			_canvas.addChild(_gameCompleteAnimation);
			_canvas.addChild(_plCon);
		}
		
		override public function levelCompleteLogic():void
		{
			if (_plCon.currentFrame == 132)
			_plCon.gotoAndPlay(68);
			
			if (_gameCompleteAnimation.currentFrame == 21)
				_gameCompleteAnimation.gameCompleteSlide1.mainMenuBtn1.addEventListener(MouseEvent.MOUSE_DOWN, backToMainMenu);
			
			if (_gameCompleteAnimation.currentFrame == 30)
			{
				_gameCompleteAnimation.stop();
				return;
			}
			
			_levelCBlur += _levelCBlurCrement;
			screenshot.x -= 1;
			screenshot.y -= 1;
			screenshot.scaleY = screenshot.scaleX *= 1.003;
			screenshot.filters = [new BlurFilter(_levelCBlur, _levelCBlur)];
		}
	}
}