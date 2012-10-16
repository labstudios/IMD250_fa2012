package com.stickmarines
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Game extends Sprite
	{
		private static var _game:Game;
		
		public function Game():void
		{
			_game = this;
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		
		private function init(e:* = null):void
		{
			trace(Hero.instance);
		}
		
		public static function get instance():Game
		{
			return _game;
		}
	}
}