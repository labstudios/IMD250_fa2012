package com.stickmarines
{
	import flash.display.Sprite;
	
	public class Platform extends Sprite
	{
		private static var _platforms:Vector.<Platform> = new Vector.<Platform>();
		
		public function Platform():void
		{
			_platforms.push(this);
		}
		
		public static function get platforms():Vector.<Platform>
		{
			return _platforms;
		}
		
		public static function set platforms(v:Vector.<Platform>):void
		{
			_platforms = v;
		}
	}
}