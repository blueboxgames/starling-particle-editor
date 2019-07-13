package com.grantech.models
{
	public class ControlsHelper
	{
		static public const TYPE_SLIDER:int = 0;
		static public const TYPE_COLOR_PICKER:int = 1;
		static public const TYPE_DROPDOWN:int = 2;
		public function ControlsHelper()
		{
			super();
		}
		private static var _instance:ControlsHelper;

		/**
		 * ControlsHelper singleton access method.
		 */
		public static function get instance() : ControlsHelper
		{
			if( _instance == null )
				_instance = new ControlsHelper();
				return _instance;
		}

		private var propertyList:Object = {
			"emitterType": {
				min: 0,
				max: 1,
				step: 1
			},
			
			"defaultDuration": {
				min: -1,
				max: 10000,
				step: 1
			},

			"emitterXVariance": {
				min: -10000,
				max: 10000,
				step: 1
			},

			"emitterYVariance": {
				min: -10000,
				max: 10000,
				step: 1
			},
			
			"gravityX": {
				min: -10000,
				max: 10000,
				step: 1
			},
			
			"gravityY": {
				min: -10000,
				max: 10000,
				step: 1
			},

			"lifespan": {
				min: 0,
				max: 10000,
				step: 0.1
			},

			"lifespanVariance": {
				min: 0,
				max: 10000,
				step: 0.1
			},
			
			"startSize": {
				min: 0,
				max: 10000,
				step: 1
			},

			"startSizeVariance": {
				min: 0,
				max: 10000,
				step: 1
			},

			"endSize": {
				min: 0,
				max: 10000,
				step: 1
			},

			"endSizeVariance": {
				min: 0,
				max: 10000,
				step: 1
			},

			"emitAngle": {
				min: 0,
				max: 180,
				step: 1
			},

			"emitAngleVariance": {
				min: 0,
				max: 180,
				step: 1
			},

			"startRotation": {
				min: -10000,
				max: 10000,
				step: 1
			},

			"startRotationVariance": {
				min: -10000,
				max: 10000,
				step: 1
			},

			"endRotation": {
				min: -10000,
				max: 10000,
				step: 1
			},

			"endRotationVariance": {
				min: -10000,
				max: 10000,
				step: 1
			},

			"speed": {
				min: 0,
				max: 10000,
				step: 1
			},

			"speedVariance": {
				min: 0,
				max: 10000,
				step: 1
			},

			"radialAcceleration": {
				min: -10000,
				max: 10000,
				step: 1
			},
			"radialAccelerationVariance": {
				min: 0,
				max: 10000,
				step: 1
			},

			"tangentialAcceleration": {
				min: -10000,
				max: 10000,
				step: 1
			},

			"tangentialAccelerationVariance": {
				min: 0,
				max: 10000,
				step: 1
			},

			"maxRadius": {
				min: 0,
				max: 10000,
				step: 1
			},
			
			"maxRadiusVariance": {
				min: 0,
				max: 10000,
				step: 1
			},
			
			"minRadius": {
				min: 0,
				max: 10000,
				step: 1
			},
			
			"minRadiusVariance": {
				min: 0,
				max: 10000,
				step: 1
			},
			
			"rotatePerSecond": {
				min: -360,
				max: 360,
				step: 1
			},
			
			"rotatePerSecondVariance": {
				min: 0,
				max: 360,
				step: 1
			},
			
			"startColorRed": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"startColorGreen": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"startColorBlue": {	
				min: 0,
				max: 255,
				step: 1
			},
			
			"startColorVarianceRed": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"startColorVarianceGreen": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"startColorVarianceBlue": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"endColorRed": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"endColorGreen": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"endColorBlue": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"endColorVarianceRed": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"endColorVarianceGreen": {
				min: 0,
				max: 255,
				step: 1
			},
			
			"endColorVarianceBlue": {
				min: 0,
				max: 255,
				step: 1
			}
		}

		public function getType(property:String):int
		{
			switch( property )
			{
				case "startColor":
				case "startColorVariance":
				case "finishColor":
				case "finishColorVariance":
					return TYPE_COLOR_PICKER
					break;
				case "blendFactorSource":
				case "blendFactorDestination":
					return TYPE_DROPDOWN
					break;
				default:
					return TYPE_SLIDER;
					break;
			}
		}
		public function getMin(property:String):Number
		{
			var value:Number = -10000;			
			value = this.propertyList[property] ? this.propertyList[property].min : NaN;
			return value;
		}

		public function getMax(property:String):Number
		{
			var value:Number = -10000;			
			value = this.propertyList[property] ? this.propertyList[property].max : NaN;
			return value;
		}

		public function getStep(property:String):Number
		{
			var value:Number = -10000;			
			value = this.propertyList[property] ? this.propertyList[property].step : NaN;
			return value;
		}
	}
}