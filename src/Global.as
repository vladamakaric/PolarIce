package  
{
	import Box2D.Dynamics.b2World;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class Global 
	{
		public static var GAME:TowerGame;
		public static var RATIO:int = 40;
		public static var world:b2World;
		public static var globalID:int = 0;
		public static var stage:Stage;
		public static var gameCanvas:MovieClip;
		public static var TIME:Number = 0;
		public static var screenWidth:Number = 640;
		public static var screenHeight:Number = 480;
		
		public static var globalBlackCurtain:Sprite = new BlackScreen();
		
		public static var player:PlayerActor;
		public static var allActors:Array;
		public static var allParticles:Array;
		public static var currentLevel:Level;
		public static var screenDiagonal:Number = Math.sqrt(screenWidth * screenWidth + screenHeight * screenHeight);
		
		public static var upperCameraLimit:Number;
		public static var lowerCameraLimit:Number;
		public static var blackScreen:BlackScreen;
		
		public static var SOUND:Boolean = true;
		
		public static var currentLevelIndx:int;
		
		
		public static var levelUnlocked:Array;
		public static var unlockedLevelPictureClasses:Array;
		public static var levelClassArr:Array;
		
		public static var cookie:SharedObject;
		
		public static const MENUMUSIC:int = 1;
		public static const TIER1MUSIC:int = 2;
		public static const TIER2MUSIC:int = 3;
		public static const TIER3MUSIC:int = 4;
		public static const OTHERMUSIC:int = 4;
		
		public static var currentBackgroundMusic:int = 0;
		
		public static function playThrowSound()
		{
			GAME.ThrowSound.play();
		}
		
		public function Global() 
		{
			
		}
		
	}

}