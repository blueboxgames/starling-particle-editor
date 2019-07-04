package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;

	import feathers.controls.EditableSlider;
	import feathers.controls.Label;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;

	import starling.events.Event;

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
			if(this._data && this._owner)
			{
				this.label.text = this.data.label;
				this.component.value = this.data.value as Number;
				this.component.step = this.data.step as Number;
				this.component.minimum = this.data.min as Number;
				this.component.maximum = this.data.max as Number;
			}
			this.component.addEventListener(Event.CHANGE, component_changeHandler);
		}

		private function component_changeHandler(e:Event):void
		{
			DataManager.instance.editCurrentLayerData(this.data.label, this.component.value);			
		}
	}
}