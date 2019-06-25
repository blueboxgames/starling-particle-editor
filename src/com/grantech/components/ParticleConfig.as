package com.grantech.components
{
	import feathers.controls.EditableSlider;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalAlign;

	import starling.events.Event;
	import starling.extensions.PDParticleSystem;

	public class ParticleConfig extends LayoutGroup
	{
		public const INVALIDATION_FLAG_LABEL:String = 'labelFactory';
		public const INVALIDATION_FLAG_CONFIG:String = 'configFactory';

		private var label:String;
		private var type:String;
		private var labelComponent:Label;
		private var configComponent:EditableSlider;
		private var particleSystem:PDParticleSystem;

		public function ParticleConfig(label:String, particleSystem:PDParticleSystem, type:String)
		{
			super();
			this.label = label;
			this.type = type;
			this.particleSystem = particleSystem;
		}

		override protected function initialize():void
		{
			var hlayout:HorizontalLayout = new HorizontalLayout();
			hlayout.padding = hlayout.gap = 4;
		//	hlayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			hlayout.verticalAlign = VerticalAlign.JUSTIFY;
			this.layout = hlayout;

			//this.layoutData = new HorizontalLayoutData(90,90);
			createLabel();
			createConfig();
			this.addChild(this.labelComponent);
			this.addChild(this.configComponent);
		}
/* 
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

			// currentLayout.validate();

			this.addChild(currentLayout);
		}
 */
		protected function createLabel():void
		{
			if( this.labelComponent == null )
			{
				this.labelComponent = new Label();
				this.labelComponent.layoutData = new HorizontalLayoutData(100);
			}
			this.labelComponent.text = this.label;
			// this.labelComponent.validate();
		}

		protected function createConfig():void
		{
			if( this.configComponent == null )
			{
				this.configComponent = new EditableSlider();
				this.configComponent.layoutData = new HorizontalLayoutData(100);
				this.configComponent.addEventListener(Event.CHANGE, configComponent_changeHandler);
			}
			
			this.configComponent.minimum = 0;
			this.configComponent.maximum = Infinity;
			this.configComponent.step = 1;
			this.configComponent.value = this.particleSystem.getPropertyAsFloat(this.type);
		}

		private function configComponent_changeHandler(e:Event):void
		{
			this.particleSystem.setProperty(this.type, this.configComponent.value);
		}
	}
}