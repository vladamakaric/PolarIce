package  
{
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	public class Bullet extends Actor
	{
		var parrent:Actor;
		public function Bullet(prnt:Actor, position:b2Vec2, velimp:b2Vec2) 
		{
			super(new SnowBall());
			parrent = prnt;
			_body = Functions.CircleGenerator(position, _costume.width / 2, 1, 0, 0);
			_body.SetUserData(this);
			_body.SetBullet(true);
			_body.ApplyImpulse(velimp, _body.GetWorldCenter());
			
			
			Global.gameCanvas.addChild(_costume);
		}	
		
		public function destroyWithPS(contact:b2Contact)
		{
			Global.GAME.SnowBallSound.play();
			_destroy = true;
			var man:b2WorldManifold = new b2WorldManifold();
			contact.GetWorldManifold(man);					
			var position:b2Vec2 = new b2Vec2(man.m_points[0].x, man.m_points[0].y);
			var normalVec:b2Vec2 = man.m_normal.Copy();
			if (contact.GetFixtureA().GetBody().GetUserData() == this)
			normalVec.Multiply( -1); //zanimljivo
			Functions.MultiplyB2Vec2ByRatio(position);
			Global.currentLevel.addSnowBallExplosion(position, normalVec, 1);
			
		}
	}

}