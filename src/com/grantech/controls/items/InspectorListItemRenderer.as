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
	import feathers.data.ArrayCollection;
	import feathers.data.IListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import flash.display3D.Context3DBlendFactor;

	import starling.events.Event;

	/**
	 * InspectorListItemRenderer is a view which renders information from DataModels.
	 */
	public class InspectorListItemRenderer extends LayoutGroupGroupedListItemRenderer implements IGroupedListItemRenderer
	{
		protected static const INVALIDATION_FLAG_LABEL:String = "label";
		static private const LABEL_LAYOUTDATA:AnchorLayoutData = new AnchorLayoutData(NaN, 130, NaN, 10);
		static private const VALUE_LAYOUTDATA:AnchorLayoutData = new AnchorLayoutData(NaN, 10, NaN, 130);
		// Data from `AbstractGroupCollectionModel`
		// ---------------------------------------
		private var _key:String;
		private var _label:String;
		private var _value:*;
		// ---------------------------------------

		public function get key():String
		{
			return _key;
		}
		
		public function set key(value:String):void
		{
			if(this._key == value)
				return;

			this._key = value;
		}

		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			if(this._label == value)
				return;
			this._label = value;
			this.invalidate(INVALIDATION_FLAG_LABEL);
		}

		public function get value():*
		{
			return _value;
		}
		
		public function set value(value:*):void
		{
			this._value = value;
		}

		private var _controlType:int;
		
		public function get controlType():int
		{
			return _controlType;
		}
		
		public function set controlType(value:int):void
		{
			if(this._controlType == value)
				return;
			this._controlType = value;
		}
		

		// DisplayObjects
		// ---------------------------------------
		private var labelDisplay:Label;
		private var sliderDisplay:EditableSlider;
		private var colorPickerDisplay:ColorPicker;
		private var dropDownDisplay:PickerList;
		private var browseDisplay:Button;
		// ---------------------------------------
		
		public function InspectorListItemRenderer()
		{
			super();
			// DataManager.instance.addEventListener(Event.SELECT, dataManager_selectHandler);
		}

		override protected function initialize():void
		{
			super.initialize();
			this.layout = new AnchorLayout();
		}

		// protected function dataManager_selectHandler(event:Event):void
		// {
		// 	this.invalidate(INVALIDATION_FLAG_DATA);
		// }

		override protected function commitData():void
		{
			super.commitData();
			if( this._data == null || this._owner == null )
				return;

			this.key = this.data.key as String;
			this.label = this.data.label as String;
			this.value = DataManager.instance.currentlayer.getProperty(this.key);
			redrawControls();
		}

		override protected function draw():void
		{
			super.draw();
			var labelInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_LABEL);
			
			if(labelInvalid) redrawLabel();
		}

		protected function redrawLabel():void
		{
			if(this.labelDisplay == null)
			{
				this.labelDisplay = new Label();
				this.labelDisplay.layoutData = LABEL_LAYOUTDATA;
				this.addChild(labelDisplay);
			}
			this.labelDisplay.text = this.label;
		}

		protected function redrawControls():void
		{
			removeChildren();

			switch(ControlsHelper.instance.getType(this.key))
			{
				case ControlsHelper.TYPE_COLOR_PICKER:
					//drawColorPicker();
					break;
				case ControlsHelper.TYPE_DROPDOWN:
					//drawDropDown();
					break;
				case ControlsHelper.TYPE_BROWSE:
					//drawBrowseButton();
					break;
				default:
					drawSlider();
					break;
			}
		}

		protected function drawSlider():void
		{
			if(this.sliderDisplay == null)
			{
				this.sliderDisplay = new EditableSlider();
				this.sliderDisplay.layoutData = VALUE_LAYOUTDATA
				this.sliderDisplay.addEventListener(Event.CHANGE, sliderDisplay_changeHandler);
			}

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
			this.controlType = ControlsHelper.TYPE_SLIDER;
		}

		private function drawDropDown():void
		{
			if(this.dropDownDisplay == null)
			{
				this.dropDownDisplay = new PickerList();
				this.dropDownDisplay.layoutData = new AnchorLayoutData(0,0,0,0);
				this.dropDownDisplay.addEventListener(Event.CHANGE, dropDownDisplay_changeHandler);
				this.controlType = ControlsHelper.TYPE_DROPDOWN;
				
				var blendModes:IListCollection = new ArrayCollection(
					[
						{ value: Context3DBlendFactor.ZERO },
						{ value: Context3DBlendFactor.ONE },
						{ value: Context3DBlendFactor.SOURCE_COLOR },
						{ value: Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR },
						{ value: Context3DBlendFactor.SOURCE_ALPHA },
						{ value: Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA },
						{ value: Context3DBlendFactor.DESTINATION_ALPHA },
						{ value: Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA },
						{ value: Context3DBlendFactor.DESTINATION_COLOR },
						{ value: Context3DBlendFactor.ONE_MINUS_DESTINATION_COLOR }
					]
				);
					
				this.dropDownDisplay.dataProvider = blendModes;
				this.dropDownDisplay.labelField = "text";
				this.dropDownDisplay.selectedIndex = -1;

				for(var i:int=0; i < blendModes.length; i++)
				{
					if (blendModes.getItemAt(i).value == this.value) 
					{
						this.dropDownDisplay.selectedIndex = i;
					}
				}
				this.dropDownDisplay.prompt = blendModes.getItemAt(this.dropDownDisplay.selectedIndex).value;
				this.dropDownDisplay.itemRendererFactory = function():IListItemRenderer
				{
					var itemRenderer:DefaultListItemRenderer = new DefaultListItemRenderer();
					itemRenderer.labelField = "text";
					return itemRenderer;
				}
				this.dropDownDisplay.popUpContentManager = new CalloutPopUpContentManager();
			}
			
			this.addChild(this.dropDownDisplay);
		}
		
		// protected function drawColorPicker():void
		// {
		// 	if(this.colorPickerDisplay == null)
		// 	{
		// 		this.colorPickerDisplay = new ColorPicker();
		// 		this.colorPickerDisplay.layoutData = new AnchorLayoutData(0,0,0,0);
		// 		this.colorPickerDisplay.addEventListener(Event.CHANGE, colorPickerDisplay_changeHandler);
		// 	}
		// 	this.valueHolderDisplay.removeChildren();
		// 	this.colorPickerDisplay.data = this.value;
		// 	this.valueHolderDisplay.addChild(this.colorPickerDisplay);
		// 	this.controlType = ControlsHelper.TYPE_COLOR_PICKER;
		// }

		// private function drawBrowseButton():void
		// {
		// 	if (this.browseDisplay == null)
		// 	{
		// 		this.browseDisplay = new Button();
		// 		this.browseDisplay.label = "Browse";
		// 		this.browseDisplay.layoutData = new AnchorLayoutData(0,0,0,0);
		// 		this.browseDisplay.addEventListener(Event.TRIGGERED, browseDisplay_triggeredHandler);
		// 	}
		// 	this.valueHolderDisplay.addChild(this.browseDisplay);
		// 	this.controlType = ControlsHelper.TYPE_BROWSE;
		// }

		// protected function browseDisplay_triggeredHandler(e:Event):void
		// {
		// 	this.value = new File();
		// 	this.value.addEventListener(Event.SELECT, file_SelectHandler);
		// 	this.value.browse();
		// }

		// protected function file_SelectHandler(e:*):void
		// {
		// 	this.value = this._value.nativePath;
		// 	DataManager.instance.editCurrentLayerData(this.key, this._value);
		// }

		private function sliderDisplay_changeHandler(e:Event):void
		{
			if(this.sliderDisplay == null)
				return;
			if(this.sliderDisplay.value == this.value)
				return;
			this.value = this.sliderDisplay.value;
			DataManager.instance.currentlayer.setProperty(this.key, this.value);
		}

		// private function colorPickerDisplay_changeHandler(e:Event):void
		// {
		// 	this.data.value = this.colorPickerDisplay.data;
		// 	// this.value = this.colorPickerDisplay.data;
		// 	DataManager.instance.editCurrentLayerData(this.key, this.data.value);
		// }

		private function dropDownDisplay_changeHandler(e:Event):void
		{
			if(this.dropDownDisplay == null)
				return;
			if(this.dropDownDisplay.selectedItem.value == this.value)
				return;
			this.value = this.dropDownDisplay.selectedItem.text;
			DataManager.instance.currentlayer.setProperty(this.key, this.value);
		}
	}
}