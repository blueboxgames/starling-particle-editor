package com.grantech.panels
{
	import com.grantech.controls.items.FooterItemRenderer;
	import com.grantech.controls.items.LayerListItemRenderer;
	import com.grantech.managers.DataManager;
	import com.grantech.models.LayerDataModel;
	import com.grantech.utils.Localizations;

	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollBarDisplayMode;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;

	import starling.display.Quad;
	import starling.events.Event;

	public class LayersPanel extends PanelScreen
	{
		private var listDisplay:List;


		public function LayersPanel() { super(); }
		override protected function initialize():void
		{
			super.initialize();
			this.title = Localizations.instance.get("layers_panel_title");
			this.layout = new AnchorLayout();
			
			this.listDisplay = new List();
			this.listDisplay.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.listDisplay.scrollBarDisplayMode = ScrollBarDisplayMode.FLOAT;
			this.listDisplay.itemRendererFactory = function():IListItemRenderer
			{
				return new LayerListItemRenderer() as IListItemRenderer;
			}
			this.listDisplay.selectedIndex = -1;
			this.listDisplay.dataProvider = DataManager.instance.layerDataProvider;
			this.listDisplay.addEventListener(Event.CHANGE, listDisplay_changeHandler);
			this.addChild(this.listDisplay);
			
			this.footerFactory = layersPanelFooterFactory;
		}

		protected function layersPanelFooterFactory():List
		{
			var footerLayout:HorizontalLayout = new HorizontalLayout();
			footerLayout.padding = footerLayout.gap = 2;
			footerLayout.horizontalAlign = HorizontalAlign.RIGHT;

			var footer:List = new List();
			footer.layout = footerLayout;
			footer.backgroundSkin = new Quad(1,1, 0x272822);
			footer.itemRendererFactory = function () : IListItemRenderer { return new  FooterItemRenderer(); }
			footer.dataProvider = new ListCollection([FooterItemRenderer.TYPE_ADD, FooterItemRenderer.TYPE_REMOVE, FooterItemRenderer.TYPE_UP, FooterItemRenderer.TYPE_DOWN, FooterItemRenderer.TYPE_SAVE]);
			footer.addEventListener(Event.CHANGE, footer_changeHandler);
			return footer;
		}

		protected function dataManager_selectHandler(event:Event):void
		{
			this.listDisplay.removeEventListener(Event.CHANGE, listDisplay_changeHandler);
			this.listDisplay.selectedIndex = event.data.index;
			this.listDisplay.addEventListener(Event.CHANGE, listDisplay_changeHandler);
		}

		protected function listDisplay_changeHandler(event:Event):void
		{
			if( this.listDisplay.selectedIndex < 0 )
				return;
			DataManager.instance.selectLayerAt(this.listDisplay.selectedIndex);
		}

		protected function footer_changeHandler(event:Event):void
		{
			if( List(footer).selectedIndex < 0 )
				return;
			var selectedItem:String = List(footer).selectedItem as String;
			switch( selectedItem )
			{
				case FooterItemRenderer.TYPE_ADD:
					addLayer();
					break;
				
				case FooterItemRenderer.TYPE_REMOVE:
					removeLayer();
					break;
				
				case FooterItemRenderer.TYPE_UP:
					DataManager.instance.shiftTop(listDisplay.selectedIndex);
					break;
				
				case FooterItemRenderer.TYPE_DOWN:
					DataManager.instance.shiftDown(listDisplay.selectedIndex);
					break;
			}
			List(footer).selectedIndex = -1;
		}

		protected function addLayer():void
		{
			// When a new layer is added we select it from list display too.
			// DataManager.instance.addLayer();
			var popUp:Panel = new Panel();
			popUp.layout = new AnchorLayout();
			var particleButton:Button = new Button();
			particleButton.label = "Particle";
			particleButton.layoutData = new AnchorLayoutData(NaN,100,NaN,NaN);
			popUp.addChild(particleButton);
			particleButton.addEventListener(Event.TRIGGERED, function():void
			{
				DataManager.instance.addLayer(LayerDataModel.TYPE_PARTICLE);
				popUp.removeFromParent();
			});

			var imageButton:Button = new Button();
			imageButton.label = "Image";
			imageButton.layoutData = new AnchorLayoutData(NaN,NaN,NaN,100);
			popUp.addChild(imageButton);
			this.stage.addChild( popUp );
			PopUpManager.centerPopUp(popUp);
		}

		private function removeLayer():void
		{
			var selectedIndex:int = listDisplay.selectedIndex;
			if( selectedIndex < 0 )
				return;
			DataManager.instance.removeLayerAt(selectedIndex);
			if( selectedIndex > 0 )
				listDisplay.selectedIndex = selectedIndex - 1;
		}
	}
}