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
			// TODO: Write component generator based on some data.
			this.component.minimum = 0;
			this.component.maximum = 100;
			this.component.step = 1;
			this.component.layoutData = new HorizontalLayoutData(50);
			this.addChild(this.component);
		}

		override protected function commitData():void
		{
			super.commitData();
			if(this.data == null)
				return;
			if(this.data.value is Number)
			{
				this.label.text = this.data.label;
				this.component.value = this.data.value;
				this.component.addEventListener(Event.CHANGE, commitDataToList);
			}
			else
			{
				this.removeFromParent();
			}
		}

		private function commitDataToList(e:Event):void
		{
			DataManager.instance.dispatchEventWith("particleDataChanged",false, {label: this.data.label, value: this.component.value});
		}
	}
}