package com.stickmarines
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import com.Master;
	
	public class Game extends Sprite
	{
		public static const STAGE_RIGHT:Number = 600;
		public static const STAGE_LEFT:Number = 75;
		public static const STAGE_WIDTH:Number  = 800;
		public static const STAGE_HEIGHT:Number = 450;
		private static var _game:Game;
		
		
		public function Game():void
		{
			_game = this;
			this.focusRect = false;
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			this.addEventListener(KeyboardEvent.KEY_DOWN, this.keyPressed);
			this.addEventListener(KeyboardEvent.KEY_UP, this.keyReleased);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
		}
		
		private function init(e:* = null):void
		{
			this.stage.focus = this;
			this.addEventListener(Event.ENTER_FRAME, this.run);
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, this.mouseUp);
		}
		
		private function keyPressed(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.W:
				case Keyboard.UP:
					Hero.instance.up = true;
				break;
				case Keyboard.S:
				case Keyboard.DOWN:
					Hero.instance.down = true;
				break;
				case Keyboard.A:
				case Keyboard.LEFT:
					Hero.instance.left = true;
				break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					Hero.instance.right = true;
				break;
				default:
					//just ignore it
				break;
			}
		}
		
		private function keyReleased(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.W:
				case Keyboard.UP:
					Hero.instance.up = false;
				break;
				case Keyboard.S:
				case Keyboard.DOWN:
					Hero.instance.down = false;
				break;
				case Keyboard.A:
				case Keyboard.LEFT:
					Hero.instance.left = false;
				break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					Hero.instance.right = false;
				break;
				default:
					//just ignore it
				break;
			}
		}
		
		private function run(e:* = null):void
		{
			this.stage.focus = this;
			Hero.instance.run();
			for (var i:int = 0; i < Bullet.bullets.length;++i)
			{
				Bullet.bullets[i].run();
			}
			
			if (Hero.instance.globalX > STAGE_RIGHT)
			{
				this.x -= (Hero.instance.globalX - STAGE_RIGHT);
			}
			
			for (i = 0; i < Enemy.enemies.length;++i)
			{
				Enemy.enemies[i].run();
			}
			
			if (EndMarker.instance && EndMarker.instance.globalX < STAGE_RIGHT)
			{
				this.x += STAGE_RIGHT - EndMarker.instance.globalX;
			}
			
			if (Hero.instance && EndMarker.instance && Hero.instance.x >= EndMarker.instance.x)
			{
				Master.instance.navToEnd();
				return;
			}
		}
		
		private function destroy(e:* = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			this.removeEventListener(KeyboardEvent.KEY_DOWN, this.keyPressed);
			this.removeEventListener(KeyboardEvent.KEY_UP, this.keyReleased);
			this.removeEventListener(Event.ENTER_FRAME, this.run);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUp);
			
			_game = null;
			Bullet.clear();
			Enemy.clear();
			Platform.clear();
			Hero.clear();
			Weapon.clear();
		}
		
		private function mouseDown(e:* = null):void
		{
			Hero.instance.shoot = true;
		}
		
		private function mouseUp(e:* = null):void
		{
			Hero.instance.shoot = false;
		}
		
		public static function get instance():Game
		{
			return _game;
		}
	}
}