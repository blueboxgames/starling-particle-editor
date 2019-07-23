package com.grantech.panels
{
	import com.grantech.managers.AssetManager;
	import com.grantech.managers.DataManager;
	import com.grantech.managers.SceneManager;
	import com.grantech.models.ParticleDataModel;

	import feathers.controls.Screen;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public class ScenePanel extends Screen
	{
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
			// DataManager.instance.addEventListener(Event.CHANGE, dataManager_changeHandler);
			// DataManager.instance.addEventListener(Event.SELECT, dataManager_selectHandler);
			DataManager.instance.addEventListener(Event.REMOVED, dataManager_removedHandler);
			DataManager.instance.addEventListener("swap", dataManager_swapHandler);

			SceneManager.instance.addEventListener(Event.ADDED, sceneManager_addedHandler);
			SceneManager.instance.addEventListener(Event.CHANGE, sceneManager_changeHandler);
		}

		protected function dataManager_addedHandler(event:Event):void
		{
			if(event.data == null)
				return;
			if(event.data.particle != null)
			{
				createParticleFromModel(event.data.particle);
			}
			if(event.data.image != null)
			{
				// createImage();
			}
		}

		protected function dataManager_changeHandler(event:Event):void
		{
			var index:int = DataManager.instance.currentLayerIndex;
			var key:String = event.data == null ? null : event.data.key;
			var value:* = event.data == null ? null : event.data.value;
			var particleModel:ParticleDataModel = DataManager.instance.layerComponentCollection.getItemAt(index) as ParticleDataModel;
			if(key == "blendFuncSource" || key == "blendFuncDestination")
				value = ParticleDataModel.getBlendFunc(value);
			if (key != null && key != "id" && particleModel != null)
				SceneManager.instance.changeParticleSystem(particleModel.id, key, value);
		}

		/**
		 * Not implemented
		 */
		// protected function dataManager_selectHandler(event:Event):void
		// {
		// 	if (!event.data) 
		// 		return;
		// 	var index:int = event.data.index;
		// 	var particleModel:ParticleDataModel = DataManager.instance.layers.getItemAt(index) as ParticleDataModel;
		// 	if(particleModel != null)
		// 	{
		// 		var particleSystem:PDParticleSystem = SceneManager.instance.getParticleSystem(particleModel.id);
		// 	}
		// }

		protected function dataManager_removedHandler(event:Event):void
		{
			var index:int = event.data.index;
			var particleModel:ParticleDataModel = DataManager.instance.layerComponentCollection.getItemAt(index) as ParticleDataModel;
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

		protected function sceneManager_addedHandler(event:Event):void
		{
			var newDisplayElement:DisplayObject;
			if(event.data.type == SceneManager.TYPE_PARTCILE )
			{
				var particleSystem:PDParticleSystem = SceneManager.instance.getParticleSystem( event.data.id );
				particleSystem.start();
				Starling.juggler.add(particleSystem);
				newDisplayElement = particleSystem;
			}
			else if(event.data.type == SceneManager.TYPE_IMAGE )
				newDisplayElement = SceneManager.instance.getImage( event.data.id );
			
			if(newDisplayElement != null)
				this.addChild(newDisplayElement);
		}

		protected function sceneManager_changeHandler(event:Event):void
		{

		}

		override public function dispose():void
		{
			DataManager.instance.removeEventListener(Event.ADDED, dataManager_addedHandler);
			// DataManager.instance.removeEventListener(Event.SELECT, dataManager_selectHandler);
			DataManager.instance.removeEventListener(Event.REMOVED, dataManager_removedHandler);
			DataManager.instance.removeEventListener("swap", dataManager_swapHandler);

			SceneManager.instance.removeEventListener(Event.ADDED, sceneManager_addedHandler);
			DataManager.instance.removeEventListener(Event.CHANGE, sceneManager_changeHandler);
			super.dispose();
		}

		protected function createParticleFromModel(model:ParticleDataModel):void
		{
			AssetManager.instance.load(model.texture);
			AssetManager.instance.addEventListener(Event.COMPLETE, function():void {
				var texture:Texture = AssetManager.instance.getTexture(model.texture);
				var particleSystem:PDParticleSystem = new PDParticleSystem(model, texture);

				// Reload blendFuncSource and Destination.
				particleSystem.blendFuncSource = ParticleDataModel.getBlendFunc(model.blendFuncSource);
				particleSystem.blendFuncDestination = ParticleDataModel.getBlendFunc(model.blendFuncDestination);
				
				SceneManager.instance.addParticleSystem(model.id, particleSystem);
			});
		}
	}
}