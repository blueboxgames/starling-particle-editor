package com.grantech.views
{
	import com.grantech.panels.ScenePanel;
	import com.grantech.panels.SidebarPanel;

	import feathers.controls.Screen;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class MainView extends Screen
	{
		static public const NAME:String = "mainView";

		public var scenePanel:ScenePanel;
		public var leftDock:SidebarPanel;

		public function MainView()
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
			this.name = "MainView";

			this.layout = new AnchorLayout();

			this.scenePanel = new ScenePanel();
			this.scenePanel.layoutData = new AnchorLayoutData(0,NaN,0,0);
			this.addChild(scenePanel);

			this.leftDock = new SidebarPanel();
			this.leftDock.layoutData = new AnchorLayoutData(0,0,0);
			this.addChild(leftDock);
			
			this.readjustLayout();
		}

		private function stage_resizeHandler(e:Event):void
		{
			this.readjustLayout();
		}

		private function readjustLayout():void
		{
			this.leftDock.width = stage.stageWidth * 0.4;
			this.scenePanel.width = stage.stageWidth * 0.6;
		}
	}
}