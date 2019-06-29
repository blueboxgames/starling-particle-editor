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

		public function ScenePanel()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			this.name = "ScenePanel";
			DataManager.instance.addEventListener("particleLayerAdded", dataManager_particleLayerAddedHandler);
			DataManager.instance.addEventListener("particleLayerRemoved", dataManager_particleLayerRemovedHandler);
		}

		protected function particleFromDataModel(config:ParticleDataModel):PDParticleSystem
		{
			var blueTexture:Texture = Texture.fromEmbeddedAsset(BlueflameParticle);
			var particleSystem:PDParticleSystem = new PDParticleSystem(config, blueTexture);
			// TODO: Handle this when scene has cursor.
			particleSystem.x = this.width/2;
			particleSystem.y = this.height/2;
			return particleSystem;
		}

		protected function dataManager_particleLayerAddedHandler(event:Event):void
		{
			var index:int = event.data.selectedIndex;
			var particleSystem:PDParticleSystem = particleFromDataModel(DataManager.instance.layers.getItemAt(index) as ParticleDataModel);
      this.addChildAt(particleSystem, index);
			Starling.juggler.add(particleSystem);
			particleSystem.start();
		}

		protected function dataManager_particleLayerRemovedHandler(event:Event):void
		{
			var index:int = event.data.selectedIndex;
			var particleSystem:PDParticleSystem  = this.getChildAt(index) as PDParticleSystem;
			particleSystem.stop();
			Starling.juggler.remove(particleSystem);
			this.removeChildAt(index);
		}
	}
}