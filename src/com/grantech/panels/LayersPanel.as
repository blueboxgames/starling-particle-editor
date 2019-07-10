package com.grantech.panels
{
	import com.grantech.controls.items.LayerListItemRenderer;
	import com.grantech.managers.DataManager;
	import com.grantech.utils.Localizations;

	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import com.grantech.models.ParticleDataModel;

	public class LayersPanel extends PanelScreen
	{
		private var listDisplay:List;
		
		[Embed(source="/media/icons/addLayer.png")]
		public static var addLayer:Class;

		[Embed(source="/media/icons/removeLayer.png")]
		public static var removeLayer:Class;

		[Embed(source="/media/icons/raiseLayer.png")]
		public static var raiseLayer:Class;
		
		[Embed(source="/media/icons/lowerLayer.png")]
		public static var lowerLayer:Class;

		override protected function initialize():void
		{
			super.initialize();
			layout= new AnchorLayout();

			this.title = Localizations.instance.get("layers_panel_title");
			
			/* var listLayout:VerticalLayout = new VerticalLayout();
			listLayout.horizontalAlign = HorizontalAlign.CENTER;
			listLayout.paddingTop = 120;
			this.layout = listLayout; */
			listDisplay = new List();
			listDisplay.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			listDisplay.itemRendererFactory = function () : IListItemRenderer
			{
				return new LayerListItemRenderer();
			}
			listDisplay.dataProvider = DataManager.instance.layers;
			addChild(listDisplay);
			listDisplay.addEventListener(Event.CHANGE, listDisplay_changeHandler);

			this.footerFactory = function():LayoutGroup {
				var footer:LayoutGroup = new LayoutGroup();
				footer.backgroundSkin = new Quad(1,1, 0x272822);
				var layoutType:HorizontalLayout = new HorizontalLayout();
				footer.layout = layoutType;

				var addButton:Button = new Button();
				addButton.width = 24;
				addButton.height = 24;
				addButton.defaultSkin = new Quad(1,1, 0x272822);
				var addButtonIcon:Image = new Image(Texture.fromBitmap(new addLayer()));
				addButtonIcon.scale = 0.12;
				addButton.defaultIcon = addButtonIcon;
				addButton.addEventListener(Event.TRIGGERED, addButton_triggeredHandler);
				footer.addChild(addButton);
				
				var removeButton:Button = new Button();
				removeButton.width = 24;
				removeButton.height = 24;
				removeButton.defaultSkin = new Quad(1,1, 0x272822);
				var removeButtonIcon:Image = new Image(Texture.fromBitmap(new removeLayer()));
				removeButtonIcon.scale = 0.12;
				removeButton.defaultIcon = removeButtonIcon;
				removeButton.addEventListener(Event.TRIGGERED, removeButton_triggeredHandler);
				footer.addChild(removeButton);

				var raiseLayerButton:Button = new Button();
				raiseLayerButton.width = 24;
				raiseLayerButton.height = 24;
				raiseLayerButton.defaultSkin = new Quad(1,1, 0x272822);
				var raiseLayerButtonIcon:Image = new Image(Texture.fromBitmap(new raiseLayer()));
				raiseLayerButtonIcon.scale = 0.12;
				raiseLayerButton.defaultIcon = raiseLayerButtonIcon;
				raiseLayerButton.addEventListener(Event.TRIGGERED, raiseLayerButton_triggeredHandler);
				footer.addChild(raiseLayerButton);
				
				var lowerLayerButton:Button = new Button();
				lowerLayerButton.width = 24;
				lowerLayerButton.height = 24;
				lowerLayerButton.defaultSkin = new Quad(1,1, 0x272822);
				var lowerLayerButtonIcon:Image = new Image(Texture.fromBitmap(new lowerLayer()));
				lowerLayerButtonIcon.scale = 0.12;
				lowerLayerButton.defaultIcon = lowerLayerButtonIcon;
				lowerLayerButton.addEventListener(Event.TRIGGERED, lowerLayerButton_triggeredHandler);
				footer.addChild(lowerLayerButton);

				return footer;
			}
		}

		protected function listDisplay_changeHandler(event:Event):void
		{
			DataManager.instance.selectLayer(this.listDisplay.selectedItem);
		}
		
		protected function addButton_triggeredHandler(event:Event):void
		{
			DataManager.instance.addLayer();
			this.listDisplay.selectedIndex = DataManager.instance.currentLayerIndex;
		}
		
		private function removeButton_triggeredHandler(event:Event):void
		{
			var selectedIndex:int = listDisplay.selectedIndex;
			if( selectedIndex < 0 )
				return;
			DataManager.instance.removeLayerAt(selectedIndex);
			if( selectedIndex > 0 )
				listDisplay.selectedIndex = selectedIndex - 1;
		}

		private function raiseLayerButton_triggeredHandler(event:Event):void
		{
			DataManager.instance.raiseLayerAt(listDisplay.selectedIndex);
		}

		private function lowerLayerButton_triggeredHandler(event:Event):void
		{
			DataManager.instance.lowerLayerAt(listDisplay.selectedIndex);
		}
	}
}