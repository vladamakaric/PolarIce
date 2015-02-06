package  
{
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;

	/**
	 * ...
	 * @author Mikhail
	 */
	public class LaserContignous extends Sprite
	{
		public static var LaserColours:Array = [0xFF1527, //Glavna Crvena
											0xFFFFFF, //Bela
											0xFF3535, //Crvena, koja ide i izbledjuje kao partikl
											];
		
											public var _laserGrowthSpeed:Number;
		var _tipSpeed:Number = 0;
		public var _start:b2Vec2;
		public var _end:b2Vec2 = null;
		var _angle:Number;
		var _framesLeast:int;
		var _turning:Boolean = false;
		var _sparks:LaserSparksPS;
		var _flow:LaserFlowPS;
		var _burning:Boolean  = false;
		
		
		//var _end:b2Vec2;
		var _contacts:Array;
		
		public function LaserContignous(parent:DisplayObjectContainer,start:b2Vec2, angle:Number, laserGrowthSpeed:Number = 0.3) 
		{
			_laserGrowthSpeed = laserGrowthSpeed;
			_flow = new LaserFlowPS(this, start, null);
			Global.currentLevel._allParticleSystems.push(_flow);
			//Level(TankGame.currentState)._allParticleSystems.push(_flow);
			
			_framesLeast =3;
			_start = start;
			_angle = angle;
			
			
			parent.addChild(this);
			//addEventListener(Event.ENTER_FRAME, update);
			
			var gf:GlowFilter = new GlowFilter(0xFF8083, 0.5);
			gf.knockout = Math.random() > 0.5 && _turning;
			//gf.strength = Math.random() * 10 + 3;
			gf.blurX = gf.blurY = 20 - gf.blurY;
			
			var bf:BlurFilter = new BlurFilter();
			bf.blurX = bf.blurY = Math.random() *( _turning ? 30 : 3);
			filters = new Array(gf,bf);
			
		}
		
		public function update():void 
		{
			_framesLeast--;
			_end = new b2Vec2(0, _tipSpeed); //MIHAILO - y koordinata je maksimalna duzina lasera
			var mat:b2Mat22 = new b2Mat22();
			mat.Set(_angle);
			_end.MulM(mat);
			_end.Add(_start);
			var t:b2Vec2 = _end.Copy();
			
			_contacts = [];
			
			
			
			var startOffset:b2Vec2 = new b2Vec2(0, 8.5/Global.RATIO);
			startOffset.MulM(mat);
			
			var rayCastStart:b2Vec2 = _start.Copy();
			rayCastStart.Add(startOffset);
			
			graphics.lineStyle(2, 0x00FF00, 1);//0x00F2FF > plavo
			graphics.moveTo(rayCastStart.x * Global.RATIO, rayCastStart.y * Global.RATIO);
			graphics.lineTo(_end.x * Global.RATIO, _end.y * Global.RATIO);
			
			var fixt:b2Fixture;
			
			

			
			Global.world.RayCast(Callback, rayCastStart, t);
			var burning:Boolean = false;

			for (var i:int = 0; i < _contacts.length; i++)
			{
				if (Functions.GetDistanceBetweenB2Vec2(_start, _contacts[i][0]) < Functions.GetDistanceBetweenB2Vec2(_start, _end))
				{				
					var usrdata = b2Fixture(_contacts[i][1]).GetBody().GetUserData();

					if(usrdata is PlayerActor)
					if (Global.player == null)
						continue;
					
					if ( usrdata is Bullet)
						continue;
				    
					_end = _contacts[i][0];
					fixt = _contacts[i][1];
					_tipSpeed = -1 * Functions.GetDistanceBetweenB2Vec2(_start, _end);
					burning = true;
				}
			}

			if (fixt != null)
			{
				var usrdata = fixt.GetBody().GetUserData();
				
				if ( usrdata != null)
				{
					if (usrdata is WalkingActor)
					{
						if (usrdata is PlayerActor)
						{
							if (_end.x > PlayerActor(usrdata)._body.GetPosition().x)
								PlayerActor(usrdata).dieToTheRight = -1;
								else
								PlayerActor(usrdata).dieToTheRight = 1;
						}
						
						WalkingActor(usrdata).UpdateHealthBy( -1);
					}
				}
			}
			
			if (burning)
			{
				if (_sparks == null)
				{//create sparks
					_sparks = new LaserSparksPS(this.parent, new b2Vec2(_end.x * Global.RATIO, _end.y * Global.RATIO));
					
					Global.currentLevel._allParticleSystems.push(_sparks);
					//Level(TankGame.currentState)._allParticleSystems.push(_sparks);
					//_smoke = new SmokeThrusterPS(this.parent,new b2Vec2(end.x * Global.RATIO, end.y * Global.RATIO),10, 0.5, 1.15, 0.03, 7, 0.4, 5);	
					//Level(TankGame.currentState)._allParticleSystems.push(_smoke);
				}
				else
				{//set sparks position
					_sparks._position.Set(_end.x * Global.RATIO, _end.y * Global.RATIO);
				}
			}
			else if (_sparks != null)
			{//destroy sparks
				_sparks._destroy = true;
				_sparks = null;
			}
			
			draw(mat, _start, _end, burning);
			_burning = burning;
			
			_flow._start = _start;
			_flow._end = _end;
			_flow._canvas.x = _start.x * Global.RATIO + startOffset.x;
			_flow._canvas.y = _start.y * Global.RATIO + startOffset.y;
			_flow._canvas.rotation = mat.GetAngle() * 180 / Math.PI;
			
			_tipSpeed -= _laserGrowthSpeed;
			
			if (_framesLeast <= 0)
				destroy();
		}
		
		public function shoot(start:b2Vec2,angle:Number)
		{
			_framesLeast = 3;
			_start = start;
			
			_turning = Math.abs(_angle - angle) > 0.05;
			
			_angle = angle;
		}
		
		function Callback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number ):Number
		{
			_contacts.push([point,fixture]);
			return 1;
		}
		
		function draw(matrix:b2Mat22, start:b2Vec2, end:b2Vec2, burning:Boolean = false)
		{
			
			graphics.clear();
			
			var ar:Array = [0.8, 16];
			
			
			
			
			//if (burning)
			//{
				//graphics.lineStyle(0, 0, 0);
				
				//var mat:Matrix = new Matrix();
				//mat.createGradientBox(30, 30, 0, -15, -15);
				//mat.createGradientBox(30, 30, 0, end.x * Global.RATIO - 15, end.y * Global.RATIO - 15);
				
				//graphics.beginGradientFill(GradientType.RADIAL, [0xFF8083, 0xFF0006], [1, 0.3], [0, 210], mat, "pad");
				//graphics.drawCircle(55, 50, 200);
				//graphics.drawCircle(end.x * Global.RATIO, end.y * Global.RATIO, 8);
				//graphics.endFill();
			//}
			
			//Svetla Crvena
			graphics.lineStyle(13, LaserColours[0], 0.35);//0x00F2FF > plavo
			graphics.moveTo(start.x * Global.RATIO, start.y * Global.RATIO);
			graphics.lineTo(end.x * Global.RATIO, end.y * Global.RATIO);
			
			//Glavna Crvena
			graphics.lineStyle(7, LaserColours[0], 0.85);//0x00F2FF > plavo
			graphics.moveTo(start.x * Global.RATIO, start.y * Global.RATIO);
			graphics.lineTo(end.x * Global.RATIO, end.y * Global.RATIO);
			
			//BELE LINIJE POCETAK
			graphics.lineStyle(4, LaserColours[1], 0.55);//0x00F2FF > plavo
			graphics.moveTo(start.x * Global.RATIO, start.y * Global.RATIO);
			graphics.lineTo(end.x * Global.RATIO, end.y * Global.RATIO);
			
			graphics.lineStyle(1, LaserColours[1], 1)
			graphics.moveTo(start.x * Global.RATIO, start.y * Global.RATIO);
			graphics.lineTo(end.x * Global.RATIO, end.y * Global.RATIO);
			//BELE LINIJE KRAJ
			
			
			
			
			//graphics.moveTo(start.x * Global.RATIO, start.y * Global.RATIO);
			//graphics.curveTo(curX,curY,end.x * Global.RATIO, end.y * Global.RATIO);
			

			
			
			
		    //graphics.drawCircle(0, 0, 50);
		}
		
		public function destroy()
		{
			//trace("Laser Destroyed");
			_flow._destroy = true;
			removeEventListener(Event.ENTER_FRAME, update);
			this.parent.removeChild(this);
			if (_sparks != null)
				_sparks._destroy = true;
		}	
	}
}

//MIHSER LINIJE NEKAD
//graphics.lineStyle(3, 0xFFFFFF,0.5);
			//
			//var c1:b2Vec2 = new b2Vec2( -ar[0], _tipSpeed / ar[1]);
			//c1.MulM(matrix);
			//c1.Add(start);
			
			//graphics.moveTo(start.x * Global.RATIO, start.y * Global.RATIO);
			//graphics.curveTo(c1.x * Global.RATIO, c1.y * Global.RATIO
							//,end.x * Global.RATIO, end.y * Global.RATIO);
							//
			//c1 = new b2Vec2(ar[0], _tipSpeed / ar[1]);
			//c1.MulM(matrix);
			//c1.Add(start);
			//
			//graphics.moveTo(start.x * Global.RATIO, start.y * Global.RATIO);
			//graphics.curveTo(c1.x * Global.RATIO, c1.y * Global.RATIO
			//,end.x * Global.RATIO, end.y * Global.RATIO);