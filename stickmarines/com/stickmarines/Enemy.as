package com.stickmarines
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	
	public class Enemy extends Character
	{
		private static var _enemies:Vector.<Enemy> = new Vector.<Enemy>();
		private static const PLATFORM_PADDING:Number = 10;
		private var worth:Number = 73;
		
		public function Enemy()
		{
			_enemies.push(this);
			this.speed = -this.speed;
			this.scaleX = -1;
			this.hitSpot.visible = false;
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
			
			if (this.hitSpot.hitTestObject(Hero.instance))
			{
				Hero.instance.hit(this.damage);
			}
		}
		
		override public function hit(n:Number = 0):void
		{
			Hud.instance.score += this.worth;
			super.hit(n);
		}
		
		override public function destroy():void
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
		
		public function get hitSpot():MovieClip
		{
			return this.getChildByName("_hitSpot") as MovieClip;
		}
	}
}