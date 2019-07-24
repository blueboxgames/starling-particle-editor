package com.grantech.panels
{
	import com.grantech.controls.displays.ISceneObject;
	import com.grantech.controls.displays.PDSceneParticleSystem;
	import com.grantech.managers.DataManager;
	import com.grantech.models.ParticleDataModel;

	import feathers.controls.Screen;

	import starling.core.Starling;
	import starling.events.Event;

	public class ScenePanel extends Screen
	{
		public function ScenePanel()
		{
			super();
			DataManager.instance.addEventListener(Event.ADDED, dataManager_addHandler);
			DataManager.instance.addEventListener(Event.CHANGE, dataManager_changeHandler);
			DataManager.instance.addEventListener(Event.REMOVED, dataManager_removedHandler);
		}

		override protected function initialize():void
		{
			super.initialize();
			this.name = "ScenePanel";
		}

		protected function dataManager_addHandler(event:Event):void
		{
			if(event.data.particle)
			{
				var particleObject:PDSceneParticleSystem = generateParticleSystemFromParticleDataModel(event.data.particle);
				particleObject.start();
				Starling.juggler.add(particleObject);
				this.addChild(particleObject)
			}
			else if(event.data.image)
			{

			}
		}

		protected function dataManager_changeHandler(event:Event):void
		{
			for(var index:int = 0; index < this.numChildren; index++)
			{
				var object:ISceneObject = this.getChildAt(index) as ISceneObject;
				if( object.id == DataManager.instance.currentModel.id )
				{
					this.getChildAt(index)[event.data.key] = event.data.value;
				}
			}
		}

		protected function dataManager_removedHandler(event:Event):void
		{

		}

		protected function generateParticleSystemFromParticleDataModel(particleDataModel:ParticleDataModel):PDSceneParticleSystem
		{
			var particleSystem:PDSceneParticleSystem = new PDSceneParticleSystem(particleDataModel.id, particleDataModel, null);
			return particleSystem;
		}

		override public function dispose():void
		{
			DataManager.instance.removeEventListener(Event.ADDED, dataManager_addHandler);
			DataManager.instance.removeEventListener(Event.CHANGE, dataManager_changeHandler);
			DataManager.instance.addEventListener(Event.REMOVED, dataManager_removedHandler);
			super.dispose();
		}
	}
}