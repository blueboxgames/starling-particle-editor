package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;
	import com.grantech.models.LayerDataModel;

	import feathers.controls.ImageLoader;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Quad;
	import starling.events.Event;

	public class FooterItemRenderer extends AbstractTouchableListItemRenderer
	{
		static public const TYPE_OPEN:String = "open"
		static public const TYPE_SAVE:String = "save";
		static public const TYPE_EMPTY:String = "";
		static public const TYPE_ADD:String = "add";
		static public const TYPE_REMOVE:String = "remove";
		static public const TYPE_UP:String = "up";
		static public const TYPE_DOWN:String = "down";
		static public const TYPE_IMPORT:String = "import";
		static public const TYPE_EXPORT:String = "export";

		private var type:String;
		private var iconDisplay:ImageLoader;
		public function FooterItemRenderer() { super(); }
		override protected function initialize():void
		{
			super.initialize();
			this.width = 32;
			this.height = 32;

			this.backgroundDisabledSkin = new Quad(1,1, 0x333333);
			this.backgroundSelectedSkin = new Quad(1,1, 0x666666);

			this.layout = new AnchorLayout();

			this.iconDisplay = new ImageLoader();
			this.iconDisplay.layoutData = new AnchorLayoutData(8, 8, 8, 8);
			this.addChild(this.iconDisplay);

			DataManager.instance.addEventListener(Event.SELECT, dataManager_selectHandler);
			DataManager.instance.addEventListener(Event.ADDED, dataManager_addedremovedHandler);
			DataManager.instance.addEventListener(Event.REMOVED, dataManager_addedremovedHandler);
		}

		override protected function commitData():void
		{
			super.commitData();
			
			if (this.data == null )
				return;
			this.type = this.data as String;
			if( this.type == TYPE_EMPTY )
			{
				this.width = this.owner.width - (8 * 32) - (11 * 2)
				alpha = 0;
				return;
			}

			enabled = this.type == TYPE_ADD || this.type == TYPE_OPEN;
			this.iconDisplay.source = Main.assetManager.getTexture(this.data as String);
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			this.backgroundSkin = value ? this.backgroundSelectedSkin : this.backgroundDisabledSkin;
		}

		private function dataManager_selectHandler(event:Event):void
		{
			var index:int = event.data as int;
			switch( this.type )
			{
				case TYPE_REMOVE:
					enabled = index > -1;
					break;
				
				case TYPE_UP:
					enabled = index > 0;
					break;
				
				case TYPE_DOWN:
					enabled = index < DataManager.instance.layerDataProvider.length - 1;
					break;
				
				case TYPE_IMPORT:
				case TYPE_EXPORT:
					enabled = index > -1 && DataManager.instance.selectedlayer.type == LayerDataModel.TYPE_PARTICLE;
					break;
			}
		}

		private function dataManager_addedremovedHandler(event:Event):void
		{
			if( this.type == TYPE_SAVE )
				enabled = DataManager.instance.layerDataProvider.length > 0;
		}

		public function set enabled(value:Boolean):void
		{
			isEnabled = value;
			alpha = value ? 1 : 0.3;
		}

		override public function dispose():void
		{
			DataManager.instance.removeEventListener(Event.SELECT, dataManager_selectHandler);
			DataManager.instance.removeEventListener(Event.ADDED, dataManager_addedremovedHandler);
			DataManager.instance.removeEventListener(Event.REMOVED, dataManager_addedremovedHandler);
			super.dispose();
		}

	}
}