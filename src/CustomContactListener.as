package  
{
	//import avmplus.getQualifiedClassName;
	import Box2D.Collision.b2Manifold;
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Vladimir Makaric 2012
	 */
	
	public class CustomContactListener extends b2ContactListener
	{
		public function CustomContactListener() 
		{
			
		}
		
		override public function EndContact(contact:b2Contact):void 
		{
			if (!Functions.AnyContactFixtureIsSensor((contact)))
			{
				var arr:Array;

				arr = Functions.areCollidedBodys_ReturnBodyArray(contact, BuncyPlatform, WalkingActor);
				
				if (arr[0])
				{
					BuncyPlatform(arr[1])._body.GetFixtureList().SetRestitution(0);
					super.BeginContact(contact);
					return;
				}
				
				arr = Functions.areCollidedBodys_ReturnBodyArray(contact, BasicEnemy, PlayerActor);
				
				if (arr[0])
				{
					BasicEnemy(arr[1]).pushedByPlayer = false;
					
					super.BeginContact(contact);
					return;
				}
				
				arr = Functions.areCollidedBodys_ReturnBodyArray(contact, WalkingEnemy, WalkingEnemy);
				
				if (arr[0])
				{
					var className:Class = Object(contact.GetFixtureB().GetBody().GetUserData()).constructor;
					
					if (  contact.GetFixtureA().GetBody().GetUserData() is  className)
					{
						WalkingEnemy(arr[2])._contactNum--;
						WalkingEnemy(arr[1])._contactNum--;
					}
					else
					{
						var basicEnemy:BasicEnemy = Functions.fromTwoObjectsIsOneClass_ReturnNullOrObj(contact.GetFixtureA().GetBody().GetUserData(), contact.GetFixtureB().GetBody().GetUserData(), BasicEnemy);
						
						if (basicEnemy != null)
						{
							basicEnemy._contactNum--;	
						}
					}
				}
				
				super.BeginContact(contact);
				return;
			}
			
			var arr = Functions.areCollidedBodys_ReturnBodyArray(contact, PlayerActor, SpikeStrip);
			
			if (arr[0])
			{
				var pa:PlayerActor = arr[1];
				if(pa.spikeImpalementCounter > 0)
				pa.spikeImpalementCounter--;
				return;
			}
			
			Functions.ProcessGroundedFlagsForWalkingActors(contact, false);
			super.EndContact(contact);
		}

		override public function BeginContact(contact:b2Contact):void 
		{
			if (!Functions.AnyContactFixtureIsSensor((contact)))
			{	
				var arr:Array;
	
				arr = Functions.CollidedBodyIs_RetiturnUDObjectAndOtherFixture(contact, Bullet);
				
				if (arr[0])
				{
					var bullet:Bullet = arr[1];

					bullet.destroyWithPS(contact);

					var otherActor:Actor = b2Fixture(arr[2]).GetBody().GetUserData();
					
					if (otherActor != null)
					{
						if (otherActor is Bullet)
							Bullet(otherActor).destroyWithPS(contact);
							else if (otherActor is CannonBall)
							CannonBall(otherActor).destroyWithPS(contact);
						else					
						if (otherActor is WalkingActor)
						{
							if (otherActor is PlayerActor)
							{
								if (Global.player != null)  /////
								{
									if (!(bullet.parrent is PlayerActor))
									{
										var playerImpulse:b2Vec2 = Functions.GetVectorFromAToB(Bullet(arr[1])._body.GetPosition(), PlayerActor(otherActor)._body.GetPosition());

										playerImpulse.Normalize();
										playerImpulse.Multiply(7.5);
										
										PlayerActor(otherActor)._body.ApplyImpulse(playerImpulse, PlayerActor(otherActor)._body.GetPosition());
										PlayerActor(otherActor).determineSideOfDeathBlow(contact);
										PlayerActor(otherActor).UpdateHealthBy(-1);
									}
								}
								else
									contact.SetSensor(true);
							}
							else
								WalkingActor(otherActor).UpdateHealthBy(-1);
						}
					}

					super.BeginContact(contact);
					return;
				}
				
				arr = Functions.CollidedBodyIs_RetiturnUDObjectAndOtherFixture(contact, CannonBall);
				
				if (arr[0])
				{
					var cannonB:CannonBall = arr[1];
					
					cannonB.destroyWithPS(contact);
					////////////////////////////////////////////////////////////
					
					var otherActor:Actor = b2Fixture(arr[2]).GetBody().GetUserData();
					
					if (otherActor != null)
					{
						if (otherActor is CannonBall)
							CannonBall(otherActor).destroyWithPS(contact);
						else
						if (otherActor is Bullet)
							Bullet(otherActor).destroyWithPS(contact);
						else
						if (otherActor is WalkingActor)
						{
							if (otherActor is PlayerActor)
							{
								if (Global.player != null)  /////
								{
					/*
										var playerImpulse:b2Vec2 = Functions.GetVectorFromAToB(Bullet(arr[1])._body.GetPosition(), PlayerActor(otherActor)._body.GetPosition());

										playerImpulse.Normalize();
										playerImpulse.Multiply(7.5);
										
										PlayerActor(otherActor)._body.ApplyImpulse(playerImpulse, PlayerActor(otherActor)._body.GetPosition());*/
										
										PlayerActor(otherActor).determineSideOfDeathBlow(contact);
										PlayerActor(otherActor).UpdateHealthBy(-1);
								}
								else
									contact.SetSensor(true);
							}
							else
								WalkingActor(otherActor).UpdateHealthBy(-1);
						}
					}

					super.BeginContact(contact);
					return;
				}
				
				arr = Functions.areCollidedBodys_ReturnBodyArray(contact, WalkingEnemy, WalkingEnemy);
			
				if (arr[0])
				{
					var className:Class = Object(contact.GetFixtureB().GetBody().GetUserData()).constructor;
					
					if (  contact.GetFixtureA().GetBody().GetUserData() is  className)
					{
						WalkingEnemy(arr[2])._contactNum++;
						WalkingEnemy(arr[1])._contactNum++;
					}
					else
					{
						var basicEnemy:BasicEnemy = Functions.fromTwoObjectsIsOneClass_ReturnNullOrObj(contact.GetFixtureA().GetBody().GetUserData(), contact.GetFixtureB().GetBody().GetUserData(), BasicEnemy);
						
						if (basicEnemy != null)
						{
							basicEnemy._contactNum++;	
						}
					}
					
					super.BeginContact(contact);
					return;
				}
				

				arr = Functions.CollidedBodyIs_RetiturnUDObjectAndOtherFixture(contact, PlayerActor);
				
				if (arr[0])
				{	
					if (Global.player == null)
					{
						if (!(b2Fixture(arr[2]).GetBody().GetUserData() is FloorActor || b2Fixture(arr[2]).GetBody().GetUserData() is BuncyPlatform))
						{
							contact.SetSensor(true);
							super.BeginContact(contact);
							return;
						}
					}
				}

				arr = Functions.areCollidedBodys_ReturnBodyArray(contact, BasicEnemy, PlayerActor);
				
				if (arr[0])
				{
					var player:PlayerActor = PlayerActor(arr[2]);
					var basicEnemy:BasicEnemy =  BasicEnemy(arr[1]);
						
					if (basicEnemy.spinningCounter || basicEnemy._preDestroy)
					{
						super.BeginContact(contact);	
						return;
					}
						
					var horizCollision:Boolean = true;
					var yDiff = basicEnemy._body.GetPosition().y - player._body.GetPosition().y;

					var yPixelDiff = Math.abs(yDiff) * Global.RATIO;	
					var onTopDiff:Boolean = yPixelDiff > (player._height / 2 + basicEnemy._height / 2) * 0.999;
					
					if (onTopDiff)
					{
						if (yDiff < 0)
						{
							horizCollision = false;
							contact.SetSensor(true);
							//player._destroy = true;	
							player.determineSideOfDeathBlow(contact);
							player.UpdateHealthBy( -1);
						}
						else 
						if (player._body.GetLinearVelocity().y >= 0)
						{
							
							Global.GAME.StompSound.play();
							horizCollision = false;
							basicEnemy._preDestroy = true;
							basicEnemy._body.SetType(b2Body.b2_staticBody);
							basicEnemy._body.GetFixtureList().GetNext().SetRestitution(1.4);
							player.BounceUpAnimation();
						}
					}
					
					if (horizCollision)
					{
						var xDiff = basicEnemy._body.GetPosition().x - player._body.GetPosition().x;
						
						if (xDiff * basicEnemy.orientation < 0)
						{
							contact.SetSensor(true);
							player.determineSideOfDeathBlow(contact);
							player.UpdateHealthBy( -1);
						//	player._destroy = true;
						}
						else
							basicEnemy.pushedByPlayer = true;
					}
					
					super.BeginContact(contact);	
					return;
				}
				
				arr = Functions.areCollidedBodys_ReturnBodyArray(contact, MediumEnemy, PlayerActor);
				
				if (arr[0])
				{
			
					var player:PlayerActor = PlayerActor(arr[2]);
					var mediumEnemy:MediumEnemy =  MediumEnemy(arr[1]);
					
					if (!mediumEnemy._preDestroy)
					{
						var yDiff = mediumEnemy._body.GetPosition().y - player._body.GetPosition().y;

						var yPixelDiff = Math.abs(yDiff) * Global.RATIO;	
						var onTopDiff:Boolean = yPixelDiff > (player._height / 2 + mediumEnemy._height / 2) * 0.99;
						
						if (onTopDiff && player._body.GetLinearVelocity().y >= 0 && mediumEnemy.pursuitOver)
						{
							Global.GAME.StompSound.play();
							
							mediumEnemy._preDestroy = true;
							mediumEnemy._body.SetType(b2Body.b2_staticBody);
							mediumEnemy._body.GetFixtureList().SetRestitution(1.8);
							player.BounceUpAnimation();
						}
						else
						{
							contact.SetSensor(true);
							//player.U
							player.determineSideOfDeathBlow(contact);
							player.UpdateHealthBy( -1);
							
						}
					}
					
					super.BeginContact(contact);	
					return;
				}
				
				arr = Functions.areCollidedBodys_ReturnBodyArray(contact, HardEnemy, PlayerActor);
				
				if (arr[0])
				{
					var player:PlayerActor = PlayerActor(arr[2]);
					var hardEnemy:HardEnemy =  HardEnemy(arr[1]);
					
					if (!hardEnemy._preDestroy)
					{
						var yDiff = hardEnemy._body.GetPosition().y - player._body.GetPosition().y;

						var yPixelDiff = Math.abs(yDiff) * Global.RATIO;	
						var onTopDiff:Boolean = yPixelDiff > (player._height / 2 + hardEnemy._height / 2) * 0.99;
						
						if (onTopDiff && player._body.GetLinearVelocity().y >= 0 && yDiff > 0)
						{
							Global.GAME.StompSound.play();
							
							hardEnemy._preDestroy = true;
							hardEnemy._body.SetType(b2Body.b2_staticBody);
							hardEnemy._body.GetFixtureList().GetNext().SetRestitution(1.65);
							
							player.BounceUpAnimation();
						}
						else
						{
							contact.SetSensor(true);
							player.determineSideOfDeathBlow(contact);
							player.UpdateHealthBy( -1);
							

						}
					}
					
					super.BeginContact(contact);	
					return;
				}
				
				arr = Functions.CollidedBodyIs_RetiturnUDObjectAndOtherFixture(contact, PlayerActor);
				
				if (arr[0])
				{	
					var otherBody:b2Body = b2Fixture(arr[2]).GetBody();
					
					if(otherBody.GetUserData() is FloorActor || otherBody.GetUserData() is BuncyPlatform)
					{
						var player:PlayerActor = PlayerActor(arr[1]);
						var yDiff = otherBody.GetPosition().y - player._body.GetPosition().y;
						var yPixelDiff = Math.abs(yDiff) * Global.RATIO;	
						var onTopDiff:Boolean = yPixelDiff > (player._height / 2 + otherBody.GetFixtureList().GetAABB().GetExtents().y) * 0.99 * Global.RATIO;
						
						var man:b2WorldManifold = new b2WorldManifold();
						contact.GetWorldManifold(man);
						
						if (player._body.GetLinearVelocity().y <= 0 && yDiff <= 0 && man.m_normal.y == -1)
						{
							player.disableJumpAcceleration();
							super.BeginContact(contact);	
							return;
						}
					}
				}

				arr = Functions.areCollidedBodys_ReturnBodyArray(contact, BuncyPlatform, WalkingActor);
				
				if (arr[0])
				{
					var bplatform:BuncyPlatform =  BuncyPlatform(arr[1]);
					var manif:b2WorldManifold = new b2WorldManifold();	
					contact.GetWorldManifold(manif);

					if (manif.m_normal.y == 1)
					{
						
						Global.GAME.BounceSound.play();
						if (arr[2] is PlayerActor)
						{
							PlayerActor(arr[2]).BounceUpAnimation(); 
						}
						
						
						bplatform._body.GetFixtureList().SetRestitution(2.8);
						bplatform.bounceAnimation();
					}
					
					super.BeginContact(contact);	
					return;
				}

				super.BeginContact(contact);	
				return;
			}
			
			var arr = Functions.areCollidedBodys_ReturnBodyArray(contact, PlayerActor, SnowBallCollectible);
			
			if (arr[0])
			{
				var player:PlayerActor =  PlayerActor(arr[1]);
				var SBC:SnowBallCollectible = SnowBallCollectible(arr[2]);	
				
				if (!SBC._preDestroy)
				{
					//Global.GAME.PickUpSound.play();
					SBC._preDestroy = true;
				}
	
				return;
			}
			
			var arr = Functions.areCollidedBodys_ReturnBodyArray(contact, PlayerActor, HeartCollectible);
			
			if (arr[0])
			{
				var player:PlayerActor =  PlayerActor(arr[1]);
				var HC:HeartCollectible = HeartCollectible(arr[2]);	
				
				if (!HC._preDestroy)
				{
					if (player._health == 1 || player._health == 2)
					{
						Global.GAME.HeartCollectSound.play();
						
						HC._preDestroy = true;
						player._health++;
						player.heartCollectedCounter = 1;
					}
				}
	
				return;
			}
			
			var arr = Functions.areCollidedBodys_ReturnBodyArray(contact, PlayerActor, IceCubeCollectable);
			
			if (arr[0])
			{
				var ICC:IceCubeCollectable = IceCubeCollectable(arr[2]);	
				
				if (!ICC._preDestroy)
				{
					if (Global.currentLevel._iceCubesCollected < Global.currentLevel._iceCubesToCollect)
					{
				//		Global.currentLevel._iceCubesCollected++;
				
				
					//	Global.GAME.PickUpSound.play();
						ICC._preDestroy = true;
					}
				}
	
				return;
			}
			
			var arr = Functions.areCollidedBodys_ReturnBodyArray(contact, WalkingActor, SpikeStrip);
			
			if (arr[0])
			{
				var wa:WalkingActor = arr[1];
				
				if (!wa._preDestroy)
				{	
					if (wa is PlayerActor)
					{
						if (Global.player == null)
						{
							PlayerActor(wa).spikeImpalementCounter++;
							return;
						}
						
						
						PlayerActor(wa).determineSideOfDeathBlow(contact);
					}
		
					wa.UpdateHealthBy( -1);
				}
	
				return;
			}
			
			
			Functions.ProcessGroundedFlagsForWalkingActors(contact, true);			
			super.BeginContact(contact);
		}
	}
}