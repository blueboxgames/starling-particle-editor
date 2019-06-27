package com.grantech.models
{
	import starling.extensions.ColorArgb;

	public class ParticleDataModel extends LayerDataModel
	{
		public function ParticleDataModel()
		{
			this.initialize();
		}

		/**
		 * This function will set default properties.
		 */
		protected function initialize():void
		{
			this.emitterType = 0;
			this.duration = -1;
			this.emitterXVariance = 0;
			this.emitterYVariance = 0;
			this.gravityX = 0;
			this.gravityY = 0;
			this.lifespan = 0;
			this.lifespanVariance = 0;
			this.startSize = 0;
			this.startSizeVariance = 0;
			this.endSize = 0;
			this.endSizeVariance = 0;
			this.emitAngle = 0;
			this.emitAngleVariance = 0;
			this.startRotation = 0;
			this.startRotationVariance = 0;
			this.endRotation = 0;
			this.endRotationVariance = 0;
			this.speed = 0;
			this.speedVariance = 0;
			this.radialAcceleration = 0;
			this.radialAccelerationVariance = 0;
			this.tangentialAcceleration = 0;
			this.tangentialAccelerationVariance = 0;
			// Radial Emitter
			this.maxRadius = 0;
			this.maxRadiusVariance = 0;
			this.minRadius = 0;
			this.minRadiusVariance = 0;
			this.rotatePerSecond = 0;
			this.rotatePerSecondVariance = 0;
			/**? Colors */
			this.startColor = new ColorArgb(0,0,0,0);
			this.startColorVariance = new ColorArgb(0,0,0,0);
			this.endColor = new ColorArgb(0,0,0,0);
			this.endColorVariance = new ColorArgb(0,0,0,0);
		}

		public function get emitterType():int
		{
			return this.getProperty("emitterType");
		}

		public function set emitterType(value:int):void
		{
			this.setProperty("emitterType", value);
		}

		public function get duration():Number
		{
			return this.getProperty("defaultDuration");
		}

		public function set duration(value:Number):void
		{
			this.setProperty("defaultDuration", value);
		}

		public function get emitterXVariance():Number
		{
			return this.getProperty("emitterXVariance");
		}

		public function set emitterXVariance(value:Number):void
		{
			this.setProperty("emitterXVariance", value);
		}

		public function set emitterYVariance(value:Number):void
		{
			this.setProperty("emitterYVariance", value);
		}

		
		// particle configuration
		public function get lifespan():Number
		{
			return this.getProperty("lifespan");
		}

		public function set lifespan(value:Number):void
		{
			this.setProperty("lifespan", value);
		}

		public function get lifespanVariance():Number
		{
			return this.getProperty("lifespanVariance");
		}

		public function set lifespanVariance(value:Number):void
		{
			this.setProperty("lifespanVariance", value);
		}

		public function get startSize():Number
		{
			return this.getProperty("startSize");
		}

		public function set startSize(value:Number):void
		{
			this.setProperty("startSize", value);
		}

		public function get startSizeVariance():Number
		{
			return this.getProperty("startSizeVariance");
		}

		public function set startSizeVariance(value:Number):void
		{
			this.setProperty("startSizeVariance", value);
		}

		public function get endSize():Number
		{
			return this.getProperty("endSize");
		}

		public function set endSize(value:Number):void
		{
			this.setProperty("endSize", value);
		}

		public function get endSizeVariance():Number
		{
			return this.getProperty("endSizeVariance");
		}

		public function set endSizeVariance(value:Number):void
		{
			this.setProperty("endSizeVariance", value);
		}

		public function get emitAngle():Number
		{
			return this.getProperty("emitAngle");
		}

		public function set emitAngle(value:Number):void
		{
			this.setProperty("emitAngle", value);
		}

		public function get emitAngleVariance():Number
		{
			return this.getProperty("emitAngleVariance");
		}

		public function set emitAngleVariance(value:Number):void
		{
			this.setProperty("emitAngleVariance", value);
		}

		public function get startRotation():Number
		{
			return this.getProperty("startRotation");
		}

		public function set startRotation(value:Number):void
		{
			this.setProperty("startRotation", value);
		}

		public function get startRotationVariance():Number
		{
			return this.getProperty("startRotationVariance");
		}

		public function set startRotationVariance(value:Number):void
		{
			this.setProperty("startRotationVariance", value);
		}

		public function get endRotation():Number
		{
			return this.getProperty("endRotation");
		}

		public function set endRotation(value:Number):void
		{
			this.setProperty("endRotation", value);
		}

		public function get endRotationVariance():Number
		{
			return this.getProperty("endRotationVariance");
		}

		public function set endRotationVariance(value:Number):void
		{
			this.setProperty("endRotationVariance", value);
		}

		
		// gravity configuration
		public function get speed():Number
		{
			return this.getProperty("speed");
		}

		public function set speed(value:Number):void
		{
			this.setProperty("speed", value);
		}

		public function get speedVariance():Number
		{
			return this.getProperty("speedVariance");
		}

		public function set speedVariance(value:Number):void
		{
			this.setProperty("speedVariance", value);
		}

		public function get gravityX():Number
		{
			return this.getProperty("gravityX");
		}

		public function set gravityX(value:Number):void
		{
			this.setProperty("gravityX", value);
		}

		public function get gravityY():Number
		{
			return this.getProperty("gravityY");
		}

		public function set gravityY(value:Number):void
		{
			this.setProperty("gravityY", value);
		}

		public function get radialAcceleration():Number
		{
			return this.getProperty("radialAcceleration");
		}

		public function set radialAcceleration(value:Number):void
		{
			this.setProperty("radialAcceleration", value);
		}

		public function get radialAccelerationVariance():Number
		{
			return this.getProperty("radialAccelerationVariance");
		}

		public function set radialAccelerationVariance(value:Number):void
		{
			this.setProperty("radialAccelerationVariance", value);
		}

		public function get tangentialAcceleration():Number
		{
			return this.getProperty("tangentialAcceleration");
		}

		public function set tangentialAcceleration(value:Number):void
		{
			this.setProperty("tangentialAcceleration", value);
		}

		public function get tangentialAccelerationVariance():Number
		{
			return this.getProperty("tangentialAccelerationVariance");
		}

		public function set tangentialAccelerationVariance(value:Number):void
		{
			this.setProperty("tangentialAccelerationVariance", value);
		}

		
		// radial configuration 
		public function get maxRadius():Number
		{
			return this.getProperty("maxRadius");
		}

		public function set maxRadius(value:Number):void
		{
			this.setProperty("maxRadius", value);
		}

		public function get maxRadiusVariance():Number
		{
			return this.getProperty("maxRadiusVariance");
		}

		public function set maxRadiusVariance(value:Number):void
		{
			this.setProperty("maxRadiusVariance", value);
		}

		public function get minRadius():Number
		{
			return this.getProperty("minRadius");
		}

		public function set minRadius(value:Number):void
		{
			this.setProperty("minRadius", value);
		}

		public function get minRadiusVariance():Number
		{
			return this.getProperty("minRadiusVariance");
		}

		public function set minRadiusVariance(value:Number):void
		{
			this.setProperty("minRadiusVariance", value);
		}

		public function get rotatePerSecond():Number
		{
			return this.getProperty("rotatePerSecond");
		}

		public function set rotatePerSecond(value:Number):void
		{
			this.setProperty("rotatePerSecond", value);
		}

		public function get rotatePerSecondVariance():Number
		{
			return this.getProperty("rotatePerSecondVariance");
		}

		public function set rotatePerSecondVariance(value:Number):void
		{
			this.setProperty("rotatePerSecondVariance", value);
		}

		
		// color configuration
		public function get startColor():ColorArgb
		{
			return this.getProperty("startColor");
		}

		public function set startColor(value:ColorArgb):void
		{
			this.setProperty("startColor", value);
		}

		public function get startColorVariance():ColorArgb
		{
			return this.getProperty("startColorVariance");
		}

		public function set startColorVariance(value:ColorArgb):void
		{
			this.setProperty("startColorVariance", value);
		}

		public function get endColor():ColorArgb
		{
			return this.getProperty("endColor");
		}

		public function set endColor(value:ColorArgb):void
		{
			this.setProperty("endColor", value);
		}

		public function get endColorVariance():ColorArgb
		{
			return this.getProperty("endColorVariance");
		}

		public function set endColorVariance(value:ColorArgb):void
		{
			this.setProperty("endColorVariance", value);
		}



	}
}