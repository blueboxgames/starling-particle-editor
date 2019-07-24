package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import starling.core.Starling;

	public class Application extends Sprite
	{
		private var starling:Starling;
		private var viewPort:Rectangle;

		public function Application()
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}

		private function loaderInfo_completeHandler(e:Event):void
		{
			this.loaderInfo.removeEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			this.viewPort = new Rectangle(0, 0, stage.stageHeight, stage.stageHeight);
			this.starling = new Starling(Main, this.stage, this.viewPort);
			this.starling.addEventListener("rootCreated", display_rootCreatedHandler);
			this.starling.supportHighResolutions = true;
			this.starling.skipUnchangedFrames = true;
			this.activate();
		}

		private function display_rootCreatedHandler(evnet:*):void
		{
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		private function stage_activateHandler(event:Event):void
    {
			this.activate();
    }
		private function stage_deactivateHandler(event:*):void
		{
			this.deactivate();
		}
    private function stage_resizeHandler(e:Event):void
    {
			this.resize();
    }

		private function activate():void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
      this.stage.frameRate = 60;
      this.starling.start();
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler);
			stage_resizeHandler(null);
    }

		private function deactivate():void
		{
			this.starling.stop(true);
			this.stage.frameRate = 0;
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
			this.stage.removeEventListener(Event.RESIZE, stage_resizeHandler);
		}

		private function resize():void
    {
      this.starling.stage.stageWidth = this.viewPort.width = stage.stageWidth;
      this.starling.stage.stageHeight = this.viewPort.height = stage.stageHeight;
    }
	}
}