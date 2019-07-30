package com.grantech.controls.items
{
	import com.grantech.managers.DataManager;

	import feathers.controls.Label;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.renderers.LayoutGroupGroupedListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.events.Event;

	/**
	 * InspectorBaseItemRenderer is a view which renders information from DataModels.
	 */
	public class InspectorBaseItemRenderer extends LayoutGroupGroupedListItemRenderer implements IGroupedListItemRenderer
	{
		static protected const LABEL_LAYOUTDATA:AnchorLayoutData = new AnchorLayoutData(NaN, NaN, NaN, 6, NaN, 0);
		static protected const VALUE_LAYOUTDATA:AnchorLayoutData = new AnchorLayoutData(2, 4, 2, 180);

		private var _label:String;
		private var _value:*;

		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			if(this._label == value)
				return;
			this._label = value;
			this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
		}

		public function get value():*
		{
			return _value;
		}
		public function set value(val:*):void
		{
			if(this._value == val)
				return;
			this._value = val;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		

		// DisplayObjects
		// ---------------------------------------
		protected var labelDisplay:Label;
		protected var valueDisplay:FeathersControl;
		
		static protected var nums:Object = new Object();
		public function InspectorBaseItemRenderer()
		{
			super();
			this.minHeight = 32;
 			/*var cls:String = getQualifiedClassName(this)
			nums[cls] = nums.hasOwnProperty(cls) ? nums[cls] + 1 : 0;
			trace(cls, nums[cls]);*/
 		}

		override protected function initialize():void
		{
			super.initialize();
			this.layout = new AnchorLayout();
		}

		override protected function commitData():void
		{
			super.commitData();
			if( this._data == null || this._owner == null )
				return;

			if( !this._owner.hasEventListener(FeathersEventType.SCROLL_START) )
				this._owner.addEventListener(FeathersEventType.SCROLL_START, owner_scrollStartHandler);
			this.label = this.data.label as String;
			this.value = DataManager.instance.currentlayer.getProperty(this.label);
		}
		
		protected function owner_scrollStartHandler(event:Event):void { }

		override protected function draw():void
		{
			super.draw();
			if( this.isInvalid(INVALIDATION_FLAG_TEXT_RENDERER) ) 
				redrawLabel();
			if( this.isInvalid(INVALIDATION_FLAG_DATA) ) 
				redrawControl();
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

		protected function redrawControl():void
		{
		}
	}
}