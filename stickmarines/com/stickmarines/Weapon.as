package com.stickmarines
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Weapon extends Sprite
	{
		protected static var _weapons:Vector.<Weapon> = new Vector.<Weapon>();
		protected var _shotSpace:int = 0;
		protected var weaponSpace:int = 10;
		
		public function Weapon():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.added);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.removed);
		}
		
		protected function added(e:* = null):void
		{
			weapons.push(this);
		}
		
		protected function removed(e:* = null):void
		{
			for (var i:int = 0; i < weapons.length;++i)
			{
				if (weapons[i] == this)
				{
					weapons.splice(i, 1);
					break;
				}
			}
			this.removeEventListener(Event.ADDED_TO_STAGE, this.added);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, this.removed);
		}
		
		public function grabWeapon():Weapon
		{
			if (this.parent)
			{
				this.parent.removeChild(this);
			}
			return this; 
		}
		
		public function fire(character:Hero):void
		{
			if (this.shotSpace > 0)
			{
				return;
			}
			var shoulder:Point;
			var vx:Number;
			var vy:Number;
			var rot:Number = character.arm.rotation;
			this.shotSpace = this.weaponSpace;
			shoulder = new Point(character.x + character.arm.x, character.y + character.arm.y);
			if (character.scaleX < 0)
			{
				vx = Math.abs( shoulder.x - Game.instance.mouseX);
				vy = shoulder.y - Game.instance.mouseY;
				rot = (Math.atan2(vy, vx) * 180 / Math.PI) + 180;
			}
			
			new Bullet(shoulder.x  +  Math.cos(rot * Math.PI / 180) * Hero.ARM_LENGTH, 
								shoulder.y +  Math.sin(rot * Math.PI / 180) * Hero.ARM_LENGTH, 
								rot);
		}
		
		public function set shotSpace(n:int):void
		{
			if (n < 0)
			{
				this._shotSpace = 0;
				return;
			}
			
			this._shotSpace = n;
		}
		
		public function get shotSpace():int
		{
			return this._shotSpace;
		}
		
		public static function get weapons():Vector.<Weapon>
		{
			return _weapons;
		}
	}
}