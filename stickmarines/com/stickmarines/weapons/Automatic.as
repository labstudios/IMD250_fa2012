package com.stickmarines.weapons
{
	import com.stickmarines.Weapon;
	
	public class Automatic extends Weapon
	{
		public function Automatic():void
		{
			this.weaponSpace = 2;
		}
		
		override public function get type():String
		{
			return "Automatic";
		}
	}
}