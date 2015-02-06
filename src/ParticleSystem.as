package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class ParticleSystem
	{
		var _position:b2Vec2;
		var _canvas:MovieClip;
		var _allParticles:Array;
		
		public function ParticleSystem(parent:DisplayObjectContainer,loc:b2Vec2) 
		{
			_canvas = new MovieClip();
			parent.addChild(_canvas);
			_position = loc;
			_allParticles = [];
		}
		
		public function update():Boolean
		{
			for (var i:int = 0; i < _allParticles.length; i++)
			{
				if (_allParticles[i].done())
				{
					_allParticles[i].destroy();	
					_allParticles.splice(i, 1);
					i--;
				}
				else
					_allParticles[i].update();
			}
			
			return false;
		}	
		
		public function destroy():void
		{
			
			
			_canvas.parent.removeChild(_canvas);
			
			for (var i:int = 0; i < _allParticles.length; i++)
			{
				_allParticles[i].destroy();
				_allParticles.splice(i, 1);
				i--;
			}
		}
	}
}

			/*
			_canvas = new Sprite();
			_canvas.graphics.lineStyle(2, 0x00D900);
			normal.Multiply(3);
			_canvas.graphics.moveTo(location.x, location.y);
			_canvas.graphics.lineTo(location.x + normal.x , location.y + normal.y);
			parent.addChild(_canvas);
			*/