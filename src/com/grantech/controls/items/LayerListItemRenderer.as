package com.grantech.controls.items
{
	import feathers.controls.Label;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Quad;
	import feathers.controls.Button;
	import starling.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import com.grantech.managers.DataManager;
	import com.grantech.models.ParticleDataModel;
	import feathers.controls.ButtonGroup;
	import feathers.data.ArrayCollection;
	import feathers.layout.Direction;
	import flash.utils.Dictionary;

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

			_backgroundDisabledSkin = new Quad(1,1, 0x333333);
			_backgroundSelectedSkin = new Quad(1,1, 0x444444);

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
				var order:String = this.data.order.toString();
			}
			this.layerName.text = "Layer: " + id + "  Order: " + order;
			this.layerName.invalidate(INVALIDATION_FLAG_DATA);
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			backgroundSkin = value ? _backgroundSelectedSkin : _backgroundDisabledSkin;
		}

		protected function loadButton_triggeredHandler(event:Event):void
		{
			var fileREF:FileReference = new FileReference();
			fileREF.browse();
			fileREF.addEventListener(Event.SELECT, function(e:*):void{
				fileREF.load();
				fileREF.addEventListener(Event.COMPLETE, function(e:*):void{
					var particleModel:ParticleDataModel = new ParticleDataModel();
					DataManager.instance.editLayerDataFile(fileREF)
				});
			});
		}

		protected function saveButton_triggeredHandler(event:Event):void
		{
			var fileREF:FileReference = new FileReference();
			var x:Dictionary = new Dictionary();
				var particleModel:ParticleDataModel = DataManager.instance.layerAt(DataManager.instance.currentLayerIndex) as ParticleDataModel;
				fileREF.save(JSON.stringify(particleModel));
				fileREF.addEventListener(Event.COMPLETE, function(e:*):void{
					trace("Complete")
				});
		}
	}
}