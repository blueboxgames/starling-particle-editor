package com.grantech.controls.items
{
	import com.grantech.utils.Localizations;

	import feathers.controls.Button;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import flash.net.FileFilter;
	import flash.net.FileReference;

	import starling.display.Quad;
	import starling.events.Event;

	public class LayerListItemRenderer extends AbstractTouchableListItemRenderer
	{
		public function LayerListItemRenderer()
		{
			super();
		}

		private var _imagefile:FileReference = new FileReference();
		private var _configfile:FileReference = new FileReference();
		
		private var configBrowse:Button;
		private var imageBrowse:Button;

		private var configLoaded:Boolean;
		private var imageLoaded:Boolean;

		override protected function initialize():void
		{
			super.initialize();
			// this.particleManager.dispatchEventWith("particleCreated");

			_backgroundDisabledSkin = new Quad(1,1, 0xAAFFFF);
			_backgroundSelectedSkin = new Quad(1,1, 0xFFAAAA);

			this.layout = new AnchorLayout();;

			this.configBrowse = new Button();
			this.configBrowse.alpha = 0.5;
			this.configBrowse.width = 100;
			this.configBrowse.label = Localizations.instance.get("add_config");
			this.configBrowse.layoutData = new AnchorLayoutData(NaN, NaN, 4, 4);
			this.configBrowse.addEventListener(starling.events.Event.TRIGGERED, configBrowse_triggeredHandler);
			this.addChild(this.configBrowse);

			this.imageBrowse = new Button();
			this.imageBrowse.alpha = 0.5;
			this.imageBrowse.width = 100;
			this.imageBrowse.label = Localizations.instance.get("add_image");
			this.imageBrowse.layoutData = new AnchorLayoutData(NaN, NaN, 4, 108);
			this.imageBrowse.addEventListener(starling.events.Event.TRIGGERED, imageBrowse_triggeredHandler);
			this.addChild(this.imageBrowse);
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			backgroundSkin = value ? _backgroundSelectedSkin : _backgroundDisabledSkin;
		}

		private function configBrowse_triggeredHandler(event:Event):void
		{
			 var configsFilter:FileFilter = new FileFilter("Config", "*.pex;*.xml;*.json");
			_configfile.browse([configsFilter]);
			_configfile.addEventListener(Event.SELECT, configFile_selectHandler);
		}

		private function configFile_selectHandler(e:*):void
		{
			this.configBrowse.alpha = 1;
			_configfile.addEventListener(Event.COMPLETE, file_completeHandler);
			_configfile.load();
		}

		private function imageBrowse_triggeredHandler(e:Event):void
		{
			 var imagesFilter:FileFilter = new FileFilter("Image", "*.png;*.jpg");
			_imagefile.browse([imagesFilter]);
			_imagefile.addEventListener(Event.SELECT, imageFile_selectHandler);
		}

		private function imageFile_selectHandler(e:*):void
		{
			this.imageBrowse.alpha = 1;
			_imagefile.addEventListener(Event.COMPLETE, file_completeHandler);
			_imagefile.load();
		}

		private function file_completeHandler(e:*):void
		{
			// ParticleLoader
			if(imageLoaded && configLoaded)
			{
				var config:Object;
				if(_configfile.extension == "json")
				{
					_configfile.data.position = 0;
					config = JSON.parse(_configfile.data.readUTFBytes(_configfile.data.length)) as Object;
				}
				else
				{
					_configfile.data.position = 0;
					config = XML(_configfile.data.readUTFBytes(_configfile.data.length)) as Object;
				}
				//particleManager.addParticle()
			}
		}
	}
}