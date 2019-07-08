package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;
	import com.grantech.models.ControlsHelper;
	import com.grantech.utils.Localizations;

	import feathers.controls.ColorPicker;
	import feathers.controls.EditableSlider;
	import feathers.controls.Label;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;

	import starling.events.Event;

	public class InspectorListItemRenderer extends AbstractTouchableListItemRenderer
	{
		private var key:String;
		private var value:*;

		private var labelDisplay:Label;
		private var sliderDisplay:EditableSlider;
		private var colorPickerDisplay:ColorPicker;
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

			this.labelDisplay = new Label();
			this.labelDisplay.layoutData = new HorizontalLayoutData(50);
			this.addChild(this.labelDisplay);
		}

		override protected function commitData():void
		{
			super.commitData();
			if( this._data == null || this._owner == null )
				return;
			this.removeChildren();
			this.key = this._data.key as String;
			
			this.value = DataManager.instance.layers.getItemAt(DataManager.instance.currentLayerIndex).getProperty(this.key);
			this.labelDisplay.text = Localizations.instance.get(this.key);
			this.addChild(this.labelDisplay);
			if( ControlsHelper.instance.getType(this.key) == ControlsHelper.TYPE_COLOR_PICKER )
				createColorPicker();
			else
				createSlider();
		}

		private function sliderDisplay_changeHandler(e:Event):void
		{
			this.value = this.sliderDisplay.value;
			DataManager.instance.editCurrentLayerData(this.key, this.value);			
		}

		private function colorPickerDisplay_changeHandler(e:Event):void
		{
			this.value = this.colorPickerDisplay.data;
			DataManager.instance.editCurrentLayerData(this.key, this.value);			
		}

		private function createSlider():void
		{
			if( this.colorPickerDisplay !=null )
			{
				this.colorPickerDisplay = null;
			}
			this.sliderDisplay = new EditableSlider();
			this.sliderDisplay.addEventListener(Event.CHANGE, sliderDisplay_changeHandler);
			this.sliderDisplay.layoutData = new HorizontalLayoutData(50);
			
			this.sliderDisplay.step = ControlsHelper.instance.getStep(this.key);
			this.sliderDisplay.minimum = ControlsHelper.instance.getMin(this.key);
			this.sliderDisplay.maximum = ControlsHelper.instance.getMax(this.key);
			this.sliderDisplay.value = this.value;
			this.addChild(this.sliderDisplay);
		}

		private function createColorPicker():void
		{
			if( this.sliderDisplay !=null )
			{
				this.sliderDisplay = null;
			}
			this.colorPickerDisplay = new ColorPicker();
			this.colorPickerDisplay.addEventListener(Event.CHANGE, colorPickerDisplay_changeHandler);
			this.colorPickerDisplay.layoutData = new HorizontalLayoutData(50);
			
			this.colorPickerDisplay.data = this.value;
			this.addChild(this.colorPickerDisplay);
		}
	}
}