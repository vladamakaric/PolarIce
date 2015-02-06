package  
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	
	 
	public class SnowEngine 
	{
		var snowFlakes:Array;
		var numOfSF:Number = 40;
	///	var snowCanvas:Sprite;
		//static var snowFBD:BitmapData;
		
		public function SnowEngine() 
		{
	//		snowFBD = new snowF1BD();
			
		//	snowCanvas = new Sprite();
			snowFlakes = [];
			for (var i:Number = 0; i < numOfSF; i++ )
			{
				snowFlakes.push(new SnowFlake(Global.gameCanvas));
			}
			
		//	Global.gameCanvas.addChild(snowCanvas);
			
			//snowCanvas.filters = [new BlurFilter(2, 2)];
		}
		
		public function Update()
		{
			for each(var snowF:SnowFlake in snowFlakes)
			{
				snowF.Update();
			}
		}
		
	}

}