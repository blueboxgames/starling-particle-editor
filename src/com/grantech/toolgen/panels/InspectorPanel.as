package com.grantech.toolgen.panels
 {
	import com.grantech.toolgen.component.ParticleConfig;
	import com.grantech.toolgen.utils.Localizations;

	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;

	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import com.grantech.manager.ParticleManager;

	public class InspectorPanel extends Panel
	{
		private var particleManager:ParticleManager;
		public function InspectorPanel()
		{
			this.name = "InspectorPanel";
			// this.addEventListener("particleData", sidebarPanel_particleDataHandler);
			// this.addEventListener(Event.ADDED_TO_STAGE, inspectorPanel_addedToStageHandler);
			// this.particleManager.addEventListener("particleCreated", particleManager_particleCreatedHandler);
		}

		override protected function initialize():void
		{
			super.initialize();
			this.particleManager = ParticleManager.instance;
			if(!this.particleManager.isInitialized)
			{
				this.particleManager.initializeNow();
			}
			this.particleManager.addEventListener("particleSelected", function():void
			{
				trace("Config!!!");
			});
		}

		// private function particleManager_particleCreatedHandler(e:Event):void
		// {
		// 	// this.particleManager.createNewParticle()
		// }

		// private function inspectorPanel_addedToStageHandler(e:Event):void
		// {
		// 	this.removeEventListener(Event.ADDED_TO_STAGE, inspectorPanel_addedToStageHandler);
		// 	this.stage.starling.addEventListener("removeParticle", sidebarPanel_removeParticleHandler);
		// }

		// override protected function initialize():void
		// {
		// 	this.title = Localizations.instance.get("toolbar");
		// }

		// private function particleDataLoader_completeHandler(e:Event):void
		// {
		// 	this.dispatchEventWith(Event.COMPLETE, false, e.data);
		// }

		// private function sidebarPanel_particleDataHandler(e:Event):void
		// {
		// 	// var ps:PDParticleSystem = e.data as PDParticleSystem;
		// 	// var group:LayoutGroup = new LayoutGroup();
		// 	// group.name = e.data.name;
		// 	// var containerLayout:VerticalLayout = new VerticalLayout();
		// 	// containerLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
		// 	// containerLayout.verticalAlign = VerticalAlign.JUSTIFY;
		// 	// group.layout = containerLayout;
		// 	// group.width = this.width - this.padding;
		// 	// for (var config:String in ps.properties)
		// 	// {
		// 	// 	var configLine:ParticleConfig;
		// 	// 	if(ps.properties[config] is Number){
		// 	// 		configLine = new ParticleConfig(config, ps, config);
		// 	// 		group.addChild(configLine);
		// 	// 	}
		// 	// }
		// 	// this.addChild(group);
		// }

		// private function sidebarPanel_removeParticleHandler(e:Event):void
		// {
		// 	this.removeChild(this.getChildByName(e.data.name));
		// }
	}
}

			