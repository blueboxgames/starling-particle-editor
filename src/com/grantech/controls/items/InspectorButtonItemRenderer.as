package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;

	import feathers.controls.Button;

	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.net.FileReference;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

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
			if( this.value is Texture )
				loadTexture();
		}

		private function loadTexture():void
		{
			var fr:FileReference = new FileReference();
			fr.addEventListener("select", fr_selectHandler);
			fr.browse();
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

			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			loaderContext.allowCodeImport = true;
			loaderContext.allowLoadBytesCodeExecution = true;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener("complete", loader_completeHandler);
			loader.loadBytes(fr.data, loaderContext);
		}

		private function loader_completeHandler(event:Object):void
		{
			var loader:Loader = event.target.loader as Loader;
			loader.contentLoaderInfo.removeEventListener("complete", loader_completeHandler);

			var bmpData:BitmapData = new BitmapData(loader.width, loader.height, true, 0);
			bmpData.draw(loader);
			
			this.value = Texture.fromBitmapData(bmpData);
			DataManager.instance.selectedlayer.setProperty(this.label, this.value);
			redrawControl();
		}
	}
}