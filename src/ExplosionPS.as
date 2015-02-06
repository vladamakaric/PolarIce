package
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class ExplosionPS extends ParticleSystem
	{
		
		
		public function ExplosionPS(parent:DisplayObjectContainer, location:b2Vec2, partnum:int, gk:Number, bs:Number, es:Number, ad:Number, starta:Number, 
		velmul:Number, posoffset:Number, maxa:Number,tcolor:uint, colordrop:int, talpha:Number , costumescale:Number, expt:int)  
		{
			super(parent, location);
			var smokeClass:Class;
			
			_canvas.x = location.x;
			_canvas.y = location.y;
			_canvas.scaleX = costumescale;
			_canvas.scaleY = _canvas.scaleX;
			
			for (var i:int = 0; i < partnum; i++ )
			{		
				switch(int(Math.random()*4)) 
				{
					case 0:
					smokeClass = EPb1;
					break;
					case 1:
					smokeClass =  EPb2;
					break;
					case 2:
					smokeClass =  EPb3;
					break;
					case 3:
					smokeClass =  EPb4;
					break;
				}
				
				if (i == partnum - 1 && expt == 2)
					smokeClass = EPb4;
					
				var sp2:ExplosionParticle =  new ExplosionParticle(_canvas, smokeClass, gk, bs, es, ad, starta , velmul, posoffset, maxa, tcolor, colordrop, talpha);
				_allParticles.push(sp2);
			}
		}	
		
		public function setUpBlur(hor:int, ver:int):void
		{
			var filter:BitmapFilter = new BlurFilter(hor, ver, BitmapFilterQuality.LOW);
            var myFilters:Array = new Array();
            myFilters.push(filter);
            _canvas.filters = myFilters;
		}
		
		override public function update():Boolean 
		{	
			if (ExplosionParticle(_allParticles[_allParticles.length - 1]).done())
				return true;

			return super.update();
		}
	}

}