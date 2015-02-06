package  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class Credits extends State
	{
		
		
		var mainMenuBtn:MainMenuBtn;
		public function Credits(parent:DisplayObjectContainer) 
		{
			super(parent);
			mainMenuBtn = new MainMenuBtn();
			mainMenuBtn.addEventListener(MouseEvent.MOUSE_DOWN, backToMainMenu);
			
			
		//	mainMenuBtn.scaleX = mainMenuBtn.scaleY = 0.6; 
			
			mainMenuBtn.scaleX = mainMenuBtn.scaleY = 0.6;
		
			mainMenuBtn.x = 560;
			mainMenuBtn.y = 456;
			
			var bg:Sprite = new SkyBG();
			var sun:Sprite = new Sunce2();
		//	GlowFilter( sun.filters[0]).blurX = GlowFilter( sun.filters[0]).blurY = 50;
			bg.scaleY = 0.8;
			bg.x = 0;
			bg.y = Global.screenHeight;
			
			
			sun.x = 200;
			sun.y = -70;
			
		//	sun.scaleX = sun.scaleY =  5;

			_canvas.addChild(bg);
			_canvas.addChild(sun);
			
			var progByCL:CLprogrammedBy = new CLprogrammedBy();
			var testedByCL:CLtesting = new CLtesting();
			
			progByCL.x = 200;
			progByCL.y = 200;
			testedByCL.x = 344;
			testedByCL.y = 350;
			_canvas.addChild(new RainbowMC1());
			_canvas.addChild(progByCL);
			_canvas.addChild(testedByCL);
			_canvas.addChild(mainMenuBtn);
			_canvas.addChild(new CreditsTxt());
		}
		
		private function backToMainMenu(e:MouseEvent):void 
		{
			_changeToStateAfterFadeIn = MainMenu;
			startFadeIn();
		}
		
	
		
	}

}