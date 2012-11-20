package com.stickmarines
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Character extends MovieClip
	{
		protected var speed:Number = 3;
		protected var fallSpeed:Number = 0;
		protected var gravity:Number = 0.75;
		protected var dead:Boolean = false;
		
		public function Character():void
		{
			
		}
		
		public function run():void
		{
			//polymorphosize
		}
		
		public function get myPlatform():Platform
		{
			var ret:Platform = null;
			if (this.fallSpeed < 0)
			{
				return null;
			}
			for (var i:int = 0; i < Platform.platforms.length;++i)
			{
				if (Platform.platforms[i].hitTestPoint(this.globalX, this.globalY))
				{
					ret = Platform.platforms[i];
					break;
				}
			}
			return ret;
		}
		
		public function get globalX():Number
		{
			var globalPoint = this.localToGlobal(new Point());
			return globalPoint.x;
		}
		
		public function get globalY():Number
		{
			var globalPoint = this.localToGlobal(new Point());
			return globalPoint.y;
		}
	}
}