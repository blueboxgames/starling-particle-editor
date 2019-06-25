package com.grantech.panels
{
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;

	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class SidebarPanel extends ScrollContainer
	{
		public function SidebarPanel()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, sidebarPanel_addedToStageHandler);
		}

		private function sidebarPanel_addedToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, sidebarPanel_addedToStageHandler);
			this.height = this.stage.stageHeight;
			this.addEventListener(ResizeEvent.RESIZE, sidebarPanel_resizeHandler);
		}

		private function sidebarPanel_resizeHandler(e:Event):void
		{
			this.height = this.stage.stageHeight;
		}

		override protected function initialize():void
		{
			super.initialize();
			var containerLayout:VerticalLayout = new VerticalLayout();
			containerLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			containerLayout.verticalAlign = VerticalAlign.JUSTIFY;
			this.layout = containerLayout;
			var inspectorPanel:InspectorPanel = new InspectorPanel();
			inspectorPanel.layoutData = new VerticalLayoutData(NaN, 60);
			this.addChild(inspectorPanel);

			var layersPanel:LayersPanel = new LayersPanel();
			layersPanel.layoutData = new VerticalLayoutData(NaN, 40);
			this.addChild(layersPanel);
		}
	}
}