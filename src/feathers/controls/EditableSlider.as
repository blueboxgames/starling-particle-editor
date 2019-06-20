package feathers.controls
{
	import starling.events.Touch;
	import starling.events.TouchData;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Event;

	public class EditableSlider extends NumericStepper
	{
		public static const STATE_NONE:String = "stateNone";
		public static const STATE_HOVER:String = "stateHover";
		public static const STATE_EDIT:String = "stateEdit";
		public static const STATE_SLIDE:String = "stateSlide";

		public static const MOUSE_STATE_IN:String = "mouseIn";
		public static const MOUSE_STATE_OUT:String = "mouseOut";

		private var _touchData:TouchData;
		private var _currentState:String = STATE_NONE;
		private var _mouseState:String = MOUSE_STATE_OUT;
		private var _slideEnable:Boolean = true;

		public function get currentState():String
		{
			return _currentState;
		}

		public function set currentState(value:String):void
		{
			if(_currentState == value )
			{
				return;
			}
			_currentState = value;
			this.invalidate(INVALIDATION_FLAG_STATE);
		}

		public function get mouseState():String
		{
			return _mouseState;
		}

		public function set mouseState(value:String):void
		{
			if(_mouseState == value )
			{
				return;
			}
			_mouseState = value;
			this.invalidate(INVALIDATION_FLAG_STATE);
		}
		/**
		 * Constuctor
		 */
		public function EditableSlider()
		{
			this.addEventListener(TouchEvent.TOUCH, component_touchHandler);
			this.addEventListener(Event.ADDED_TO_STAGE, component_addedToStageHandler)
			
			
			if(!this.step)
			{
				this.step = 1;
			}
		}

		override protected function initialize():void
		{
			super.initialize();
			this.buttonLayoutMode = StepperButtonLayoutMode.SPLIT_HORIZONTAL;
			this.addEventListener(TouchEvent.TOUCH, component_touchHandler);
			
			
		}

		override protected function layoutChildren():void
		{
			super.layoutChildren();
			if(this.buttonLayoutMode == StepperButtonLayoutMode.SPLIT_HORIZONTAL)
			{
				this.decrementButton.x = 0;
				this.decrementButton.y = 0;
				this.decrementButton.height = this.actualHeight;
				this.decrementButton.validate();

				this.incrementButton.y = 0;
				this.incrementButton.height = this.actualHeight;
				this.incrementButton.validate();
				this.incrementButton.x = this.actualWidth - this.incrementButton.width;

				this.textInput.x = this.decrementButton.width + this._textInputGap;
				this.textInput.width = this.actualWidth - this.decrementButton.width - this.incrementButton.width - 2 * this._textInputGap;
				this.textInput.height = this.actualHeight;

				if(this.mouseState == MOUSE_STATE_OUT || this.currentState == STATE_EDIT )
				{
					hideButtons();
					this.textInput.x = this.decrementButton.x;
					this.textInput.width = this.actualWidth;
				}
				else
				{
					showButtons();
					this.textInput.x = this.decrementButton.width + this._textInputGap;
					this.textInput.width = this.actualWidth - this.decrementButton.width - this.incrementButton.width - 2 * this._textInputGap;
				}
			}
		}

		override protected function draw():void
		{
			super.draw();
			var stateInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STATE);

			if(stateInvalid)
			{
				if(currentState == STATE_EDIT)
				{
					this.textInput.isEditable = true;
					this.textInput.isSelectable = true;
					this.textInput.setFocus();
				} else {
					this.textInput.isEditable = false;
					this.textInput.isSelectable = false;
					this.textInput.clearFocus();
				}
				this.layoutChildren();
			}
		}

		/**
		 * Is in charge of hiding buttons.
		 */
		private function hideButtons():void
		{
			if(this.incrementButton.visible)
			{
				this.incrementButton.visible = false;
			}
			if(this.decrementButton.visible)
			{
				this.decrementButton.visible = false;
			}
		}

		/**
		 * Is in charge of showing buttons.
		 */
		private function showButtons():void
		{
			if(!this.incrementButton.visible)
			{
				this.incrementButton.visible = true;
			}
			if(!this.decrementButton.visible)
			{
				this.decrementButton.visible = true;
			}
		}

		private function sliderMove(touch:Touch, speed:Number):void
		{
			if(touch && _slideEnable)
			{
				try {
					this.value += (touch.globalX - touch.previousGlobalX)*speed*this.step;
				}
				catch(e:Error)
				{
					trace(e.getStackTrace());
				}
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/*
		 * Event handlers
		 */
		private function component_touchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);

			if (this.mouseState == MOUSE_STATE_IN)
			{
				if(touch.isTouching(this.textInput))
				{
					if(touch.phase == TouchPhase.MOVED)
					{
						this.currentState = STATE_SLIDE;
						sliderMove(touch, 0.5);
					}
					if(touch.phase == TouchPhase.ENDED)
					{
						if(this.currentState != STATE_SLIDE)
						{
							this.currentState = STATE_EDIT;
							_slideEnable = false;
						}
						else
						{
							this.currentState = STATE_NONE;
							this.invalidate(INVALIDATION_FLAG_DATA);
							_slideEnable = true;
						}
					}
				}
			}
		}

		private function component_addedToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, component_addedToStageHandler);
			this.stage.addEventListener(TouchEvent.TOUCH, stage_touchHandler);
		}

		private function stage_touchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				if(touch.isTouching(this))
				{
					this.mouseState = MOUSE_STATE_IN;
				}
				else if (touch.isTouching(stage))
				{
					this.mouseState = MOUSE_STATE_OUT;
				}

				if(this.mouseState == MOUSE_STATE_OUT)
				{
					if (this.currentState == STATE_EDIT)
					{
						if(touch.phase == TouchPhase.ENDED)
						{
							this.currentState = STATE_NONE;
						}
					}
				}
			}
		}
	}
}