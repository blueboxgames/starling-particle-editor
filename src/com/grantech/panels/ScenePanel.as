package com.grantech.panels
{
	import com.grantech.managers.DataManager;
	import com.grantech.managers.SceneManager;
	import com.grantech.models.ParticleDataModel;

	import feathers.controls.Screen;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public class ScenePanel extends Screen
	{
		private var _liveChangeEnabled:Boolean;

		[Embed(source="/media/default.png")]
		private static const Default:Class;

		public function ScenePanel()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			this.name = "ScenePanel";
			DataManager.instance.addEventListener(Event.ADDED, dataManager_addedHandler);
			DataManager.instance.addEventListener(Event.CHANGE, dataManager_changeHandler);
			DataManager.instance.addEventListener(Event.SELECT, dataManager_selectHandler);
			DataManager.instance.addEventListener(Event.REMOVED, dataManager_removedHandler);
			DataManager.instance.addEventListener("swap", dataManager_swapHandler);

			this._liveChangeEnabled = true;
		}

		protected function particleFromDataModel(config:ParticleDataModel):PDParticleSystem
		{
			var blueTexture:Texture = Texture.fromEmbeddedAsset(Default);
			var particleSystem:PDParticleSystem = new PDParticleSystem(config, blueTexture);
			return particleSystem;
		}

		protected function dataManager_addedHandler(event:Event):void
		{
			var reference:ParticleDataModel = event.data as ParticleDataModel;
			var texture:Texture = Texture.fromEmbeddedAsset(Default);
			var particleSystem:PDParticleSystem = new PDParticleSystem(reference, texture);
			particleSystem.x = reference.x;
			particleSystem.y = reference.y;
			
			particleSystem.start();
			Starling.juggler.add(particleSystem);
			SceneManager.instance.addParticleSystem(reference.id, particleSystem);
			this.addChild(particleSystem);
		}

		protected function dataManager_changeHandler(event:Event):void
		{
			var index:int = DataManager.instance.currentLayerIndex;
			var key:String = event.data == null ? null : event.data.key;
			var value:* = event.data == null ? null : event.data.value;
			var particleModel:ParticleDataModel = DataManager.instance.layers.getItemAt(index) as ParticleDataModel;
			if (key != null && particleModel != null)
				SceneManager.instance.changeParticleSystem(particleModel.id, key, value);
		}

		/**
		 * Not implemented
		 */
		protected function dataManager_selectHandler(event:Event):void
		{
			if (!event.data) 
				return;
			var index:int = event.data.index;
			var particleModel:ParticleDataModel = DataManager.instance.layers.getItemAt(index) as ParticleDataModel;
			if(particleModel != null)
			{
				var particleSystem:PDParticleSystem = SceneManager.instance.getParticleSystem(particleModel.id);
			}
		}

		protected function dataManager_removedHandler(event:Event):void
		{
			var index:int = event.data.index;
			var particleModel:ParticleDataModel = DataManager.instance.layers.getItemAt(index) as ParticleDataModel;
			var particleSystem:PDParticleSystem = SceneManager.instance.getParticleSystem(particleModel.id)
			particleSystem.stop();
			Starling.juggler.remove(particleSystem);
			this.removeChild(particleSystem);
			particleSystem.dispose();
		}

		protected function dataManager_swapHandler(event:Event):void
		{
			var a:PDParticleSystem = SceneManager.instance.getParticleSystem(event.data.a);
			var b:PDParticleSystem = SceneManager.instance.getParticleSystem(event.data.b);
			this.swapChildren(a,b);
		}

		override public function dispose():void
		{
			DataManager.instance.removeEventListener(Event.ADDED, dataManager_addedHandler);
			DataManager.instance.removeEventListener(Event.CHANGE, dataManager_changeHandler);
			DataManager.instance.removeEventListener(Event.SELECT, dataManager_selectHandler);
			DataManager.instance.removeEventListener(Event.REMOVED, dataManager_removedHandler);
			DataManager.instance.removeEventListener("swap", dataManager_swapHandler);
			super.dispose();
		}
	}
}