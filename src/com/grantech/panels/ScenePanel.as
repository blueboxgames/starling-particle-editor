package com.grantech.panels
{
	import com.grantech.controls.displays.ISceneObject;
	import com.grantech.controls.displays.PDSceneParticleSystem;
	import com.grantech.managers.DataManager;
	import com.grantech.models.LayerDataModel;
	import com.grantech.models.ParticleDataModel;

	import feathers.controls.Screen;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;

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
			var sceneObject:DisplayObject;
			if (layer.type == LayerDataModel.TYPE_PARTICLE)
			{
				sceneObject = generateParticleSystemFromParticleDataModel(layer as ParticleDataModel);
				PDSceneParticleSystem(sceneObject).start();
				Starling.juggler.add(sceneObject as IAnimatable);
			}
			else if (layer.type == LayerDataModel.TYPE_IMAGE)
			{
				trace("add image not implemented!")
				return;
			}
			sceneObject.x = layer.x;
			sceneObject.y = layer.y;
			this.addChild(sceneObject)
		}

		protected function dataManager_selectHandler(event:Event):void
		{
			var selectedLayerIndex:int = event.data as int;
			if( selectedLayerIndex > -1 )
				DataManager.instance.selectedlayer.addEventListener(Event.CHANGE, selectedLayer_changeHandler);
			sortChildren(sortMethod);
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
			
			if( !sceneObject.hasOwnProperty(event.data) )
			{
				trace(" sceneObject has not '" + event.data + "' variable.");
				return;
			}
			
			sceneObject[event.data] = selectedLayer.getProperty(event.data as String);
		}

		protected function dataManager_removedHandler(event:Event):void
		{
			var removedLayer:LayerDataModel = event.data as LayerDataModel;
			var removedObject:DisplayObject = getObjectById(removedLayer.id) as DisplayObject;
			if( removedObject == null )
				return;
			
			if( removedLayer.type == LayerDataModel.TYPE_PARTICLE )
			{
				PDSceneParticleSystem(removedObject).stop();
				Starling.juggler.add(removedObject as IAnimatable);
			}
			removedObject.removeFromParent(true);
		}

		protected function generateParticleSystemFromParticleDataModel(particleDataModel:ParticleDataModel):PDSceneParticleSystem
		{
			return new PDSceneParticleSystem(particleDataModel as LayerDataModel, particleDataModel, particleDataModel.texture);
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
				if( object.layer.id == id )
					return object;
			}
			return null;
		}


		private function sortMethod(left:ISceneObject, right:ISceneObject) : Number
		{
			return left.layer.order - right.layer.order;
		}
	}
}