package panels
{
	import feathers.controls.Panel;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import starling.events.ResizeEvent;
	import feathers.controls.EditableSlider;
	import starling.extensions.ParticleSystem;
	import feathers.controls.Screen;

	public class ScenePanel extends Screen
	{
		private var config:Object;
		private var particleSystem:PDParticleSystem;
 
		[Embed(source = "fire_particle.png")]
		private static const FireParticle:Class;
		
		public function ScenePanel()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, sceneView_addedToStageHandler);
			this.addEventListener("particleDataRecieved", sceneView_particleDataHandler);
			this.addEventListener("particleChange", sceneView_particleChangeHandler);
		}

		override protected function stage_resizeHandler(event:Event):void
		{
			this.width = stage.stageWidth * 0.7;
		}

		private function sceneView_addedToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, sceneView_addedToStageHandler);
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
			
			var psTexture:Texture = Texture.fromBitmap(new FireParticle());
			particleSystem = new PDParticleSystem(config, psTexture);
			particleSystem.x = 160;
			particleSystem.y = 240;
			addChild(particleSystem);
			Starling.juggler.add(particleSystem);
			// start emitting particles
			particleSystem.start();
			this.dispatchEventWith(Event.COMPLETE, false, particleSystem);
		}

		private function sceneView_particleChangeHandler(e:Event):void
		{
			this.particleSystem = e.data as PDParticleSystem;
		}
	}
}