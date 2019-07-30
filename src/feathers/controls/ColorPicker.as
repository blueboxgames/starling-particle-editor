package feathers.controls
{
	import com.grantech.utils.Utils;

	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalAlign;

	import flash.geom.Point;

	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.extensions.ColorArgb;

	public class ColorPicker extends LayoutGroup
	{
		private var colorNumber:TextInput;
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
			var hLayout:HorizontalLayout = new HorizontalLayout();
			hLayout.verticalAlign = VerticalAlign.MIDDLE;
			this.layout = hLayout;

			this.colorIndicator = new Button();
			this.colorIndicator.layoutData = new HorizontalLayoutData(NaN, NaN);
			this.colorIndicator.width = 20
			this.colorIndicator.height = 20;
			this.colorIndicator.defaultIcon = new Quad(15,15, this.data.toArgb());
			this.colorIndicator.addEventListener(Event.TRIGGERED, colorIndicator_triggeredHandler);
			this.addChild(this.colorIndicator);
			
			this.colorNumber = new TextInput();
			this.colorNumber.addEventListener(FeathersEventType.ENTER, colorNumber_enterHandler);
			this.colorNumber.layoutData = new HorizontalLayoutData(100, NaN);

			this.colorNumber.text = Utils.colorToHEX(this.data.red, this.data.green, this.data.blue, this.data.alpha);
			this.addChild(this.colorNumber);
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
			this.stage.addChild(this.colorPickerElement as DisplayObject);
		}

		protected function colorPickerElement_changeHandler(e:Event):void
		{
			this.data.red =  this.colorPickerElement.r / 255;
			this.data.green = this.colorPickerElement.g / 255;
			this.data.blue = this.colorPickerElement.b / 255;
			this.data.alpha = this.colorPickerElement.a / 255;
			this.colorIndicator.defaultIcon = new Quad(15,15, this.data.toArgb());
			this.colorNumber.text = Utils.colorToHEX(this.data.red, this.data.green, this.data.blue, this.data.alpha);
			this.dispatchEventWith(Event.CHANGE);
		}

		protected function colorNumber_enterHandler(e:Event):void
		{
			if(isValidHex(this.colorNumber.text))
			{
				this.data = rgbHexToARGB(this.colorNumber.text);
			} 
			else if(isValidHexA(this.colorNumber.text))
			{
				this.data = argbHexToARGB(this.colorNumber.text);
			}
			this.colorPickerElement.r = this.data.red;
			this.colorPickerElement.g = this.data.green;
			this.colorPickerElement.b = this.data.blue;
			this.colorPickerElement.a = this.data.alpha * 255;
			// this.colorPickerElement.colorIndicator.color =this.data.toArgb();
			this.colorIndicator.defaultIcon = new Quad(15,15, this.data.toArgb());
			this.colorNumber.text = Utils.colorToHEX(this.data.red, this.data.green, this.data.blue, this.data.alpha);
			this.dispatchEventWith(Event.CHANGE);
		}

		private function rgbHexToARGB(text:String):ColorArgb
		{
			var color:ColorArgb = new ColorArgb();
			if (text.length == 4)
			{
				color.red = ( parseInt(text.slice(1,2), 16) + 16 * parseInt(text.slice(1,2), 16) ) / 255;
				color.green = ( parseInt(text.slice(2,3), 16) + 16 * parseInt(text.slice(2,3), 16) ) / 255;
				color.blue = ( parseInt(text.slice(3,4), 16) + 16 * parseInt(text.slice(3,4), 16) ) / 255;
			}
			else if (text.length == 7)
			{
				color.red = parseInt(text.slice(1,3), 16) / 255;
				color.green = parseInt(text.slice(3,5), 16) / 255;
				color.blue = parseInt(text.slice(5,7), 16) / 255;
			}
			color.alpha = 1;
			this.data = color;
			
			return color;
		}

		private function argbHexToARGB(text:String):ColorArgb
		{
			var color:ColorArgb = new ColorArgb();
			if (text.length == 5)
			{
				color.red = ( parseInt(text.slice(1,2), 16) + 16 * parseInt(text.slice(1,2), 16) ) / 255;
				color.green = ( parseInt(text.slice(2,3), 16) + 16 * parseInt(text.slice(2,3), 16) ) / 255;
				color.blue = ( parseInt(text.slice(3,4), 16) + 16 * parseInt(text.slice(3,4), 16) ) / 255;
				color.alpha = ( parseInt(text.slice(4,5), 16) + 16 * parseInt(text.slice(4,5), 16) ) / 255;
			}
			else if (text.length == 9)
			{
				color.red = parseInt(text.slice(1,3), 16) / 255;
				color.green = parseInt(text.slice(3,5), 16) / 255;
				color.blue = parseInt(text.slice(5,7), 16) / 255;
				color.alpha = parseInt(text.slice(7,9), 16) / 255;
			}
			return color;
		}

		private function isValidHex(text:String):Boolean
		{
			var isOk:Boolean = false;
			if( text.search('^#(?:[0-9a-fA-F]{3}){1,2}$') == 0 )
			{
				isOk = true;
			}
			return isOk;
		}

		private function isValidHexA(text:String):Boolean
		{
			var isOk:Boolean = false;
			if( text.search('^#(?:[0-9a-fA-F]{4}){1,2}$') == 0 )
			{
				isOk = true;
			}
			return isOk;
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
			this.colorNumber.removeEventListener(FeathersEventType.ENTER, colorNumber_enterHandler);
			super.dispose();
		}
	}
}