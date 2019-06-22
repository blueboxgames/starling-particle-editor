package panels
{
	import component.FileLoader;

	import feathers.controls.EditableSlider;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalLayout;

	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.extensions.PDParticleSystem;

	import utils.Localizations;

	public class SidebarPanel extends Panel
	{
		public function SidebarPanel()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, sidebarPanel_onAddedToStage);
			this.addEventListener("particleData", sidebarPanel_particleDataHandler);
		}

		override protected function initialize():void
		{
			super.initialize();
			this.minWidth = 200;
			this.title = Localizations.instance.get("toolbar");
		}

		private function sidebarPanel_onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, sidebarPanel_onAddedToStage);
			this.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			
			/**
			 * FileLoader Must be added to toolbar.
			 */
			fileLoader();
		}

		protected function fileLoader():void
		{
			var particleDataLoader:FileLoader = new FileLoader();
			particleDataLoader.label = "File";
			particleDataLoader.addEventListener(Event.COMPLETE, particleDataLoader_completeHandler);
			this.addChild(particleDataLoader);
			particleDataLoader.validate();
		}

		private function particleDataLoader_completeHandler(e:Event):void
		{
			this.dispatchEventWith(Event.COMPLETE, false, e.data);
		}

		private function stage_resizeHandler(e:ResizeEvent):void
		{
			this.width = e.width * 0.3;
			// autoHideIfNeeded();
		}

		// private function autoHideIfNeeded():void
		// {
		// 	if(this.width < this.explicitMinWidth)
		// 	{
		// 		this.visible = false;
		// 	}
			
		// 	if(this.width > this.explicitMinWidth)
		// 	{
		// 		this.visible = true;
		// 	}
		// }

		private function sidebarPanel_particleDataHandler(e:Event):void
		{
			var container:ScrollContainer = new ScrollContainer();
			var ps:PDParticleSystem = e.data as PDParticleSystem;
			var coutainerLayout:VerticalLayout = new VerticalLayout();
			coutainerLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			container.layout = coutainerLayout;

			var xPosChange:LayoutGroup = new LayoutGroup();
			xPosChange.backgroundSkin = new Quad(1, 1);
			xPosChange.height = 100;
			container.addChild(xPosChange);

			this.addChild(container);
		}
	}
}