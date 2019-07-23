package com.grantech.panels
{
	import com.grantech.controls.items.LayerListItemRenderer;
	import com.grantech.managers.DataManager;
	import com.grantech.utils.Localizations;

	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;

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
			DataManager.instance.addEventListener(Event.SELECT, dataManager_selectHandler)
			this.title = Localizations.instance.get("layers_panel_title");
			this.layout = new AnchorLayout();
			
			this.listDisplay = new List();
			this.listDisplay.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.listDisplay.itemRendererFactory = function():IListItemRenderer
			{
				return new LayerListItemRenderer();
			}
			this.listDisplay.dataProvider = DataManager.instance.layerComponentCollection;
			this.listDisplay.addEventListener(Event.CHANGE, listDisplay_changeHandler);
			this.addChild(this.listDisplay);
			
			this.footerFactory = layersPanelFooterFactory;
		}

		protected function layersPanelFooterFactory():LayoutGroup {
			var footer:LayoutGroup = new LayoutGroup();
			footer.backgroundSkin = new Quad(1,1, 0x272822);
				
			var layoutType:HorizontalLayout = new HorizontalLayout();
			footer.layout = layoutType;

			var addLayerButton:Button = new Button();
			addLayerButton.addEventListener(Event.TRIGGERED, addLayerButton_triggeredHandler);
			addLayerButton.width = 24;
			addLayerButton.height = 24;
			addLayerButton.defaultSkin = new Quad(1,1, 0x272822);
			var addLayerButtonIcon:Image = new Image(Texture.fromBitmap(new addLayer()));
			addLayerButtonIcon.scale = 0.12;
			addLayerButton.defaultIcon = addLayerButtonIcon;
			footer.addChild(addLayerButton);
			
			var removeLayerButton:Button = new Button();
			removeLayerButton.addEventListener(Event.TRIGGERED, removeLayerButton_triggeredHandler);
			removeLayerButton.width = 24;
			removeLayerButton.height = 24;
			removeLayerButton.defaultSkin = new Quad(1,1, 0x272822);
			var removeLayerButtonIcon:Image = new Image(Texture.fromBitmap(new removeLayer()));
			removeLayerButtonIcon.scale = 0.12;
			removeLayerButton.defaultIcon = removeLayerButtonIcon;
			footer.addChild(removeLayerButton);

			var raiseLayerButton:Button = new Button();
			raiseLayerButton.addEventListener(Event.TRIGGERED, raiseLayerButton_triggeredHandler);
			raiseLayerButton.width = 24;
			raiseLayerButton.height = 24;
			raiseLayerButton.defaultSkin = new Quad(1,1, 0x272822);
			var raiseLayerButtonIcon:Image = new Image(Texture.fromBitmap(new raiseLayer()));
			raiseLayerButtonIcon.scale = 0.12;
			raiseLayerButton.defaultIcon = raiseLayerButtonIcon;
			footer.addChild(raiseLayerButton);
			
			var lowerLayerButton:Button = new Button();
			lowerLayerButton.addEventListener(Event.TRIGGERED, lowerLayerButton_triggeredHandler);
			lowerLayerButton.width = 24;
			lowerLayerButton.height = 24;
			lowerLayerButton.defaultSkin = new Quad(1,1, 0x272822);
			var lowerLayerButtonIcon:Image = new Image(Texture.fromBitmap(new lowerLayer()));
			lowerLayerButtonIcon.scale = 0.12;
			lowerLayerButton.defaultIcon = lowerLayerButtonIcon;
			footer.addChild(lowerLayerButton);

			return footer;
		}

		protected function listDisplay_changeHandler(event:Event):void
		{
			DataManager.instance.selectLayer(this.listDisplay.selectedItem);
		}
		
		protected function addLayerButton_triggeredHandler(event:Event):void
		{
			// When a new layer is added we select it from list display too.
			// DataManager.instance.addLayer();
			var popUp:Panel = new Panel();
			popUp.layout = new AnchorLayout();
			var particleButton:Button = new Button();
			particleButton.label = "Particle";
			particleButton.layoutData = new AnchorLayoutData(NaN,100,NaN,NaN);
			popUp.addChild(particleButton);
			particleButton.addEventListener(Event.TRIGGERED, function():void{
				DataManager.instance.addLayer(DataManager.PARTICLE_LAYER);
				popUp.removeFromParent();
			});

			var imageButton:Button = new Button();
			imageButton.label = "Image";
			imageButton.layoutData = new AnchorLayoutData(NaN,NaN,NaN,100);
			popUp.addChild(imageButton);
			this.stage.addChild( popUp );
			PopUpManager.centerPopUp(popUp);
		}
		
		private function removeLayerButton_triggeredHandler(event:Event):void
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

		public function LayersPanel()
		{
			super();
			//DataManager.instance.addEventListener(Event.ADDED, dataManager_addedHandler);
		
		}
		override public function dispose():void
		{
			super.dispose();
			//DataManager.instance.removeEventListener(Event.ADDED, dataManager_addedHandler);
		}

		protected function dataManager_selectHandler(e:Event):void
		{
			this.listDisplay.selectedIndex = e.data.index;
		}
	}
}