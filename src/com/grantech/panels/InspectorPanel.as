package com.grantech.panels
 {
	import com.grantech.controls.items.InspectorButtonListItemRenderer;
	import com.grantech.controls.items.InspectorColorListItemRenderer;
	import com.grantech.controls.items.InspectorComboListItemRenderer;
	import com.grantech.controls.items.InspectorSliderListItemRenderer;
	import com.grantech.managers.DataManager;
	import com.grantech.models.ControlsHelper;
	import com.grantech.utils.Localizations;

	import feathers.controls.GroupedList;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollBarDisplayMode;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.ArrayHierarchicalCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.events.Event;

	public class InspectorPanel extends PanelScreen
	{
		private var groupedList:GroupedList;
		
		public function InspectorPanel()
		{
			super();
			DataManager.instance.addEventListener(Event.SELECT, dataManager_selectHandler);
		}

		protected function dataManager_selectHandler(event:Event):void
		{
			// if(this.groupedList.dataProvider == DataManager.instance.currentlayer.get)
			// 	return;
			var collection:ArrayHierarchicalCollection = DataManager.instance.currentlayer.getHierarchicalCollection();
			this.groupedList.dataProvider = collection;
		}

		/**
		 * Initializes InspectorPanel.
		 */
		override protected function initialize():void
		{
			super.initialize();
			this.layout = new AnchorLayout();
			this.title = Localizations.instance.get("inspector_panel_title");

			this.groupedList = new GroupedList();
			this.groupedList.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.groupedList.scrollBarDisplayMode = ScrollBarDisplayMode.FLOAT;
			this.groupedList.setItemRendererFactoryWithID(ControlsHelper.TYPE_BUTTON,				function ():IGroupedListItemRenderer { return new InspectorButtonListItemRenderer() as IGroupedListItemRenderer; } );
			this.groupedList.setItemRendererFactoryWithID(ControlsHelper.TYPE_SLIDER, 			function ():IGroupedListItemRenderer { return new InspectorSliderListItemRenderer() as IGroupedListItemRenderer; } );
			this.groupedList.setItemRendererFactoryWithID(ControlsHelper.TYPE_COMBO_BOX,		function ():IGroupedListItemRenderer { return new InspectorComboListItemRenderer() as IGroupedListItemRenderer; } );
			this.groupedList.setItemRendererFactoryWithID(ControlsHelper.TYPE_COLOR_PICKER,	function ():IGroupedListItemRenderer { return new InspectorColorListItemRenderer() as IGroupedListItemRenderer; } );
			this.groupedList.factoryIDFunction = function(item:Object, groupIndex:int, itemIndex:int):String
			{
					return item.type;
			};
			this.addChild(this.groupedList);
		}
	}
}