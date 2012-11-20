package com.stickmarines
{
	import com.greensock.TweenLite;
	
	public class Enemy extends Character
	{
		private static var _enemies:Vector.<Enemy> = new Vector.<Enemy>();
		private static const PLATFORM_PADDING:Number = 10;
		
		public function Enemy()
		{
			_enemies.push(this);
			this.speed = -this.speed;
			this.scaleX = -1;
		}
		
		public static function clear():void
		{
			_enemies = new Vector.<Enemy>();
		}
		
		override public function run():void
		{
			if (this.dead || !this.active)
			{
				return;
			}
			this.x += this.speed;
			this.gotoAndStop("running");
			if (!this.myPlatform)
			{
				this.fallSpeed += this.gravity;
				if (this.fallSpeed < 0)
				{
					this.fallSpeed += this.gravity;
				}
				this.y += this.fallSpeed;
			}
			else
			{
				if (this.x >= this.myPlatform.x + this.myPlatform.width - PLATFORM_PADDING ||
					this.x < this.myPlatform.x + PLATFORM_PADDING)
				{
					this.speed *= -1;
					TweenLite.to(this, 0.5, {scaleX: this.speed > 0 ? 1:-1 } );
				}
				this.fallSpeed = 0;
			}
		}
		
		public function hit():void
		{
			if (this.dead)
			{
				return;
			}
			this.dead = true;
			TweenLite.to(this, 0.5, { alpha: 0, onComplete: this.destroy, delay:0.4 } );
			this.gotoAndPlay("death");
		}
		
		public function destroy():void
		{
			this.stop();
			this.parent.removeChild(this);
			for (var i:int = 0; i < enemies.length;++i)
			{
				if (enemies[i] == this)
				{
					enemies.splice(i, 1);
					break;
				}
			}
		}
		
		public function get active():Boolean
		{
			return Math.abs(this.x - Hero.instance.x ) < Game.STAGE_WIDTH;
		}
		
		public static function get enemies():Vector.<Enemy>
		{
			return _enemies;
		}
	}
}