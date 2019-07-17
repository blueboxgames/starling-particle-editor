package com.grantech.models
{
	import starling.extensions.ColorArgb;
	import starling.utils.deg2rad;
	import flash.net.FileReference;
	import flash.filesystem.File;

	public class ParticleDataModel extends LayerDataModel
	{
		public function ParticleDataModel()
		{
			super();
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
			this.lifespan = 1.1;
			this.lifespanVariance = 0.4;
			this.startSize = 111;
			this.startSizeVariance = 10;
			this.endSize = 40;
			this.endSizeVariance = 0;
			this.emitAngle = -146;
			this.emitAngleVariance = 50;
			this.startRotation = 720;
			this.startRotationVariance = 0;
			this.endRotation = 0;
			this.endRotationVariance = 0;
			this.speed = 244;
			this.speedVariance = 5;
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
			this.startColor = new ColorArgb(0.4,0,0,1);
			this.startColorVariance = new ColorArgb(0,0,0,1);
			this.finishColor = new ColorArgb(0,0,0,1);
			this.finishColorVariance = new ColorArgb(0,0,0,1);
			this.blendFactorSource = 1;
			this.blendFactorDestination = 1;
			this.maxParticles = 300;
			this.texture = File.applicationDirectory.resolvePath("/media/default.png").nativePath;
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

		public function get sourcePositionVariancex():Number
		{
			return this.getProperty("emitterXVariance");
		}

		public function set emitterXVariance(value:Number):void
		{
			this.setProperty("emitterXVariance", value);
		}

		public function get emitterYVariance():Number
		{
			return this.getProperty("emitterYVariance");
		}

		public function get sourcePositionVariancey():Number
		{
			return this.getProperty("emitterYVariance");
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

		public function get particleLifespan():Number
		{
			return this.getProperty("lifespan");
		}

		public function set lifespan(value:Number):void
		{
			this.setProperty("lifespan", value);
		}

		public function get particleLifespanVariance():Number
		{
			return this.getProperty("lifespanVariance");
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

		public function get startColorRed():Number
		{
			return this.startColor.red;
		}

		public function set startColorRed(value:Number):void
		{
			this.startColor.red = value;
			this.setProperty("startColor", value);
		}

		public function get startColorGreen():Number
		{
			return this.startColor.green;
		}

		public function set startColorGreen(value:Number):void
		{
			this.startColor.green = value;
			this.setProperty("startColor", value);
		}

		public function get startColorBlue():Number
		{
			return this.startColor.blue;
		}

		public function set startColorBlue(value:Number):void
		{
			this.startColor.blue = value;
			this.setProperty("startColor", value);
		}

		public function get startColorAlpha():Number
		{
			return this.startColor.alpha;
		}

		public function set startColorAlpha(value:Number):void
		{
			this.startColor.alpha = value;
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

		public function get startColorVarianceRed():Number
		{
			return this.startColorVariance.red;
		}

		public function set startColorVarianceRed(value:Number):void
		{
			this.startColorVariance.red = value;
			this.setProperty("startColorVariance", this.startColorVariance);
		}

		public function get startColorVarianceGreen():Number
		{
			return this.startColorVariance.green;
		}

		public function set startColorVarianceGreen(value:Number):void
		{
			this.startColorVariance.green = value;
			this.setProperty("startColorVariance", this.startColorVariance);
		}

		public function get startColorVarianceBlue():Number
		{
			return this.getProperty("startColorVarianceBlue");
		}

		public function set startColorVarianceBlue(value:Number):void
		{
			this.startColorVariance.blue = value;
			this.setProperty("startColorVariance", value);
		}

		public function get startColorVarianceAlpha():Number
		{
			return this.startColor.alpha;
		}

		public function set startColorVarianceAlpha(value:Number):void
		{
			this.startColor.alpha = value;
			this.setProperty("startColorVariance", value);
		}

		public function get finishColor():ColorArgb
		{
			return this.getProperty("finishColor");
		}

		public function set finishColor(value:ColorArgb):void
		{
			this.setProperty("finishColor", value);
		}

		public function get finishColorRed():Number
		{
			return this.finishColor.red;
		}

		public function set finishColorRed(value:Number):void
		{
			this.finishColor.red = value;
			this.setProperty("finishColor", value);
		}

		public function get finishColorGreen():Number
		{
			return this.finishColor.green;
		}

		public function set finishColorGreen(value:Number):void
		{
			this.finishColor.green = value;
			this.setProperty("finishColor", value);
		}

		public function get finishColorBlue():Number
		{
			return this.finishColor.blue;
		}

		public function set finishColorBlue(value:Number):void
		{
			this.finishColor.blue = value;
			this.setProperty("finishColor", value);
		}

		public function get finishColorAlpha():Number
		{
			return this.finishColor.alpha;
		}

		public function set finishColorAlpha(value:Number):void
		{
			this.finishColor.alpha = value;
			this.setProperty("finishColor", value);
		}

		public function get finishColorVariance():ColorArgb
		{
			return this.getProperty("finishColorVariance");
		}

		public function set finishColorVariance(value:ColorArgb):void
		{
			this.setProperty("finishColorVariance", value);
		}

		public function get finishColorVarianceRed():Number
		{
			return this.finishColorVariance.red;
		}

		public function set finishColorVarianceRed(value:Number):void
		{
			this.finishColorVariance.red = value;
			this.setProperty("finishColorVariance", value);
		}

		public function get finishColorVarianceGreen():Number
		{
			return this.finishColorVariance.green;
		}

		public function set finishColorVarianceGreen(value:Number):void
		{
			this.finishColorVariance.green = value;
			this.setProperty("finishColorVariance", value);
		}

		public function get finishColorVarianceBlue():Number
		{
			return this.finishColorVariance.blue;
		}

		public function set finishColorVarianceBlue(value:Number):void
		{
			this.finishColorVariance.blue = value;
			this.setProperty("finishColorVariance", value);
		}

		public function get finishColorVarianceAlpha():Number
		{
			return this.finishColorVariance.alpha;
		}

		public function set finishColorVarianceAlpha(value:Number):void
		{
			this.finishColorVariance.alpha = value;
			this.setProperty("finishColorVariance", value);
		}

		public function get blendFactorSource():int
		{
			return this.getProperty("blendFactorSource");
		}

		public function set blendFactorSource(value:int):void
		{
			this.setProperty("blendFactorSource", value);
		}

		public function get blendFactorDestination():int
		{
			return this.getProperty("blendFactorDestination");
		}

		public function set blendFactorDestination(value:int):void
		{
			this.setProperty("blendFactorDestination", value);
		}

		public function get maxParticles():Number
		{
			return this.getProperty("maxParticles");
		}

		public function set maxParticles(value:Number):void
		{
			this.setProperty("maxParticles", value);
		}

		public function get texture():String
		{
			return this.getProperty("texture");
		}

		public function set texture(value:String):void
		{
			this.setProperty("texture", value);
		}

		public function parseDataFromFile(value:File):void
		{
			var extension:String = value.extension;
			extension.toLowerCase() == "xml" ? parseConfig(value.data.readUTFBytes(value.data.length) as XML) : parseJsonConfig(value.data.readUTFBytes(value.data.length));
		}

		private function parseConfig(xconfig:String):void
		{
			var config:XML = XML ( xconfig );
			this.emitterXVariance = parseFloat(config.sourcePositionVariance.attribute("x"));
			this.emitterYVariance = parseFloat(config.sourcePositionVariance.attribute("y"));
			this.gravityX =  parseFloat(config.gravity.attribute("x"));
			this.gravityY =  parseFloat(config.gravity.attribute("y"));
			this.emitterType =  getIntValue(config.emitterType);
			this.lifespan =  Math.max(0.01, getFloatValue(config.particleLifeSpan));
			this.lifespanVariance =  getFloatValue(config.particleLifespanVariance);
			this.startSize =  getFloatValue(config.startParticleSize);
			this.startSizeVariance =  getFloatValue(config.startParticleSizeVariance);
			this.endSize =  getFloatValue(config.finishParticleSize);
			this.endSizeVariance =  getFloatValue(config.FinishParticleSizeVariance);
			this.emitAngle =  deg2rad(getFloatValue(config.angle));
			this.emitAngleVariance =  deg2rad(getFloatValue(config.angleVariance));
			this.startRotation =  deg2rad(getFloatValue(config.rotationStart));
			this.startRotationVariance =  deg2rad(getFloatValue(config.rotationStartVariance));
			this.endRotation =  deg2rad(getFloatValue(config.rotationEnd));
			this.endRotationVariance =  deg2rad(getFloatValue(config.rotationEndVariance));
			this.speed =  getFloatValue(config.speed);
			this.speedVariance =  getFloatValue(config.speedVariance);
			this.radialAcceleration =  getFloatValue(config.radialAcceleration);
			this.radialAccelerationVariance =  getFloatValue(config.radialAccelVariance);
			this.tangentialAcceleration =  getFloatValue(config.tangentialAcceleration);
			this.tangentialAccelerationVariance =  getFloatValue(config.tangentialAccelVariance);
			this.maxRadius =  getFloatValue(config.maxRadius);
			this.maxRadiusVariance =  getFloatValue(config.maxRadiusVariance);
			this.minRadius =  getFloatValue(config.minRadius);
			this.minRadiusVariance =  getFloatValue(config.minRadiusVariance);
			this.rotatePerSecond =  deg2rad(getFloatValue(config.rotatePerSecond));
			this.rotatePerSecondVariance =  deg2rad(getFloatValue(config.rotatePerSecondVariance));
			this.startColor =  getColor(config.startColor);
			this.startColorVariance =  getColor(config.startColorVariance);
			this.finishColor =  getColor(config.finishColor);
			this.finishColorVariance =  getColor(config.finishColorVariance);
			this.blendFactorSource = getIntValue(config.blendFactorSource);
			this.blendFactorDestination = getIntValue(config.blendFactorDestination);
			this.duration = getFloatValue(config.duration);
			this.maxParticles = getIntValue(config.maxParticles);

			this.lifespan =  Math.max(0.01, getFloatValue(config.particleLifespan));
			this.lifespanVariance = getFloatValue(config.particleLifeSpanVariance);
			this.endSizeVariance = getFloatValue(config.finishParticleSizeVariance);
			this.minRadiusVariance = 0.0;

			function getIntValue(element:XMLList):int
			{
					return parseInt(element.attribute("value"));
			}
			
			function getFloatValue(element:XMLList):Number
			{
					return parseFloat(element.attribute("value"));
			}
			
			function getColor(element:XMLList):ColorArgb
			{
					var color:ColorArgb = new ColorArgb();
					color.red   = parseFloat(element.attribute("red"));
					color.green = parseFloat(element.attribute("green"));
					color.blue  = parseFloat(element.attribute("blue"));
					color.alpha = parseFloat(element.attribute("alpha"));
					return color;
			}
		}
		private function parseJsonConfig(xconfig:String):void 
		{
			var config:Object = JSON.parse(xconfig)
			this.emitterXVariance = config.sourcePositionVariancex;
			this.emitterYVariance = config.sourcePositionVariancey;
			this.gravityX =config.gravityX;
			this.gravityY =config.gravityY;
			this.emitterType =config.emitterType;
			this.lifespan =Math.max(0.01, config.particleLifespan);
			this.lifespanVariance =config.particleLifespanVariance;
			this.startSize =config.startSize;
			this.startSizeVariance =config.startSizeVariance;
			this.endSize =config.endSize;
			this.endSizeVariance =config.endSizeVariance;
			this.emitAngle =deg2rad(config.emitAngle);
			this.emitAngleVariance =deg2rad(config.emitAngleVariance);
			this.startRotation =deg2rad(config.startRotation);
			this.startRotationVariance =deg2rad(config.startRotationVariance);
			this.endRotation =deg2rad(config.endRotation);
			this.endRotationVariance =deg2rad(config.endRotationVariance);
			this.speed =config.speed;
			this.speedVariance =config.speedVariance;
			this.radialAcceleration =config.radialAcceleration;
			this.radialAccelerationVariance =config.radialAccelerationVariance;
			this.tangentialAcceleration =config.tangentialAcceleration;
			this.tangentialAccelerationVariance =config.tangentialAccelerationVariance;
			this.maxRadius =config.maxRadius;
			this.maxRadiusVariance =config.maxRadiusVariance;
			this.minRadius =config.minRadius;
			this.minRadiusVariance =config.minRadiusVariance;
			this.rotatePerSecond =deg2rad(config.rotatePerSecond);
			this.rotatePerSecondVariance =deg2rad(config.rotatePerSecondVariance);
			this.startColor =new ColorArgb(config.startColorRed, config.startColorGreen, config.startColorBlue, config.startColorAlpha);
			this.startColorVariance =new ColorArgb(config.startColorVarianceRed, config.startColorVarianceGreen, config.startColorVarianceBlue, config.startColorVarianceAlpha);
			this.finishColor =new ColorArgb(config.finishColorRed, config.finishColorGreen, config.finishColorBlue, config.finishColorAlpha);
			this.finishColorVariance =new ColorArgb(config.finishColorVarianceRed, config.finishColorVarianceGreen, config.finishColorVarianceBlue, config.finishColorVarianceAlpha);
			this.blendFactorSource = config.blendFactorSource;
			this.blendFactorDestination = config.blendFactorDestination;
			this.duration = config.duration;
			this.maxParticles = config.maxParticles;
			this.lifespan =  Math.max(0.01, config.particleLifespan);
			this.lifespanVariance = config.particleLifeSpanVariance;
			this.endSizeVariance = config.finishParticleSizeVariance;
			this.minRadiusVariance = 0.0;
		}
	}
}