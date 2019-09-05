package com.grantech.panels
{
	import com.grantech.controls.displays.ISceneObject;
	import com.grantech.controls.displays.PDSceneParticleSystem;
	import com.grantech.controls.displays.SceneImage;
	import com.grantech.managers.DataManager;
	import com.grantech.models.LayerDataModel;

	import feathers.controls.Screen;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;

	public class ScenePanel extends Screen
	{
		private var canvas:Sprite; 
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

			this.canvas = new Sprite();
			this.addChild(this.canvas);
			
			this.addEventListener(Event.RESIZE, scenePanel_resizeHandler)
		}

		protected function dataManager_addHandler(event:Event):void
		{
			var layer:LayerDataModel = event.data as LayerDataModel;
			var sceneObject:DisplayObject;
			if (layer.type == LayerDataModel.TYPE_PARTICLE)
			{
				sceneObject = new PDSceneParticleSystem(layer, layer);
				PDSceneParticleSystem(sceneObject).start();
				Starling.juggler.add(sceneObject as IAnimatable);
			}
			else if (layer.type == LayerDataModel.TYPE_IMAGE)
			{
				sceneObject = new SceneImage(layer);
			}
			sceneObject.x = layer.x;
			sceneObject.y = layer.y;
			this.canvas.addChild(sceneObject)
		}

		protected function dataManager_selectHandler(event:Event):void
		{
			var selectedLayerIndex:int = event.data as int;
			if( selectedLayerIndex > -1 )
				DataManager.instance.selectedlayer.addEventListener(Event.CHANGE, selectedLayer_changeHandler);
			this.canvas.sortChildren(sortMethod);
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

		override public function dispose():void
		{
			DataManager.instance.removeEventListener(Event.ADDED, dataManager_addHandler);
			DataManager.instance.removeEventListener(Event.SELECT, dataManager_selectHandler);
			DataManager.instance.addEventListener(Event.REMOVED, dataManager_removedHandler);
			super.dispose();
		}

		private function getObjectById(id:int):ISceneObject
		{
			for(var index:int = 0; index < this.canvas.numChildren; index++)
			{
				var object:ISceneObject = this.canvas.getChildAt(index) as ISceneObject;
				if( object.layer.id == id )
					return object;
			}
			return null;
		}


		private function sortMethod(left:ISceneObject, right:ISceneObject) : Number
		{
			return left.layer.order - right.layer.order;
		}

		protected function scenePanel_resizeHandler(event:Event):void
		{
			this.canvas.x = this.width * 0.5;
			this.canvas.y = this.height * 0.5;
		}
	}
}