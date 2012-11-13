package com.stickmarines
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Marker extends Sprite
	{
		public function Marker():void
		{
			this.visible = false;
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