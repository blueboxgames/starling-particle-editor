package com.grantech.controls.items
{
	import com.grantech.models.LayerDataModel;

	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.ScaleMode;

	public class LayerListItemRenderer extends AbstractTouchableListItemRenderer
	{
		static public const DETAILS_ICON:int = 1;
		static public const DETAILS_NAME:int = 2;
		static public const DETAILS_VISIBILITY:int = 3;


		private var titleDisplay:Label;
		private var layer:LayerDataModel;
		private var iconDisplay:ImageLoader;
		private var visibilityDisplay:ImageLoader;
		public function LayerListItemRenderer() { super(); }

		override protected function initialize():void
		{
			super.initialize();
			this.height = 48;

			this.backgroundDisabledSkin = new Quad(1, 1, 0x333333);
			this.backgroundSelectedSkin = new Quad(1, 1, 0x666666);

			this.layout = new AnchorLayout();

			this.iconDisplay = new ImageLoader();
			this.iconDisplay.layoutData = new AnchorLayoutData(2, NaN, 2, 2);
			this.addChild(this.iconDisplay);

			this.visibilityDisplay = new ImageLoader();
			this.visibilityDisplay.width = this.height;
			this.visibilityDisplay.scaleMode = ScaleMode.NONE;
			this.visibilityDisplay.layoutData = new AnchorLayoutData(0, 0, 0);
			this.visibilityDisplay.source = Main.assetManager.getTexture("visibility");
			this.addChild(this.visibilityDisplay);

			this.titleDisplay = new Label();
			this.titleDisplay.layoutData = new AnchorLayoutData(NaN, NaN, NaN, this.height + 2, NaN, 0);
			this.addChild(this.titleDisplay);
		}

		override protected function commitData():void
		{
			super.commitData();
			
			if( this.data == null )
				return;
			this.layer = data as LayerDataModel;
			this.titleDisplay.text = this.layer.name;
			this.iconDisplay.source = layer.texture;
			this.visibilityDisplay.alpha = this.layer.visible ? 1 : 0.2;
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			if( value )
				this.layer.addEventListener(Event.CHANGE, this.layer_changeHandler);
			this.backgroundSkin = value ? this.backgroundSelectedSkin : this.backgroundDisabledSkin;
		}

		override protected function touchHandler( event:TouchEvent ):void
		{
			if( !_isEnabled || super.currentState == STATE_DISABLED )
			{
				touchID = -1;
				return;
			}
			if( touchID >= 0 )
			{
				touch = event.getTouch( touchTarget, null, touchID );
				if( !touch )
					return;
				
				if( touch.phase == TouchPhase.ENDED )
				{
					touch.getLocation( touchTarget.stage, AbstractTouchableListItemRenderer.HELPER_POINT );
					var isInBounds:Boolean = touchTarget.contains( touchTarget.stage.hitTest( HELPER_POINT ) );
					if( isInBounds )
					{
						if( touch.target == visibilityDisplay )
						{
							this.layer.visible = !this.layer.visible;
							this.visibilityDisplay.alpha = this.layer.visible ? 1 : 0.2;
							_owner.dispatchEventWith(Event.SELECT, false, [layer, DETAILS_VISIBILITY, this]);
							return;
						}

						if( touch.tapCount == 2 )
						{
							var details:int = -1;
							if( touch.target == iconDisplay )
								details = DETAILS_ICON;
							else if( touch.target == titleDisplay )
								details = DETAILS_NAME;
							_owner.dispatchEventWith(Event.SELECT, false, [layer, details, touch.target]);
						}
						dispatchEventWith(Event.TRIGGERED);
						if( _owner.allowMultipleSelection )
							setSelection(!isSelected);
						else
							setSelection(true);
					}
					// the touch has ended, so now we can start watching for a new one.
					touchID = -1;
				}
				else if( touch.phase == TouchPhase.MOVED )
				{
					if( Math.abs(touch.globalX - touch.previousGlobalX) > 10 || Math.abs(touch.globalY - touch.previousGlobalY) > 10 )
					{
						currentState = STATE_NORMAL;
						touchID = -1;
					}
				}
				return;
			}
			else
			{
				// we aren't tracking another touch, so let's look for a new one.
				touch = event.getTouch( touchTarget, TouchPhase.BEGAN );
				if( touch != null )
				{
					currentState = STATE_DOWN;
				}
				else
				{
					// we only care about the began phase. ignore all other phases.
					return;
				}
				// save the touch ID so that we can track this touch's phases.
				touchID = touch.id;
			}
		}

		protected function layer_changeHandler(event:Event):void
		{
			if( event.data == "texture" )
				this.iconDisplay.source = layer.getProperty(event.data as String);
			if( event.data == "name" )
				this.titleDisplay.text = layer.getProperty(event.data as String);
		}
	}
}