package com.grantech.toolgen.panels
{
	import com.grantech.toolgen.controls.items.LayerListItemRenderer;
	import com.grantech.toolgen.utils.Localizations;

	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;

	import starling.events.Event;
	import starling.display.Quad;
	import feathers.skins.ImageSkin;
	import feathers.controls.ImageLoader;
	import starling.textures.Texture;
	import flash.display.Bitmap;
	import starling.display.Image;
	import com.grantech.manager.ParticleManager;

	public class LayersPanel extends PanelScreen
	{
		static public var data:ListCollection = new ListCollection();
		private var listDisplay:List;
		
		[Embed(source="/media/icons/addLayer.png")]
		public static var addLayer:Class;

		[Embed(source="/media/icons/removeLayer.png")]
		public static var removeLayer:Class;

		override protected function initialize():void
		{
			super.initialize();
			layout= new AnchorLayout();

			this.title = Localizations.instance.get("layers");
			
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
			listDisplay.dataProvider = data;
			addChild(listDisplay);

			this.footerFactory = function():LayoutGroup {
				var footer:LayoutGroup = new LayoutGroup();
				footer.backgroundSkin = new Quad(1,1, 0xff0000);
				var layoutType:HorizontalLayout = new HorizontalLayout();
				footer.layout = layoutType;

				var addButton:Button = new Button();
				//addButton.label = Localizations.instance.get("add");
				var addButtonIcon:Image = new Image(Texture.fromBitmap(new addLayer()));
				addButtonIcon.width = 24;
				addButtonIcon.height = 24;
				addButton.defaultIcon = addButtonIcon;
				addButton.addEventListener(Event.TRIGGERED, addButton_triggeredHandler);
				
				var removeButton:Button = new Button();
				//removeButton.label = Localizations.instance.get("remove");
				var removeButtonIcon:Image = new Image(Texture.fromBitmap(new removeLayer()));
				removeButtonIcon.width = 24;
				removeButtonIcon.height = 24;
				removeButton.defaultIcon = removeButtonIcon;
				removeButton.addEventListener(Event.TRIGGERED, removeButton_triggeredHandler);

				footer.addChild(addButton);
				footer.addChild(removeButton);
				return footer;
			}
		}
		
		private function addButton_triggeredHandler(event:Event):void
		{
			var selectedIndex:int = listDisplay.selectedIndex;
			data.addItem({});
			if(selectedIndex < 0)
			{
				listDisplay.selectedIndex = selectedIndex + 1;
			}
		}
		
		private function removeButton_triggeredHandler(event:Event):void
		{
			var selectedIndex:int = listDisplay.selectedIndex;
			if( selectedIndex < 0 )
				return;
			data.removeItemAt(selectedIndex);
			if( selectedIndex > 0 )
				listDisplay.selectedIndex = selectedIndex - 1;
		}

	}
}