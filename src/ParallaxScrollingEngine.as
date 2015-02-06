package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class ParallaxScrollingEngine 
	{
		var parralaxLayers:Array;
		public function ParallaxScrollingEngine() 
		{		
			parralaxLayers = [];	
		}
		
		public function addNewParallaxLayer( pl:ParallaxLayer )
		{
			parralaxLayers.push(pl);
		}
		
		public function Update()
		{
			for each(var pl:ParallaxLayer in parralaxLayers)
				pl.Update();
		}	
	}
}