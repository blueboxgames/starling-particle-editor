package com.grantech.controls.items
{
	import com.grantech.models.LayerDataModel;

	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Quad;
	import starling.events.Event;

	public class LayerListItemRenderer extends AbstractTouchableListItemRenderer
	{
		private var layer:LayerDataModel;
		private var iconDisplay:ImageLoader;
		private var titleDisplay:Label;
		public function LayerListItemRenderer() { super(); }

		override protected function initialize():void
		{
			super.initialize();
			this.height = 48;

			this.backgroundDisabledSkin = new Quad(1,1, 0x333333);
			this.backgroundSelectedSkin = new Quad(1,1, 0x666666);

			this.layout = new AnchorLayout();

			this.iconDisplay = new ImageLoader();
			this.iconDisplay.layoutData = new AnchorLayoutData(2, NaN, 2, 2);
			this.addChild(this.iconDisplay);

			this.titleDisplay = new Label();
			this.titleDisplay.layoutData = new AnchorLayoutData(2, NaN, 2, this.height + 2);
			this.addChild(this.titleDisplay);
		}

		override protected function commitData():void
		{
			super.commitData();
			
			if( this.data == null )
				return;
			this.layer = data as LayerDataModel;
			this.titleDisplay.text = this.layer.name;
			
			this.iconDisplay.source = layer.texture;
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			if( value )
				this.layer.addEventListener(Event.CHANGE, this.layer_changeHandler);
			this.backgroundSkin = value ? this.backgroundSelectedSkin : this.backgroundDisabledSkin;
		}

		protected function layer_changeHandler(event:Event):void
		{
			if( event.data == "texture" )
				this.iconDisplay.source = layer.getProperty(event.data as String);
		}

		// protected function loadButton_triggeredHandler(event:Event):void
		// {
		// 	var configFile:File = new File();
		// 	var configFileExtension:FileFilter = new FileFilter("Data Config", "*.json;*.pex");
		// 	configFile.browse([configFileExtension]);
		// 	configFile.addEventListener(Event.SELECT, configFile_selectHandler);
		// }

		// protected function saveButton_triggeredHandler(event:Event):void
		// {
		// 	var newFile:FileReference = new FileReference();
		// 	var particleData:ParticleDataModel = DataManager.instance.layerAt(DataManager.instance.currentLayerIndex) as ParticleDataModel;
		// 	newFile.save(JSON.stringify(particleData));
		// }

		// protected function configFile_selectHandler(event:*):void
		// {
		// 	event.currentTarget.load();
		// 	event.currentTarget.addEventListener(Event.COMPLETE, configFile_completeHandler);
		// }

		// protected function configFile_completeHandler(event:*):void
		// {
		// 	event.currentTarget.removeEventListener(Event.COMPLETE, configFile_completeHandler);
		// 	DataManager.instance.editLayerDataFile( event.currentTarget );
		// }

	}
}