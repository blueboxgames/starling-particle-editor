package component
{
	import feathers.core.FeathersControl;
	import feathers.controls.Label;
	import feathers.controls.EditableSlider;
	import starling.extensions.PDParticleSystem;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;

	public class ParticleConfig extends FeathersControl
	{
		public const INVALIDATION_FLAG_LABEL:String = 'labelFactory';
		public const INVALIDATION_FLAG_CONFIG:String = 'configFactory';

		private var label:String;
		private var labelComponent:Label = new Label();
		private var configComponent:EditableSlider;
		private var particleSystem:PDParticleSystem;

		public function ParticleConfig(label:String, particleSystem:PDParticleSystem)
		{
			super();
			this.label = label;
			this.particleSystem = particleSystem;
		}

		protected function reLayout():void
		{
			var labelInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_LABEL);
			var configInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_CONFIG);
			
			var currentLayout:LayoutGroup = new LayoutGroup();
			if(labelInvalid)
			{
				createLabel();
			}
			if(configInvalid)
			{
				createConfig();
			}

			currentLayout.layout = new HorizontalLayout();
			// currentLayout.layoutData = new HorizontalLayoutData(90,90);
			
			currentLayout.addChild(this.labelComponent);
			currentLayout.addChild(this.configComponent);

			currentLayout.validate();

			this.addChild(currentLayout);
		}

		protected function createLabel():void
		{
			if(this.labelComponent)
			{
				this.labelComponent.removeFromParent(true);
				this.labelComponent = null;
			}
			this.labelComponent = new Label();
			this.labelComponent.text = this.label;
			this.labelComponent.validate();
		}

		protected function createConfig():void
		{
			if(this.configComponent)
			{
				this.configComponent.removeFromParent(true);
				this.configComponent = null;
			}
			this.configComponent = new EditableSlider();
			this.configComponent.validate();
		}

		override protected function draw():void
		{
			var layoutInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_LAYOUT);
			if(layoutInvalid)
			{
				this.reLayout();
			}
			super.draw();
		}
	}
}