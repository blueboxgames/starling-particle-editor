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
		static public const TYPE_ADD:String = "add";
		static public const TYPE_REMOVE:String = "remove";
		static public const TYPE_UP:String = "up";
		static public const TYPE_DOWN:String = "down";
		static public const TYPE_SAVE:String = "save";

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
			this.iconDisplay.layoutData = new AnchorLayoutData(4, 4, 4, 4);
			this.addChild(this.iconDisplay);

			DataManager.instance.addEventListener(Event.SELECT, dataManager_selectHandler);
		}

		override protected function commitData():void
		{
			super.commitData();
			
			if (this.data == null )
				return;
			this.type = this.data as String;
			enabled = this.type == TYPE_ADD;
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
				
				case TYPE_SAVE:
					enabled = index > -1 && DataManager.instance.selectedlayer.type == LayerDataModel.TYPE_PARTICLE;
					break;
			}
		}

		public function set enabled(value:Boolean):void
		{
			isEnabled = value;
			alpha = value ? 1 : 0.5;
		}

		override public function dispose():void
		{
			DataManager.instance.removeEventListener(Event.SELECT, dataManager_selectHandler)
			super.dispose();
		}

	}
}