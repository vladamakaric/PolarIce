package  
{
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class CannonBall extends Actor
	{
		
		public function CannonBall(position:b2Vec2, velForce:b2Vec2) 
		{
			super(new Djole());
			_body = Functions.CircleGenerator(position, _costume.width / 2, 7, 0, 0);
			_body.SetUserData(this);
			_body.SetBullet(true);
			_body.ApplyImpulse(velForce, _body.GetWorldCenter());
			_body.ApplyForce(new b2Vec2(0,-33.2 * _body.GetMass()),  _body.GetWorldCenter());
			//_body.SetLinearDamping(2);
			
			Global.gameCanvas.addChild(_costume);
		}
		
		public function destroyWithPS(contact:b2Contact)
		{
			Global.GAME.ExplosionSound.play();
			_destroy = true;

			var man:b2WorldManifold = new b2WorldManifold();
			contact.GetWorldManifold(man);
			
			var position:b2Vec2 = new b2Vec2(man.m_points[0].x, man.m_points[0].y);

			Functions.MultiplyB2Vec2ByRatio(position);
			Global.currentLevel.addCannonBallExplosion(position, 1.5);	
			
		}
	}

}