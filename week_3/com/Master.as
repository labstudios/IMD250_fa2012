package com
{
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.FrameListener;
	
	public class Master extends MovieClip
	{
		protected var perc:Number = 0; //precent loaded
		protected var frameListener:FrameListener;
		
		public function Master():void
		{
			stop();
			
			this.frameListener = new FrameListener(this);
			this.frameListener.addListener("landing", this.buildLanding);
			this.frameListener.addListener("instructions", this.buildInstructions);
			this.frameListener.addListener("game", this.buildGame);
			this.frameListener.addListener("end", this.buildEnd);
			
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.updatePerc);
			this.loaderInfo.addEventListener(Event.COMPLETE, ready);
		}
		
		//Loading functions
		protected function updatePerc(e:ProgressEvent):void
		{
			this.perc = e.bytesLoaded/e.bytesTotal;
			trace(this.perc);
		}

		protected function ready(e:* = null):void
		{
			navToLanding();
		}
		
		//Navigation Functions
		public function navToLanding(e:* = null):void
		{
			gotoAndStop("landing");
		}

		public function navToInstructions(e:* = null):void
		{
			gotoAndStop("instructions");
		}

		public function navToGame(e:* = null):void
		{
			gotoAndStop("game");
		}

		public function navToEnd(e:* = null):void
		{
			gotoAndStop("end");
		}
		
		//Builder functions
		
		public function buildLanding():void
		{
			play_btn.addEventListener(MouseEvent.CLICK, navToGame);
			inst_btn.addEventListener(MouseEvent.CLICK, navToInstructions);
		}
		
		public function buildInstructions():void
		{
			play_btn.addEventListener(MouseEvent.CLICK, navToGame);
			back_btn.addEventListener(MouseEvent.CLICK, navToLanding);
		}
		
		public function buildGame():void
		{
			end_btn.addEventListener(MouseEvent.CLICK, navToEnd);
		}
		
		public function buildEnd():void
		{
			home_btn.addEventListener(MouseEvent.CLICK, navToLanding);
		}
	}
}