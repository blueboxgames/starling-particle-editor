package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;
	import com.grantech.models.ControlsHelper;

	import feathers.controls.EditableSlider;
	import feathers.core.FeathersControl;

	import starling.events.Event;

	public class InspectorSliderItemRenderer extends InspectorBaseItemRenderer
	{
		public function InspectorSliderItemRenderer() { super(); }
		override protected function redrawControl():void
		{
			super.redrawControl();

			if(this.valueDisplay == null)
			{
				this.valueDisplay = new EditableSlider() as FeathersControl;
				this.valueDisplay.layoutData = VALUE_LAYOUTDATA;
				this.addChild(this.valueDisplay);
			}
			
			var slider:EditableSlider = this.valueDisplay as EditableSlider;
			slider.removeEventListeners(Event.CHANGE);
			slider.step = ControlsHelper.instance.getStep(this.label);
			slider.minimum = ControlsHelper.instance.getMin(this.label);
			slider.maximum = ControlsHelper.instance.getMax(this.label);
			slider.value = this.value;
			slider.addEventListener(Event.CHANGE, slider_changeHandler);
		}

		override protected function owner_scrollStartHandler(event:Event):void
		{
			var slider:EditableSlider = this.valueDisplay as EditableSlider;
			if( slider == null )
				return;
			slider.currentState = EditableSlider.STATE_NONE;
		}

		protected function slider_changeHandler(event:Event):void
		{
			var slider:EditableSlider = this.valueDisplay as EditableSlider;
			if (slider.value == this.value)
				return;
			this.value = slider.value;
			DataManager.instance.selectedlayer.setProperty(this.label, this.value);
		}
	}
}