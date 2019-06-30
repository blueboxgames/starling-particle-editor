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
			DataManager.instance.addEventListener(Event.SELECT, dataManager_selectLayerAddedHandler);
		}

		protected function particleFromDataModel(config:ParticleDataModel):PDParticleSystem
		{
			var blueTexture:Texture = Texture.fromEmbeddedAsset(BlueflameParticle);
			var particleSystem:PDParticleSystem = new PDParticleSystem(config, blueTexture);
			particleSystem.x = this.width/2;
			particleSystem.y = this.height/2;
			return particleSystem;
		}

		protected function dataManager_selectLayerAddedHandler(event:Event):void
		{
			var index:int = event.data as int;

			if( index < 0 || index >= DataManager.instance.layers.length )
				return;
			var particleSystem:PDParticleSystem = particleFromDataModel(DataManager.instance.layers.getItemAt(event.data as int) as ParticleDataModel);
			particleSystem.emitterX = 320;
    	particleSystem.emitterY = 240;
            
      this.addChild(particleSystem);
      Starling.juggler.add(particleSystem);
      particleSystem.start();
		}

		override public function dispose() : void
		{
			DataManager.instance.removeEventListener(Event.SELECT, dataManager_selectLayerAddedHandler);
			super.dispose();
		}
	}

}