package feathers.controls
{
	import feathers.core.FeathersControl;
	import feathers.core.IFeathersControl;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.ColorArgb;
	import starling.textures.Texture;

	public class AbstractColorPicker extends FeathersControl implements IFeathersControl
	{
		[Embed(source="/media/palette.png")]
		public static var PaletteBitmap:Class;

		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;

		private var colorPalette:Image;
		//private var alphaSlider:Slider;
		//public var colorIndicator:Quad;

		private var _red:int;
		
		public function get r():int
		{
			return _red;
		}
		
		public function set r(value:int):void
		{
			_red = value;
		}

		private var _green:int;
		
		public function get g():int
		{
			return _green;
		}
		
		public function set g(value:int):void
		{
			_green = value;
		}

		private var _blue:int;
		
		public function get b():int
		{
			return _blue;
		}
		
		public function set b(value:int):void
		{
			_blue = value;
		}

		private var _alpha:Number;
		
		public function get a():Number
		{
			return _alpha;
		}
		
		public function set a(value:Number):void
		{
			_alpha = value;
			//if(alphaSlider)
			// 	this.alphaSlider.value = value;
		}

		private var _data:ColorArgb;
		
		public function get data():ColorArgb
		{
			return _data;
		}
		
		public function set data(value:ColorArgb):void
		{
			_data = value;
		}

		private var _gap:Number = 1;
		
		public function get gap():Number
		{
			return _gap;
		}
		
		public function set gap(value:Number):void
		{
			_gap = value;
		}

		private var _padding:Number;
		
		public function get padding():Number
		{
			return _padding;
		}
		
		public function set padding(value:Number):void
		{
			_padding = value;
		}


		public function AbstractColorPicker()
		{
			super();

			this.r = 0x00;
			this.g = 0x00;
			this.b = 0x00;
			this.a = 0xff;
		}

		override protected function initialize():void
		{
			super.initialize();
			this.bitmap = new PaletteBitmap();
			this.bitmapData = this.bitmap.bitmapData;
			this.colorPalette = new Image(Texture.fromBitmap(bitmap));
			this.colorPalette.addEventListener(TouchEvent.TOUCH, palette_touchHandler);
			this.x = this.x;
			this.y = this.y;
			this.addChild(colorPalette);

			/* this.alphaSlider = new Slider();
			this.alphaSlider.minimum = 0;
			this.alphaSlider.maximum = 255;
			this.alphaSlider.value = this.a;
			this.alphaSlider.y = colorPalette.height + this.gap;
			this.alphaSlider.width = colorPalette.width - 20;
			this.alphaSlider.maximumTrackFactory = function():Button
			{
				var track:Button = new Button();
				track.height = 20;
				return track;
			};
			this.alphaSlider.minimumTrackFactory = function():Button
			{
				var track:Button = new Button();
				track.height = 20;
				return track;
			};
			this.alphaSlider.thumbFactory = function():Button
			{
				var button:Button = new Button();
				button.height = 20;
				button.width = 20;
				return button;
			};
			this.alphaSlider.addEventListener(Event.CHANGE, alphaSlider_changeHandler);
			
			this.addChild(alphaSlider); */

			/* this.colorIndicator = new Quad(20,20, toArgb());
			this.colorIndicator.x = colorPalette.width - this.colorIndicator.width;
			this.colorIndicator.y = colorPalette.height + this.gap;

			this.addChild(this.colorIndicator); */
		}

		public function toArgb():uint
		{
			var colorARGB:ColorArgb = new ColorArgb();
			colorARGB.red = this.r as Number;
			colorARGB.green = this.g as Number;
			colorARGB.blue = this.b as Number;
			colorARGB.alpha = this.a as Number;

			return colorARGB.toArgb();
		}

		/* protected function alphaSlider_changeHandler(e:Event):void
		{
			this.a = this.alphaSlider.value;
			this.colorIndicator.alpha = this.a/255;
			this.dispatchEventWith(Event.CHANGE, false, {red: this.r, green: this.g, blue: this.b, alpha:this.a });
		} */

		protected function palette_touchHandler(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(stage);
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				var m_TouchEndedPoint:Point = new Point(touch.globalX, touch.globalY);
				if (touch.phase == TouchPhase.BEGAN)
				{
					touch.getLocation(this.colorPalette, m_TouchEndedPoint);
					// this.colorIndicator.color = this.bitmapData.getPixel(m_TouchEndedPoint.x, m_TouchEndedPoint.y);
				}

				if (touch.phase == TouchPhase.MOVED){
					if (stage.hitTest(m_TouchEndedPoint) == touch.target)
					{
						touch.getLocation(this.colorPalette, m_TouchEndedPoint);
						// this.colorIndicator.color = this.bitmapData.getPixel(m_TouchEndedPoint.x, m_TouchEndedPoint.y);
					}
				}

				if (touch.phase == TouchPhase.ENDED){
					if (stage.hitTest(m_TouchEndedPoint) == touch.target)
					{
						touch.getLocation(this.colorPalette, m_TouchEndedPoint);
						var currentColor:uint = this.bitmapData.getPixel(m_TouchEndedPoint.x, m_TouchEndedPoint.y)
						// this.colorIndicator.color = currentColor;
						var newColor:ColorArgb = ColorArgb.fromArgb(currentColor);
						this.r = newColor.red * 255;
						this.g = newColor.green * 255;
						this.b = newColor.blue * 255;
						this.dispatchEventWith(Event.CHANGE, false, {red: this.r, green: this.g, blue: this.b, alpha:this.a });
					}
				}
			}
		}

		override public function dispose():void
		{
			this.colorPalette.removeEventListener(TouchEvent.TOUCH, palette_touchHandler);
			// this.alphaSlider.removeEventListener(Event.CHANGE, alphaSlider_changeHandler);
			super.dispose();
		}
	}
}