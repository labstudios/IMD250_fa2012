package com.stickmarines
{
	import flash.display.Sprite;
	
	public class EndMarker extends Marker
	{
		private static var endMarker:EndMarker = null;
		
		public function EndMarker():void
		{
			endMarker = this;
		}
		
		public static function get instance():EndMarker
		{
			return endMarker;
		}
	}
}