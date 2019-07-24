package com.grantech.panels
 {
	import com.grantech.controls.items.InspectorListItemRenderer;
	import com.grantech.managers.DataManager;
	import com.grantech.utils.Localizations;

	import feathers.controls.GroupedList;
	import feathers.controls.PanelScreen;
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
			if(this.groupedList.dataProvider == DataManager.instance.currentModel.propertiesCollection)
				return;
			this.groupedList.dataProvider = DataManager.instance.currentModel.propertiesCollection;
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
			this.groupedList.dataProvider = new ArrayHierarchicalCollection();
			this.groupedList.itemRendererFactory = function() : IGroupedListItemRenderer
			{
				return new InspectorListItemRenderer();
			}
			this.addChild(this.groupedList);
		}
	}
}