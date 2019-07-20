package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;
	import com.grantech.models.ControlsHelper;

	import feathers.controls.Button;
	import feathers.controls.ColorPicker;
	import feathers.controls.EditableSlider;
	import feathers.controls.Label;
	import feathers.controls.PickerList;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.renderers.LayoutGroupGroupedListItemRenderer;
	import feathers.data.IListCollection;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;

	import flash.display3D.Context3DBlendFactor;
	import flash.filesystem.File;

	import starling.events.Event;

	public class InspectorListItemRenderer extends LayoutGroupGroupedListItemRenderer implements IGroupedListItemRenderer
	{
		private var key:String;
		private var value:*;

		private var labelDisplay:Label;
		private var sliderDisplay:EditableSlider;
		private var colorPickerDisplay:ColorPicker;
		private var dropDownDisplay:PickerList;
		private var browseDisplay:Button;
		
		public function InspectorListItemRenderer()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			this.removeChildren();

			var hLayout:HorizontalLayout = new HorizontalLayout();
			hLayout.gap = 5;
			this.layout = hLayout;

			this.labelDisplay = new Label();
			this.labelDisplay.layoutData = new HorizontalLayoutData(50);
		}

		override protected function commitData():void
		{
			super.commitData();
			if( this._data == null || this._owner == null )
				return;
			this.removeChildren();
			this.key = this._data.key as String;

			this.value = this._data.value;
			this.labelDisplay.text = this._data.text;
			this.addChild(this.labelDisplay);
			if( ControlsHelper.instance.getType(this.key) == ControlsHelper.TYPE_COLOR_PICKER )
				createColorPicker();
			else if( ControlsHelper.instance.getType(this.key) == ControlsHelper.TYPE_DROPDOWN )
				createDropDown();
			else if ( ControlsHelper.instance.getType(this.key) == ControlsHelper.TYPE_BROWSE )
				createBrowse();
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

		private function dropDownDisplay_changeHandler(e:Event):void
		{
			this.value = this.dropDownDisplay.selectedItem.text;
			if(this.key == "blendFuncSource")
				DataManager.instance.editCurrentLayerData("blendFuncSource", this.value);
			if(this.key == "blendFuncDestination")
				DataManager.instance.editCurrentLayerData("blendFuncDestination", this.value);
		}

		private function createSlider():void
		{
			if( this.colorPickerDisplay != null )
			{
				this.colorPickerDisplay = null;
			}
			this.sliderDisplay = new EditableSlider();
			this.sliderDisplay.addEventListener(Event.CHANGE, sliderDisplay_changeHandler);
			this.sliderDisplay.layoutData = new HorizontalLayoutData(50);

			if(this.key == "x" || this.key == "y")
			{
				this.sliderDisplay.step = 1;
				this.sliderDisplay.minimum = int.MIN_VALUE;
				this.sliderDisplay.maximum = int.MAX_VALUE;
			}
			else
			{
				this.sliderDisplay.step = ControlsHelper.instance.getStep(this.key);
				this.sliderDisplay.minimum = ControlsHelper.instance.getMin(this.key);
				this.sliderDisplay.maximum = ControlsHelper.instance.getMax(this.key);
			}
			this.sliderDisplay.value = this.value;
			this.addChild(this.sliderDisplay);
		}

		private function createDropDown():void
		{
			// BUG: trace("?") creates double component.
			if( this.dropDownDisplay != null )
			{
				this.dropDownDisplay = null;
			}
			this.dropDownDisplay = new PickerList();
			if (this.key == "blendFuncSource" || this.key == "blendFuncDestination")
			{
				var blendModes:IListCollection = new ListCollection(
					[
						{ text: Context3DBlendFactor.ZERO, value: 0 },
						{ text: Context3DBlendFactor.ONE, value: 1 },
						{ text: Context3DBlendFactor.SOURCE_COLOR, value: 0x300 },
						{ text: Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR, value: 0x301 },
						{ text: Context3DBlendFactor.SOURCE_ALPHA, value: 0x302 },
						{ text: Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA, value: 0x303 },
						{ text: Context3DBlendFactor.DESTINATION_ALPHA, value: 0x304 },
						{ text: Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA, value: 0x305 },
						{ text: Context3DBlendFactor.DESTINATION_COLOR, value: 0x306 },
						{ text: Context3DBlendFactor.ONE_MINUS_DESTINATION_COLOR, value: 0x307 }
					]
				);
				this.dropDownDisplay.dataProvider = blendModes;
				this.dropDownDisplay.labelField = "text";
				// TODO: Write a workaround for prompt showing text instead of
				// value.
				this.dropDownDisplay.prompt = this.value;
				this.dropDownDisplay.selectedIndex = -1;
				this.dropDownDisplay.itemRendererFactory = function():IListItemRenderer
				{
					var itemRenderer:DefaultListItemRenderer = new DefaultListItemRenderer();
					itemRenderer.labelField = "text";
					return itemRenderer;
				}
				this.dropDownDisplay.layoutData = new HorizontalLayoutData(50);
			}
			this.dropDownDisplay.popUpContentManager = new CalloutPopUpContentManager();
			this.dropDownDisplay.addEventListener(Event.CHANGE, dropDownDisplay_changeHandler);
			this.addChild(this.dropDownDisplay);
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

		private function createBrowse():void
		{
			if (this.browseDisplay != null)
				this.browseDisplay = null;
			
			this.browseDisplay = new Button();
			this.browseDisplay.label = "Browse";
			this.browseDisplay.addEventListener(Event.TRIGGERED, browseDisplay_triggeredHandler);
			this.browseDisplay.layoutData = new HorizontalLayoutData(50);
			this.addChild(this.browseDisplay);
		}

		protected function browseDisplay_triggeredHandler(e:Event):void
		{
			this.value = new File();
			this.value.addEventListener(Event.SELECT, file_SelectHandler);
			this.value.browse();
		}

		protected function file_SelectHandler(e:*):void
		{
			this.value = this.value.nativePath;
			DataManager.instance.editCurrentLayerData(this.key, this.value);
		}
	}
}