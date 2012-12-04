package com.stickmarines
{
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import com.Master;
	
	public class Hero extends Character
	{
		public static const HANG_TIME:Number = 36;
		public static const LOW_ANGLE:Number = -50;
		public static const HIGH_ANGLE:Number = 65;
		public static const ARM_LENGTH:Number = 36;
		private static const INVINCIBLE_TIME:Number = 24;
		
		private static var _hero:Hero;
		private var _up:Boolean = false;
		private var _down:Boolean = false;
		private var _left:Boolean = false;
		private var _right:Boolean = false;
		private var _shoot:Boolean = false;
		private var jumpSpeed:Number = -15;
		private var weapon:Weapon = new Weapon();
		private var invincibility:Number = 0;
		
		public function Hero():void
		{
			_hero = this;
		}
		
		public static function clear():void
		{
			_hero = null;
		}
		
		override public function run():void
		{
			var shoulder:Point;
			var vx:Number;
			var vy:Number;
			if (this.dead)
			{
				return;
			}
			if (this.right && !this.invincible)
			{
				this.x += this.speed;
				this.myPlatform ? this.gotoAndStop("running"):null;
				if (EndMarker.instance && this.x > EndMarker.instance.x)
				{
					this.x = EndMarker.instance.x;
					this.gotoAndStop("standing");
				}
				
				TweenLite.to(this, 0.5, {scaleX: 1 } );
			}
			if (this.left && !this.invincible)
			{
				this.x -=  this.globalX > Game.STAGE_LEFT ? this.speed:0;
				this.myPlatform ? this.gotoAndStop("running"):null;
				TweenLite.to(this, 0.5, {scaleX: -1 } );
			}
			if (this.up)
			{
				this.gotoAndStop("standing");
			}
			
			if ((!this.left && !this.right) || (this.left && this.right) || this.globalX <= Game.STAGE_LEFT)
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
				this.fallSpeed =  this.fallSpeed > this.terminalVelocity ? this.terminalVelocity:this.fallSpeed;
			}
			else if(this.myPlatform)
			{
				this.fallSpeed = 0;
				this.y = this.myPlatform.top;
			}
			
			this.y += this.fallSpeed;
			
			//point the arm at the mouse pointer
			shoulder = new Point(this.x + this.arm.x, this.y + this.arm.y);
			vx = -Math.abs( shoulder.x - Game.instance.mouseX);
			vy = shoulder.y - Game.instance.mouseY;
			this.arm.rotation = (Math.atan2(vy, vx) * 180 / Math.PI) + 180;
			this.arm.rotation = this.arm.rotation < LOW_ANGLE  ? LOW_ANGLE:this.arm.rotation;
			this.arm.rotation = this.arm.rotation > HIGH_ANGLE  ? HIGH_ANGLE:this.arm.rotation;
			
			this.weapon.shotSpace--;
			this.invincibility--;
			
			if (this.invincible)
			{
				this.alpha = this.alpha < 0.5 ? 1:0.3;
				if (this.scaleX  > 0)
				{
					this.x -= this.speed * 2;
				}
				else
				{
					this.x += this.speed * 2;
				}
			}
			else
			{
				this.alpha = 1;
			}
			this.shoot ? this.weapon.fire(this):null;
			
			for (var i:int = 0; i < Weapon.weapons.length;++i)
			{
				if (Weapon.weapons[i].hitTestObject(this))
				{
					this.weapon = Weapon.weapons[i].grabWeapon();
					break;
				}
			}
			
			if (this.y > Game.STAGE_HEIGHT)
			{
				super.hit((this.y - Game.STAGE_HEIGHT) / this.height);
			}
		}
		
		override public function hit(n:Number = 0):void
		{
			if (!this.invincible)
			{
				super.hit(n);
				this.fallSpeed = this.jumpSpeed /2;
				this.invincibility = INVINCIBLE_TIME;
			}
		}
		
		override public function destroy():void
		{
			Master.instance.navToEnd();
		}
		
		public static function get instance():Hero
		{
			return _hero;
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
		
		public function get invincible():Boolean
		{
			return this.invincibility > 0;
		}
		
		override public function set hitPoints(n:Number):void
		{
			Hud.instance.life = n;
			this._hitPoints = n;
		}
	}
}