package com.stickmarines
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.greensock.TweenLite;
	
	public class Hud extends Sprite
	{
		private static var _hud:Hud;
		
		private var _life:Number = 0;
		private var _score:Number = 0;
		
		public function Hud():void
		{
			_hud = this;
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		
		public function init(e:* = null):void
		{
			this.life = 100;
			this.score = 0;
			var wp:Weapon  = new Weapon();
			this.weapon = wp.type;
		}
		
		public static function get instance():Hud
		{
			return _hud;
		}
		
		public function get life():Number
		{
			return this._life;
		}
		
		public function set life(n:Number):void
		{
			this._life = n;
			if (n < 0)
			{
				this._life = 0;
			}
			TweenLite.to(this.lifeBar, 0.5, { scaleX: this._life / 100 } );
		}
		
		public function get score():Number
		{
			return this._score;
		}
		
		public function set score(n:Number):void
		{
			this._score = n;
			this.scoreBox.text = n.toString();
		}
		
		public function get weapon():String
		{
			return this.weaponBox.text;
		}
		
		public function set weapon(s:String):void
		{
			this.weaponBox.text = s;
		}
	}
}