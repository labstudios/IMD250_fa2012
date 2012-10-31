package com.stickmarines
{
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	
	public class Hero extends MovieClip
	{
		private static const HANG_TIME:Number = 36;
		private static const LOW_ANGLE:Number = -50;
		private static const HIGH_ANGLE:Number = 65;
		private static const ARM_LENGTH:Number = 36;
		
		private static var _hero:Hero;
		private var _up:Boolean = false;
		private var _down:Boolean = false;
		private var _left:Boolean = false;
		private var _right:Boolean = false;
		private var _shoot:Boolean = false;
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
			var shoulder:Point;
			var vx:Number;
			var vy:Number;
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
			
			//point the arm at the mouse pointer
			shoulder = new Point(this.x + this.arm.x, this.y + this.arm.y);
			vx = -Math.abs( shoulder.x - Game.instance.mouseX);
			vy = shoulder.y - Game.instance.mouseY;
			this.arm.rotation = (Math.atan2(vy, vx) * 180 / Math.PI) + 180;
			this.arm.rotation = this.arm.rotation < LOW_ANGLE  ? LOW_ANGLE:this.arm.rotation;
			this.arm.rotation = this.arm.rotation > HIGH_ANGLE  ? HIGH_ANGLE:this.arm.rotation;
			
			this.shoot ? this.fire():null;
		}
		
		public function fire():void
		{
			var shoulder:Point;
			var vx:Number;
			var vy:Number;
			var rot:Number = this.arm.rotation;
			shoulder = new Point(this.x + this.arm.x, this.y + this.arm.y);
			if (this.scaleX < 0)
			{
				vx = Math.abs( shoulder.x - Game.instance.mouseX);
				vy = shoulder.y - Game.instance.mouseY;
				rot = (Math.atan2(vy, vx) * 180 / Math.PI) + 180;
			}
			
			new Bullet(shoulder.x  +  Math.cos(rot * Math.PI / 180) * ARM_LENGTH, 
								shoulder.y +  Math.sin(rot * Math.PI / 180) * ARM_LENGTH, 
								rot);
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
		
		public function set shoot(b:Boolean):void
		{
			this._shoot = b;
		}
		
		public function get shoot():Boolean
		{
			return this._shoot;
		}
		
		public function get arm():MovieClip
		{
			//return this.getChildByName("_arm") as MovieClip; //proper
			return this["_arm"] as MovieClip; //might be faster
		}
	}
}