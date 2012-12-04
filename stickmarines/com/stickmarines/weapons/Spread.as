package com.stickmarines.weapons
{
	import com.stickmarines.*;
	import flash.geom.Point;
	
	public class Spread extends Weapon
	{
		private static const SPREAD:Number = 15;
		
		public function Spread():void
		{
			
		}
		
		override public function fire(character:Hero):void
		{
			if (this.shotSpace > 0)
			{
				return;
			}
			var shoulder:Point;
			var vx:Number;
			var vy:Number;
			var rot:Number = character.arm.rotation;
			var rot2:Number = 0;
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
			rot2 = rot - SPREAD;
			new Bullet(shoulder.x  +  Math.cos(rot2 * Math.PI / 180) * Hero.ARM_LENGTH, 
								shoulder.y +  Math.sin(rot2 * Math.PI / 180) * Hero.ARM_LENGTH, 
								rot2);
			rot2 = rot + SPREAD;
			new Bullet(shoulder.x  +  Math.cos(rot2 * Math.PI / 180) * Hero.ARM_LENGTH, 
								shoulder.y +  Math.sin(rot2 * Math.PI / 180) * Hero.ARM_LENGTH, 
								rot2);
		}
		
		override public function get type():String
		{
			return "Spread";
		}
	}
}