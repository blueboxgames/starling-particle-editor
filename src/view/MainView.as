package view
{
	import feathers.controls.Screen;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.geom.Rectangle;

	import starling.events.Event;
	import panels.ScenePanel;
	import panels.SidebarPanel;
	import starling.core.Starling;

	public class MainView extends Screen
	{
		static public const NAME:String = "mainView";

		public var scenePanel:ScenePanel;
		public var sidebarPanel:SidebarPanel;

		public function MainView()
		{
			super();
		}

		override protected function initialize():void
    {
			super.initialize();
			this.layout = new AnchorLayout();
			this.layoutData = new AnchorLayoutData(0,0,0,0);

			this.scenePanel = new ScenePanel();
			this.sidebarPanel = new SidebarPanel();

			this.scenePanel.layoutData = new AnchorLayoutData(0,NaN,0,0);
			this.sidebarPanel.layoutData = new AnchorLayoutData(0,0,0);

			/* sidebarPanel.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				scenePanel.dispatchEventWith("particleDataRecieved", false, e.data);
			});
			
			sidebarPanel.addEventListener("particleChange", function(e:Event):void
			{
				scenePanel.dispatchEventWith("particleChange", false, e.data);
			});
			scenePanel.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				sidebarPanel.dispatchEventWith("particleData", false, e.data);
			}); */

			this.addChild(scenePanel);
			this.addChild(sidebarPanel);
			
			this.readjustLayout();
			Starling.current.nativeStage.addEventListener("resize", nativeStage_resizeHandler)
		}

		protected function nativeStage_resizeHandler(event:*):void
		{
			this.readjustLayout();
		}

		private function readjustLayout():void
		{
			var pannelRatio:Number = 0.3;
			trace(stage.stageWidth);
			this.sidebarPanel.width = Math.max(640, stage.stageWidth) * pannelRatio;
			this.scenePanel.width = stage.stageWidth - this.sidebarPanel.width;
		}

	}
}