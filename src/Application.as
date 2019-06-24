package
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowRenderMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import starling.core.Starling;

	public class Application extends Sprite
	{
		private var _window:NativeWindow;
		private var _starling:Starling;
		private var _viewPort:Rectangle;

		public function Application()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.frameRate = 60;
			this.stage.stageWidth = 800;
			this.stage.stageHeight = 600;
			this.stage.nativeWindow.addEventListener(Event.RESIZE, stage_resize);
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}

		private function loaderInfo_completeHandler(e:Event):void
		{
			this._viewPort = new Rectangle(0,0, 800, 600);
			this.loaderInfo.removeEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			this._starling = new Starling(Main, this.stage, _viewPort);
			this._starling.addEventListener("rootCreated", display_rootCreatedHandler);
			this._starling.supportHighResolutions = true;
			this._starling.skipUnchangedFrames = true;
			this._starling.start();
		}

		private function display_rootCreatedHandler(evnet:*):void
		{
			this.stage.addEventListener("deactivate", stage_deactivateHandler, false, 0, true);
		}

		private function stage_deactivateHandler(event:*):void
		{
			this._starling.stop(true);
			this.stage.frameRate = 0;
			this.stage.addEventListener("activate", stage_activateHandler, false, 0, true);
		}

		private function stage_activateHandler(event:Event):void
    {
      this.stage.removeEventListener("activate", stage_activateHandler);
      this.stage.frameRate = 60;
      this._starling.start();
    }

		private function stage_resize(e:*):void
		{
			// _starling.
		}
	}
}