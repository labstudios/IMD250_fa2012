package com.stickmarines
{
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	
	public class Hero extends MovieClip
	{
		private static const HANG_TIME:Number = 36;
		private static var _hero:Hero;
		private var _up:Boolean = false;
		private var _down:Boolean = false;
		private var _left:Boolean = false;
		private var _right:Boolean = false;
		private var speed:Number = 3;
		private var fallSpeed:Number = 0;
		private var gravity:Number = 0.75;
		private var jumpSpeed:Number = -15;
		
		
		public function Hero():void
		{
			_hero = this;
		}
		
		public function run():void
		{
			if (this.right)
			{
				this.x += this.speed;
				this.myPlatform ? this.gotoAndStop("running"):null;
				TweenLite.to(this, 0.5, {scaleX: 1 } );
			}
			if (this.left)
			{
				this.x -= this.speed;
				this.myPlatform ? this.gotoAndStop("running"):null;
				TweenLite.to(this, 0.5, {scaleX: -1 } );
			}
			if (this.up)
			{
				this.gotoAndStop("standing");
			}
			
			if ((!this.left && !this.right) || (this.left && this.right))
			{
				this.gotoAndStop("standing");
			}
			
			if (!this.myPlatform)
			{
				this.fallSpeed += this.gravity;
				if (!this.up && this.fallSpeed < 0)
				{
					this.fallSpeed += this.gravity;
				}
			}
			else if(this.myPlatform)
			{
				this.fallSpeed = 0;
			}
			
			this.y += this.fallSpeed;
		}
		
		public static function get instance():Hero
		{
			return _hero;
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
				if (Platform.platforms[i].hitTestPoint(this.x, this.y))
				{
					ret = Platform.platforms[i];
					break;
				}
			}
			return ret;
		}
		
		public function set up(b:Boolean):void
		{
			this._up = b;
			if (b && this.myPlatform)
			{
				this.fallSpeed = this.jumpSpeed;
			}
		}
		
		public function get up():Boolean
		{
			return this._up;
		}
		
		public function set left(b:Boolean):void
		{
			this._left = b;
		}
		
		public function get left():Boolean
		{
			return this._left;
		}
		
		public function set right(b:Boolean):void
		{
			this._right = b;
		}
		
		public function get right():Boolean
		{
			return this._right;
		}
		
		public function set down(b:Boolean):void
		{
			this._down = b;
		}
		
		public function get down():Boolean
		{
			return this._down;
		}
	}
}