package com.grantech.controls.items
{
	import feathers.controls.EditableSlider;
	import feathers.controls.Label;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;

	public class InspectorListItemRenderer extends AbstractTouchableListItemRenderer
	{
		private var label:Label;
		private var component:EditableSlider;
		public function InspectorListItemRenderer()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();

			var hLayout:HorizontalLayout = new HorizontalLayout();
			hLayout.gap = 5;
			this.layout = hLayout;

			this.label = new Label();
			this.label.layoutData = new HorizontalLayoutData(50);
			this.addChild(this.label);

			this.component = new EditableSlider();
			this.component.layoutData = new HorizontalLayoutData(50);
			this.addChild(this.component);
		}

		override protected function commitData():void
		{
			super.commitData();
			if(this.data == null)
				return;
				
			// DataManager.instance.inspector
			this.label.text = this.data.name;
		}
	}
}