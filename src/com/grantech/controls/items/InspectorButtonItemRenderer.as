package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;
	import com.grantech.models.ParticleDataModel;
	import com.grantech.utils.Base64;

	import feathers.controls.Button;

	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class InspectorButtonItemRenderer extends InspectorBaseItemRenderer
	{
		public function InspectorButtonItemRenderer() { super(); }
		override protected function redrawControl():void
		{
			super.redrawControl();

			if (this.valueDisplay == null)
			{
				this.valueDisplay = new Button();
				this.valueDisplay.layoutData = VALUE_LAYOUTDATA;
				this.addChild(this.valueDisplay);
			}
			
			var button:Button = valueDisplay as Button;
			if( this.value is Texture )
			{
				button.defaultIcon = new Image(this.value as Texture);
				button.defaultIcon.width = button.defaultIcon.height = height - 4;
			}
			else
			{
				button.label = this.value;
			}
			
			if (!button.hasEventListener(Event.TRIGGERED))
				button.addEventListener(Event.TRIGGERED, button_triggeredHandler);
		}
		private function button_triggeredHandler(e:Event):void
		{
			if( this.value is Texture || this.label == "load" )
				loadFile();
			else if( this.label == "save" )
				saveConfig();
		}

		private function loadFile():void
		{
			var imageFilter : FileFilter = new FileFilter("Texture", "*.png;*.atf");
			var configFilter : FileFilter = new FileFilter("Particle Config", "*.xml;*.json;*.pex");
			var allFilter : FileFilter = new FileFilter("All Files", "*.*");
			var fr:FileReference = new FileReference();
			fr.addEventListener("select", fr_selectHandler);
			fr.browse(this.value is Texture ? [imageFilter, allFilter] : [configFilter, allFilter]);
		}

		private function fr_selectHandler(event:*):void
		{
			var fr:FileReference = event.target as FileReference;
			fr.removeEventListener("select", fr_selectHandler);
			fr.addEventListener("complete", fr_completeHandler);
			fr.load();
		}

		private function fr_completeHandler(event:*):void
		{
			var fr:FileReference = event.target as FileReference;
			fr.removeEventListener("complete", fr_completeHandler);
			if( this.value is Texture )
				loadTexture(fr.data);
			else if( this.label == "load" )
				loadConfig(fr.data);
		}

		private function loadTexture(imageData:ByteArray):void
		{
			var str:String = imageData.toString();
			if( str.substring(0, 3) == "ATF" )
			{
				setData(Texture.fromAtfData(imageData));
				return;
			}

			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			loaderContext.allowLoadBytesCodeExecution = true;
			loaderContext.allowCodeImport = true;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener("complete", loader_completeHandler);
			loader.loadBytes(imageData, loaderContext);
		}
		private function loader_completeHandler(event:Object):void
		{
			var loader:Loader = event.target.loader as Loader;
			loader.contentLoaderInfo.removeEventListener("complete", loader_completeHandler);

			var bmpData:BitmapData = new BitmapData(loader.width, loader.height, true, 0);
			bmpData.draw(loader);
			
			setData(Texture.fromBitmapData(bmpData));
		}

		private function loadConfig(configData:ByteArray):void
		{
			var byteStr:String = configData.toString();
			// this.value = configData.toString();
			if( byteStr.substr(0,10).search("<") > -1 )
				ParticleDataModel(DataManager.instance.selectedlayer).parseXMLConfig(byteStr);
			else
				ParticleDataModel(DataManager.instance.selectedlayer).parseJsonConfig(byteStr);
			// redrawControl();
		}

		private function saveConfig():void
		{
			var fileRef:FileReference=new FileReference();
			fileRef.save(JSON.stringify(ParticleDataModel(DataManager.instance.selectedlayer).jsonOutput), this.label);
		}

		private function setData(bmpData:Texture):void
		{
			this.value = bmpData;
			DataManager.instance.selectedlayer.setProperty(this.label, this.value);
			redrawControl();
		}
	}
}