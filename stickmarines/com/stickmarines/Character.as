package com.stickmarines
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.greensock.TweenLite;
	
	public class Character extends MovieClip
	{
		protected var speed:Number = 3;
		protected var fallSpeed:Number = 0;
		protected var gravity:Number = 0.75;
		protected var dead:Boolean = false;
		protected var terminalVelocity:Number = 15;
		protected var _hitPoints:Number = 100;
		protected var damage:Number = 40;
		
		public function Character():void
		{
			
		}
		
		public function run():void
		{
			//polymorphosize
		}
		
		public function hit(n:Number = 0):void
		{
			if (!this.dead)
			{
				this.hitPoints -= n;
				if (this.hitPoints <= 0)
				{
					this.die();
				}
			}
			
		}
		
		public function die():void
		{
			this.dead = true;
			TweenLite.to(this, 0.5, { alpha: 0, onComplete: this.destroy, delay:0.4 } );
			this.gotoAndPlay("death");
		}
		
		public function destroy():void
		{
			//polymorphosize
		}
		
		public function get myPlatform():Platform
		{
			var ret:Platform = null;
			if (this.fallSpeed < 0)
			{
				return null;
			}
			for (var i:int = 0; i < Platform.platforms.length;++i)
			{
				if (Platform.platforms[i].hitTestPoint(this.globalX, this.globalY + this.fallSpeed))
				{
					ret = Platform.platforms[i];
					this.y = ret.top;
					break;
				}
			}
			return ret;
		}
		
		public function get globalX():Number
		{
			var globalPoint = this.localToGlobal(new Point());
			return globalPoint.x;
		}
		
		public function get globalY():Number
		{
			var globalPoint = this.localToGlobal(new Point());
			return globalPoint.y;
		}
		
		public function get hitPoints():Number
		{
			return this._hitPoints;
		}
		
		public function set hitPoints(n:Number):void
		{
			this._hitPoints = n;
		}
	}
}