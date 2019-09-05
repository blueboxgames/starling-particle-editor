package com.grantech.screens
{
	import com.grantech.panels.ScenePanel;
	import com.grantech.panels.SidebarPanel;

	import feathers.controls.Screen;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class MainScreen extends Screen
	{
		static public const NAME:String = "mainScreen";

		public var scenePanel:ScenePanel;
		public var rightDock:SidebarPanel;

		public function MainScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private function addedToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
		}

		override protected function initialize():void
    {
			super.initialize();
			this.name = NAME;

			this.layout = new AnchorLayout();

			this.rightDock = new SidebarPanel();
			this.rightDock.layoutData = new AnchorLayoutData(0,0,0);
			this.rightDock.width = 400;
			this.addChild(rightDock);
			

			this.scenePanel = new ScenePanel();
			this.scenePanel.layoutData = new AnchorLayoutData(0,NaN,0,0);
			this.addChild(scenePanel);
			this.readjustLayout();
		}

		private function stage_resizeHandler(e:Event):void
		{
			this.readjustLayout();
		}

		private function readjustLayout():void
		{
			this.scenePanel.width = stage.stageWidth - this.rightDock.width;
			this.scenePanel.height = stage.stageHeight;
		}
	}
}