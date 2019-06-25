package com.grantech.panels
{
	import feathers.controls.Screen;

	import starling.events.Event;
	import starling.extensions.PDParticleSystem;

	public class ScenePanel extends Screen
	{
		private var config:Object;
		private var particleSystem:PDParticleSystem;
		
		public function ScenePanel()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, sceneView_addedToStageHandler);
			this.addEventListener("particleDataRecieved", sceneView_particleDataHandler);
			this.addEventListener("particleChange", sceneView_particleChangeHandler);
		}

		override protected function initialize():void
		{
			this.name = "ScenePanel";
		}

		override protected function stage_resizeHandler(event:Event):void
		{
			this.width = stage.stageWidth * 0.6;
		}

		private function sceneView_addedToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, sceneView_addedToStageHandler);
			this.stage.starling.addEventListener("removeParticle", sceneView_removeParticleHandler);
		}

		private function sceneView_particleDataHandler(e:Event):void
		{
			try
			{
				removeChildren();
			}
			catch(e:Error)
			{
				// Nop
			}
			var file:Object = e.data;
			var config:Object;
			if(file.extension == "json")
			{
				file.data.position = 0;
				config = JSON.parse(file.data.readUTFBytes(file.data.length));
			}
			else
			{
				file.data.position = 0;
				config = XML(file.data.readUTFBytes(file.data.length));
			}
			
			//var psTexture:Texture = Texture.fromBitmap(new FireParticle());
			// particleSystem = new PDParticleSystem(config, psTexture);
			// particleSystem.name = file.name;
			// particleSystem.x = this.width/2;
			// particleSystem.y = this.height/2;
			// addChild(particleSystem);
			// Starling.juggler.add(particleSystem);
			// // start emitting particles
			// particleSystem.start();
			this.dispatchEventWith(Event.COMPLETE, false, particleSystem);
		}

		private function sceneView_particleChangeHandler(e:Event):void
		{
			this.particleSystem = e.data as PDParticleSystem;
		}

		private function sceneView_removeParticleHandler(e:Event):void
		{
			this.removeChild(this.getChildByName(e.data.name));
		}
	}
}