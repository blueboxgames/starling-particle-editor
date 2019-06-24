package com.grantech.toolgen.view
{
	import com.grantech.toolgen.panels.ScenePanel;
	import com.grantech.toolgen.panels.SidebarPanel;

	import feathers.controls.PanelScreen;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.events.Event;
	import starling.events.ResizeEvent;
	import feathers.controls.Screen;

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
			//this.title = "Integer";

			this.layout = new AnchorLayout();

			this.scenePanel = new ScenePanel();
			this.scenePanel.initializeNow();
			this.leftDock = new SidebarPanel();
			this.leftDock.initializeNow();

			this.scenePanel.layoutData = new AnchorLayoutData(0,NaN,0,0);
			this.leftDock.layoutData = new AnchorLayoutData(0,0,0);
			
			leftDock.getChildByName("InspectorPanel").addEventListener("particleChange", function(e:Event):void
			{
				scenePanel.dispatchEventWith("particleChange", false, e.data);
			});
			scenePanel.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				leftDock.getChildByName("InspectorPanel").dispatchEventWith("particleData", false, e.data);
			});

			this.addChild(scenePanel);
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

		private function particleDataLoader_completeHandler(e:Event):void
		{
			scenePanel.dispatchEventWith("particleDataRecieved", false, e.data);
		}

	}
}