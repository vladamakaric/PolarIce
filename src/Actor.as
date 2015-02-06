package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author  Vladimir Makaric 2012
	 */
	public class Actor extends EventDispatcher
	{
		public var ID:int;
		var _body:b2Body;
		var _costume:DisplayObject;
		var _destroy:Boolean = false;
		var _preDestroy:Boolean = false;
		var _prevLinearVelocity:b2Vec2;
		var _prevAngularVelocity:Number;
		var _visible:Boolean = false;
		
		public function Actor(myCostume:DisplayObject) 
		{
			Global.globalID++;
			ID = Global.globalID;
			_costume = myCostume;
		}

		public function Reanimate():void
		{
			if (_costume is MovieClip)
			MovieClip(_costume).play();
			
			if (_body == null)
			return;
			
			_body.SetLinearVelocity(_prevLinearVelocity);
			_body.SetAngularVelocity(_prevAngularVelocity);
		}
		
		public function StopAnimation():void
		{
			if (_costume is MovieClip)
			MovieClip(_costume).stop();
			
			if (_body == null)
			return;
			
			_prevAngularVelocity = _body.GetAngularVelocity();
			_prevLinearVelocity = _body.GetLinearVelocity().Copy();
			
		}
		
		protected function updateCostumePositionAndRotation():void  
		{
			_costume.x = _body.GetPosition().x * Global.RATIO;
			_costume.y = _body.GetPosition().y * Global.RATIO;
			 updateRotation();
		}
		
		public function updateRotation():void 
		{
			_costume.rotation = _body.GetAngle() * 180 / Math.PI;
		}
		
		public function childSpecificUpdating():void
		{
			updateCostumePositionAndRotation();
		}
		
		public function update():void
		{
			childSpecificUpdating();
		}
		
		public function GetPixelYCoord():Number
		{
			if (_body == null)
			return _costume.y;
			else
			return _body.GetPosition().y * Global.RATIO;
		}
		
		public function GetPixelPosition(position:b2Vec2):void
		{
			if (_body == null)
			position.Set( _costume.x, _costume.y);
			else
			position.Set( _body.GetPosition().x * Global.RATIO, _body.GetPosition().y * Global.RATIO);
		}
		
		public function preDestroyUpdating():void
		{
			
		}
		
		public function destroy():void
		{
			_costume.parent.removeChild(_costume);
			Global.world.DestroyBody(_body);
		}
		
		public function handleKeyEvents():void
		{
			
		}
	}
}