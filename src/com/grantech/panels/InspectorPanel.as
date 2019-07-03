package com.grantech.panels
 {
	import com.grantech.controls.items.InspectorListItemRenderer;
	import com.grantech.managers.DataManager;
	import com.grantech.utils.Localizations;

	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;


	public class InspectorPanel extends PanelScreen
	{
		private var list:List;
		
		public function InspectorPanel()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			this.layout = new AnchorLayout();
			this.title = Localizations.instance.get("inspector_panel_title");
			
			this.list = new List();
			this.list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.list.dataProvider = DataManager.instance.inspector;
			this.list.itemRendererFactory = function () : IListItemRenderer
			{
				return new InspectorListItemRenderer();
			}
			this.addChild(this.list);
		}
	}
}