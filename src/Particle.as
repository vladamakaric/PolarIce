package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class Particle
	{
		var costume:Sprite;
		var velocity:b2Vec2;
		var position:b2Vec2;
		
		public function Particle(parent:DisplayObjectContainer, ParticleImageClass:Class, pos:b2Vec2, vel:b2Vec2) 
		{
			costume = new ParticleImageClass();
			parent.addChild(costume);
			velocity = vel;
			position = pos;
		}
		
		public function done():Boolean
		{
			return false;
		}
		
		public function update()
		{
			position.Add(velocity);
			costume.x = position.x;
			costume.y = position.y;
		}
		
		public function destroy():void
		{
			costume.parent.removeChild(costume);
		}
	}

}