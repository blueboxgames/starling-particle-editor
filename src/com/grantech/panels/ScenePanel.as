package com.grantech.panels
{
	import com.grantech.managers.DataManager;
	import com.grantech.models.ParticleDataModel;

	import feathers.controls.Screen;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public class ScenePanel extends Screen
	{
		[Embed(source="/test.png")]
		private static const BlueflameParticle:Class;
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

		protected function particleFromDataModel(config:ParticleDataModel):PDParticleSystem
		{
			var blueTexture:Texture = Texture.fromEmbeddedAsset(BlueflameParticle);
			var particleSystem:PDParticleSystem = new PDParticleSystem(config, blueTexture);
			particleSystem.x = this.width/2;
			particleSystem.y = this.height/2;
			return particleSystem;
		}

		protected function dataManager_particleLayerAddedHandler(event:Event):void
		{
			var particleSystem:PDParticleSystem = particleFromDataModel(DataManager.instance.layers.getItemAt(event.data.selectedIndex) as ParticleDataModel);
			particleSystem.emitterX = 320;
    	particleSystem.emitterY = 240;
            
      this.addChild(particleSystem);
      Starling.juggler.add(particleSystem);
      particleSystem.start();
		}
	}
}