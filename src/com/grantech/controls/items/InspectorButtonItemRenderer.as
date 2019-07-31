package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;

	import feathers.controls.Button;

	import starling.events.Event;
	
	public class InspectorButtonItemRenderer extends InspectorBaseItemRenderer
	{
		public function InspectorButtonItemRenderer() { super(); }
		override protected function redrawControl():void
		{
			super.redrawControl();

			if (this.valueDisplay == null)
			{
				this.valueDisplay = new Button();
				this.valueDisplay.layoutData = VALUE_LAYOUTDATA;
				this.addChild(this.valueDisplay);
			}
			
			// var blendModes:Array = ControlsHelper.instance.getData(this.label) as Array;
			var button:Button = valueDisplay as Button;
			button.label = this.value;
			if (!button.hasEventListener(Event.TRIGGERED))
				button.addEventListener(Event.TRIGGERED, button_triggeredHandler);
		}
		private function button_triggeredHandler(e:Event):void
		{
			var button:Button = valueDisplay as Button;
			if (button.label == this.value)
				return;
			this.value = button.label;
			DataManager.instance.selectedlayer.setProperty(this.label, this.value);
		}
	}
}