package com.grantech.panels
{
	import com.grantech.controls.displays.ISceneObject;
	import com.grantech.controls.displays.PDSceneParticleSystem;
	import com.grantech.managers.DataManager;
	import com.grantech.models.LayerDataModel;
	import com.grantech.models.ParticleDataModel;

	import feathers.controls.Screen;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.animation.IAnimatable;

	public class ScenePanel extends Screen
	{
		public function ScenePanel()
		{
			super();
			DataManager.instance.addEventListener(Event.ADDED, dataManager_addHandler);
			DataManager.instance.addEventListener(Event.SELECT, dataManager_selectHandler);
			DataManager.instance.addEventListener(Event.REMOVED, dataManager_removedHandler);
		}

		override protected function initialize():void
		{
			super.initialize();
			this.name = "ScenePanel";
		}

		protected function dataManager_addHandler(event:Event):void
		{
			var layer:LayerDataModel = event.data as LayerDataModel;
			if(layer.type == LayerDataModel.TYPE_PARTICLE)
			{
				var particleObject:PDSceneParticleSystem = generateParticleSystemFromParticleDataModel(layer as ParticleDataModel);
				particleObject.start();
				Starling.juggler.add(particleObject as IAnimatable);
			}
			else if(layer.type == LayerDataModel.TYPE_IMAGE)
			{
				trace("add image not implemented!")
				return;
			}
			this.addChild(particleObject)
		}

		protected function dataManager_selectHandler(event:Event):void
		{
			var selectedLayer:LayerDataModel = event.data as LayerDataModel;
			DataManager.instance.currentlayer.addEventListener(Event.CHANGE, selectedLayer_changeHandler);
		}

		protected function selectedLayer_changeHandler(event:Event):void
		{
			var selectedLayer:LayerDataModel = event.currentTarget as LayerDataModel;
			var sceneObject:ISceneObject = getObjectById(selectedLayer.id);
			if( sceneObject == null )
			{
				trace(" sceneObject " + selectedLayer.id + " not found.");
				return;
			}
			sceneObject[event.data] = selectedLayer.getProperty(event.data as String);
		}

		protected function dataManager_removedHandler(event:Event):void
		{
			
		}

		protected function generateParticleSystemFromParticleDataModel(particleDataModel:ParticleDataModel):PDSceneParticleSystem
		{
			return new PDSceneParticleSystem(particleDataModel.id, particleDataModel, null);
		}

		override public function dispose():void
		{
			DataManager.instance.removeEventListener(Event.ADDED, dataManager_addHandler);
			DataManager.instance.removeEventListener(Event.SELECT, dataManager_selectHandler);
			DataManager.instance.addEventListener(Event.REMOVED, dataManager_removedHandler);
			super.dispose();
		}

		private function getObjectById(id:int):ISceneObject
		{
			for(var index:int = 0; index < this.numChildren; index++)
			{
				var object:ISceneObject = this.getChildAt(index) as ISceneObject;
				if( object.id == id )
					return object;
			}
			return null;
		}
	}
}