package panels
{
	import component.FileLoader;

	import feathers.controls.Panel;

	import starling.events.Event;
	import starling.events.ResizeEvent;
	import feathers.controls.EditableSlider;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.AnchorLayout;
	import feathers.layout.VerticalLayout;
	import starling.extensions.PDParticleSystem;

	public class ToolsPanel extends Panel
	{
		public function ToolsPanel()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, toolsPanel_onAddedToStage);
			this.addEventListener("particleData", toolsPanel_particleDataHandler);
		}

		override protected function initialize():void
		{
			super.initialize();
			this.title = "Tools Panel";
		}

		override protected function draw():void
		{
			super.draw();
			this.width = 0.3 * this.stage.stageWidth;
			this.height = this.stage.stageHeight - (this.header.height);
		}

		private function toolsPanel_onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, toolsPanel_onAddedToStage);
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
			this.invalidate(INVALIDATION_FLAG_SIZE);
		}

		private function toolsPanel_particleDataHandler(e:Event):void
		{
			var container:ScrollContainer = new ScrollContainer();
			var ps:PDParticleSystem = e.data as PDParticleSystem; 
			container.layout = new VerticalLayout();
			
			var xPosChanger:EditableSlider = new EditableSlider();
			xPosChanger.minimum = 0;
			xPosChanger.maximum = Infinity;
			xPosChanger.step = 1;
			xPosChanger.value = ps.x;
			xPosChanger.validate();
			xPosChanger.addEventListener(Event.CHANGE, function(e:Event):void
			{
				ps.x = xPosChanger.value;
				dispatchEventWith("particleChange", false, ps);
			});

			container.addChild(xPosChanger);

			var yPosChanger:EditableSlider = new EditableSlider();
			yPosChanger.minimum = 0;
			yPosChanger.maximum = Infinity;
			yPosChanger.step = 1;
			yPosChanger.value = ps.y;
			yPosChanger.validate();
			yPosChanger.addEventListener(Event.CHANGE, function(e:Event):void
			{
				ps.y = yPosChanger.value;
				dispatchEventWith("particleChange", false, ps);
			});

			container.addChild(yPosChanger);

			var greenStart:EditableSlider = new EditableSlider();
			greenStart.minimum = 0;
			greenStart.maximum = 1;
			greenStart.step = 0.01;
			greenStart.value = ps.startColor.green;
			greenStart.validate();
			greenStart.addEventListener(Event.CHANGE, function(e:Event):void
			{
				ps.startColor.green = greenStart.value;
				dispatchEventWith("particleChange", false, ps);
			});

			container.addChild(greenStart);

			container.y = 32;
			this.addChild(container);
		}
	}
}