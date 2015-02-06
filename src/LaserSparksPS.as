package  
{
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Vec2;
	import fl.motion.Color;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Mikhail
	 */
	public class LaserSparksPS extends ParticleSystem
	{
		public var _destroy:Boolean = false;
		var _maxPars:int = 18;
		var _smoke:SmokeThrusterPS;
		
		public function LaserSparksPS(parentContainer:DisplayObjectContainer,position:b2Vec2) 
		{
			super(parentContainer, position);
			
			
			 _smoke  = new SmokeThrusterPS(
			Sprite(parentContainer), 
			new b2Vec2(0, 0),
			6,//maxNumParticles	[10]
			 .4,//beginScale		[.5]
			1.15,//growthKoef		[1.15]
			0.048,//alphaDrop		[0.03]
			14,//smokeRadius			[7]
			.7,//startAlpha		[.4]
			2//maxAngularVel		[5]
			);	
			//Level(TankGame.currentState)._allParticleSystems.push(_smoke);
			
			Global.currentLevel._allParticleSystems.push(_smoke);
					
			var col:Color = new Color();
			col.setTint(0xFF0000, 1);
			Sprite(_smoke._canvas ).transform.colorTransform = col;
			//Sprite(_smoke._canvas).scaleX 3; 
			//Sprite(_smoke._canvas).scaleY = 7;
			
			_smoke._position = _position;
			
			//_canvas.graphics.lineStyle(1);
			//_canvas.graphics.beginFill(0xFF0000);
			//_canvas.graphics.drawCircle(0, 0, 20);
			//_canvas.graphics.endFill();
		}
		
		override public function update():Boolean 
		{
			if (_maxPars > _allParticles.length && !_destroy)
			{
				var particle:LaserSparkParticle = new LaserSparkParticle(_canvas, _position.Copy(),Math.random() * 2);
				_allParticles.push(particle);
				var particle:LaserSparkParticle = new LaserSparkParticle(_canvas, _position.Copy(),Math.random() * 2);
				_allParticles.push(particle);
				var particle:LaserSparkParticle = new LaserSparkParticle(_canvas, _position.Copy(),Math.random() * 2);
				_allParticles.push(particle);
			}
			
			
			
			super.update();
			//return _destroy;
			return _allParticles.length <= 0;
		}
		
		
		override public function destroy():void 
		{ 
			_smoke.evaporate = true;
			super.destroy();
		}
		
	}

}