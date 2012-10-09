package com
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Ball extends Sprite
	{
		private static const TOP_WALL:Number = 0;
		private static const BOTTOM_WALL:Number = 400;
		private static const LEFT_WALL:Number = 0;
		private static const RIGHT_WALL:Number = 550;
		private var goingUp:Boolean = false;
		private var goingRight:Boolean = false;
		private var speed:Number = 5;
		
		public function Ball():void
		{
			this.addEventListener(Event.ENTER_FRAME, this.moveBall);
		}
		
		public function moveBall(e:* = null):void
		{
			if(this.goingUp)
			{
				this.y -= this.speed;
			}
			else
			{
				this.y += this.speed;
			}
			if(this.goingRight)
			{
				this.x += this.speed;
			}
			else
			{
				this.x -= this.speed;
			}
			
			if(this.bottom() > BOTTOM_WALL)
			{
				this.goingUp = true;
			}
			if(this.top() < TOP_WALL)
			{
				this.goingUp = false;
			}
			
			if(this.left() < LEFT_WALL)
			{
				this.goingRight = true;
			}
			if(this.right() > RIGHT_WALL)
			{
				this.goingRight = false;
			}
		}
		
		public function top():Number
		{
			return this.y - (this.height/2);
		}
		
		public function bottom():Number
		{
			return this.y + (this.height/2);
		}
		
		public function left():Number
		{
			return this.x - (this.width/2);
		}
		
		public function right():Number
		{
			return this.x + (this.width/2);
		}
	}
}