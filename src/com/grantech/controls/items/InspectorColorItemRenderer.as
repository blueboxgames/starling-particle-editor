package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;

	import feathers.controls.ColorPicker;

	import starling.events.Event;
	
	public class InspectorColorItemRenderer extends InspectorBaseItemRenderer
	{
		public function InspectorColorItemRenderer() { super(); }
		override protected function redrawControl():void
		{
			super.redrawControl();

			if (this.valueDisplay == null)
			{
				this.valueDisplay = new ColorPicker();
				this.valueDisplay.layoutData = VALUE_LAYOUTDATA;
				this.addChild(this.valueDisplay);
			}
			
			var colorPicker:ColorPicker = valueDisplay as ColorPicker;
			colorPicker.removeEventListeners(Event.CHANGE);
			colorPicker.data = this.value;
			colorPicker.addEventListener(Event.CHANGE, colorPickerDisplay_changeHandler);
		}
		private function colorPickerDisplay_changeHandler(e:Event):void
		{
			var colorPicker:ColorPicker = valueDisplay as ColorPicker;
			if (colorPicker.data == this.value)
				return;
			this.value = colorPicker.data;
			DataManager.instance.selectedlayer.setProperty(this.label, this.value);
		}
	}
}