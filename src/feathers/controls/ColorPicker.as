package feathers.controls
{
	import flash.geom.Point;

	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.extensions.ColorArgb;

	public class ColorPicker extends LayoutGroup
	{
		private var colorLabel:Label;
		private var colorIndicator:Button;

		private var _red:int;
		
		public function get red():int
		{
			return _red;
		}
		
		public function set red(value:int):void
		{
			_red = value;
		}

		private var _green:int;
		
		public function get green():int
		{
			return _green;
		}
		
		public function set green(value:int):void
		{
			_green = value;
		}

		private var _blue:Object;
		
		public function get blue():Object
		{
			return _blue;
		}
		
		public function set blue(value:Object):void
		{
			_blue = value;
		}

		private var _a:Number;
		
		public function get a():Number
		{
			return _a;
		}
		
		public function set a(value:Number):void
		{
			_a = value;
		}

		public static const INVALIDATION_FLAG_COLOR_PICKER_ELEMENT_FACTORY:String = "colorPickerElementFactory";

		protected var colorPickerElement:AbstractColorPicker;

		protected static function defaultColorPickerElementFactory():AbstractColorPicker
		{
			return new AbstractColorPicker();
		}
		
		private var _colorPickerElementFactory:Function;
		
		public function get colorPickerElementFactory():Function
		{
			return this._colorPickerElementFactory;
		}
		
		public function set colorPickerElementFactory(value:Function):void
		{
			if(this._colorPickerElementFactory == value)
			{
				return;
			}

			this._colorPickerElementFactory = value;
			this.invalidate(INVALIDATION_FLAG_COLOR_PICKER_ELEMENT_FACTORY);
		}

		private var _gap:Number = 0;
		
		public function get gap():Number
		{
			return _gap;
		}
		
		public function set gap(value:Number):void
		{
			_gap = value;
		}

		public var data:ColorArgb;

		public function ColorPicker()
		{
			super();
			this.data = new ColorArgb();
		}

		override protected function initialize():void
		{
			super.initialize();

			this.colorIndicator = new Button();
			this.colorIndicator.width = 20
			this.colorIndicator.height = 20;
			this.colorIndicator.addEventListener(Event.TRIGGERED, colorIndicator_triggeredHandler);
			this.addChild(this.colorIndicator);
			
			this.colorLabel = new Label();
			this.colorLabel.x = 20 + this.gap;
			this.colorLabel.text = this.data.toString();
			this.addChild(this.colorLabel);
		}

		protected function createColorPickerElement():void
		{
			if(this.colorPickerElement !== null)
			{
				this.colorPickerElement.removeEventListener(Event.CHANGE, colorPickerElement_changeHandler);
				this.colorPickerElement.dispose();
				this.colorPickerElement = null;
			}

			var factory:Function = this._colorPickerElementFactory != null ? this._colorPickerElementFactory : defaultColorPickerElementFactory;
			this.colorPickerElement = AbstractColorPicker(factory());
			this.colorPickerElement.addEventListener(Event.CHANGE, colorPickerElement_changeHandler);
			this.colorPickerElement.y = this.colorIndicator.y + this.colorIndicator.height;
			this.colorPickerElement.scaleX = 0.7;
			this.colorPickerElement.scaleY = 0.7;
			this.colorPickerElement.visible = false;
			// this.colorPickerElement.initializeNow();
			// this.colorPickerElement.validate();
			this.stage.addChild(this.colorPickerElement as DisplayObject);
		}

		protected function colorPickerElement_changeHandler(e:Event):void
		{
			this.data.red =  this.colorPickerElement.r / 255;
			this.data.green = this.colorPickerElement.g / 255;
			this.data.blue = this.colorPickerElement.b / 255;
			this.data.alpha = this.colorPickerElement.a / 255;
			this.colorIndicator.defaultSkin = new Quad(1,1, this.data.toArgb());
			this.colorLabel.text = this.data.toString();
			this.dispatchEventWith(Event.CHANGE);
		}

		protected function colorIndicator_triggeredHandler(e:Event):void
		{
			this.stage.addEventListener(TouchEvent.TOUCH, indicator_touchHandler);
		}

		protected function indicator_touchHandler(e:TouchEvent):void
		{
			
			var touch:Touch = e.getTouch(this.stage);
			if(touch)
			{
				if( touch.phase == "ended" && touch.target == this.colorIndicator )
				{
					this.colorPickerElement.visible = !this.colorPickerElement.visible;
					var point:Point = getCurrentPos(touch);
					this.colorPickerElement.x = point.x - 260*this.colorPickerElement.scale;
					this.colorPickerElement.y = point.y + this.colorIndicator.height;
				}
				if(touch.phase == "ended")
				{
					if(touch.target != this.colorIndicator)
					{
						this.colorPickerElement.visible = false;
						this.stage.removeEventListener(TouchEvent.TOUCH, indicator_touchHandler);
						return;
					}
				}			
			}	
		}

		protected function getCurrentPos(touch:Touch):Point
		{
			var point:Point = new Point;
			point.x = touch.globalX;
			point.y = touch.globalY;
			return point;
		} 

		override protected function draw():void
		{
			var colorPickerElementInvalid:Boolean = isInvalid(INVALIDATION_FLAG_COLOR_PICKER_ELEMENT_FACTORY);
			if(colorPickerElementInvalid)
			{
				createColorPickerElement();
			}

			super.draw();
		}

		override public function dispose():void
		{
			this.colorIndicator.removeEventListener(Event.TRIGGERED, colorIndicator_triggeredHandler);
			this.colorPickerElement.removeEventListener(Event.CHANGE, colorPickerElement_changeHandler);
			super.dispose();
		}
	}
}