package com.grantech.panels
{
	import feathers.controls.Screen;
	import starling.extensions.PDParticleSystem;
	import com.grantech.managers.DataManager;
	import com.grantech.models.ParticleDataModel;
	import starling.display.Quad;
	import starling.display.Image;
	import starling.events.Event;

	public class ScenePanel extends Screen
	{
		private var particleSystemsCollection:Vector.<PDParticleSystem>;

		public function ScenePanel()
		{
			super();
			this.particleSystemsCollection = new Vector.<PDParticleSystem>;
		}

		override protected function initialize():void
		{
			super.initialize();
			this.name = "ScenePanel";

			DataManager.instance.addEventListener("particleLayerAdded", dataManager_particleLayerAddedHandler);
		}

		protected function particleFromDataModel(dataModel:ParticleDataModel):PDParticleSystem
		{
			var particleSystem:PDParticleSystem = new PDParticleSystem(dataModel, dataModel.texture);
			return particleSystem;
		}

		protected function dataManager_particleLayerAddedHandler(event:Event):void
		{
			var particleSystem:PDParticleSystem = particleFromDataModel(DataManager.instance.layers.getItemAt(event.data.selectedIndex) as ParticleDataModel);
			this.addChild(particleSystem);
		}
	}
}