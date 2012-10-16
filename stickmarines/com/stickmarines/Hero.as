package com.stickmarines
{
	import flash.display.MovieClip;
	
	public class Hero extends MovieClip
	{
		private static var _hero:Hero;
		
		public function Hero():void
		{
			_hero = this;
		}
		
		public static function get instance():Hero
		{
			return _hero;
		}
	}
}