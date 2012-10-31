package com.stickmarines
{
	import flash.display.Sprite;
	
	public class Bullet extends Sprite
	{
		private static var _bullets:Vector.<Bullet> = new Vector.<Bullet>();
		protected var speed:Number = 14;
		protected var vx:Number = 0;
		protected var vy:Number = 0;
		protected var ttl:Number = 36;
		
		public function Bullet(x:Number = 0, y:Number = 0, rotation:Number = 0):void
		{
			this.x = x;
			this.y = y;
			this.rotation = rotation;
			this.vx = Math.cos(this.rotation * Math.PI / 180) * speed;
			this.vy = Math.sin(this.rotation * Math.PI / 180) * speed;
			Game.instance.addChild(this);
			bullets.push(this);
			this.ttl = this.stage.frameRate * 1.5;
		}
		
		public function run():void
		{
			this.x += this.vx;
			this.y += this.vy;
			this.ttl--;
			if (this.ttl <= 0)
			{
				this.killMe();
			}
			
			for (var i:int = 0; i < Platform.platforms.length;++i)
			{
				if (this.hitTestObject(Platform.platforms[i]))
				{
					this.killMe();
					break;
				}
			}
		}
		
		public function killMe():void
		{
			for (var i:int = 0; i < bullets.length; ++i )
			{
				if (bullets[i] == this)
				{
					bullets.splice(i, 1);
					break;
				}
			}
			
			Game.instance.removeChild(this);
		}
		
		public static function get bullets():Vector.<Bullet>
		{
			return _bullets;
		}
	}
	
}