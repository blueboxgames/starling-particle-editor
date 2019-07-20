package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;
	import com.grantech.models.ParticleDataModel;

	import feathers.controls.ButtonGroup;
	import feathers.controls.Label;
	import feathers.data.ArrayCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.Direction;

	import flash.filesystem.File;
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

		private var id:Number;
		private var layerName:Label;
		private var ioGroup:ButtonGroup;

		override protected function initialize():void
		{
			super.initialize();

			/**
			 * Layers selected or unselected skin.
			 */
			this.backgroundDisabledSkin = new Quad(1,1, 0x333333);
			this.backgroundSelectedSkin = new Quad(1,1, 0x666666);

			this.layout = new AnchorLayout();

			this.layerName = new Label();
			this.layerName.layoutData = new AnchorLayoutData(2, 0, 2, 4);
			this.addChild(layerName);

			this.ioGroup = new ButtonGroup();
			this.ioGroup.dataProvider = new ArrayCollection(
				[
					{label: "Load", triggered: loadButton_triggeredHandler},
					{label: "Save", triggered: saveButton_triggeredHandler}
				]
			);
			this.ioGroup.direction = Direction.HORIZONTAL;
			this.ioGroup.layoutData = new AnchorLayoutData(2, 4, 2, 200);
			this.addChild(ioGroup);
		}

		override protected function commitData():void
		{
			super.commitData();
			
			if (this.data != null )
			{
				this.id = this.data.id;
				var id:String = this.id.toString();
			}
			// TODO: Should be layer name but now we only can differentiate using id.
			this.layerName.text = "Id: " + id;
			this.layerName.invalidate(INVALIDATION_FLAG_DATA);

			// TODO: Don't load and save image layers.
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			this.backgroundSkin = value ? this.backgroundSelectedSkin : this.backgroundDisabledSkin;
		}

		protected function loadButton_triggeredHandler(event:Event):void
		{
			var configFile:File = new File();
			var configFileExtension:FileFilter = new FileFilter("Data Config", "*.json;*.pex");
			configFile.browse([configFileExtension]);
			configFile.addEventListener(Event.SELECT, configFile_selectHandler);
		}

		protected function saveButton_triggeredHandler(event:Event):void
		{
			var newFile:FileReference = new FileReference();
			var particleData:ParticleDataModel = DataManager.instance.layerAt(DataManager.instance.currentLayerIndex) as ParticleDataModel;
			
			// TODO: Write IO Error handler when alert popup is written.
			newFile.save(JSON.stringify(particleData));
			// TODO: So for now we don't need to listen for our save to complete.
			// newFile.addEventListener(Event.COMPLETE, function(e:*):void {
			// 	trace("Complete")
			// });
		}

		protected function configFile_selectHandler(event:*):void
		{
			event.currentTarget.load();
			event.currentTarget.addEventListener(Event.COMPLETE, configFile_completeHandler);
		}

		protected function configFile_completeHandler(event:*):void
		{
			event.currentTarget.removeEventListener(Event.COMPLETE, configFile_completeHandler);
			DataManager.instance.editLayerDataFile( event.currentTarget );
		}
	}
}