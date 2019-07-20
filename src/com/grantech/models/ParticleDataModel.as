package com.grantech.models
{
	import flash.display3D.Context3DBlendFactor;
	import flash.filesystem.File;

	import starling.extensions.ColorArgb;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;

	public class ParticleDataModel extends LayerDataModel
	{
		private var _texture:String;
		
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
			this.duration = -1.00;
			this.sourcePositionVariancex = 0;
			this.sourcePositionVariancey = 0;
			this.gravityx = 0;
			this.gravityy = 0;
			this.particleLifespan = 1.1;
			this.particleLifespanVariance = 0.4;
			this.startParticleSize = 111;
			this.startParticleSizeVariance = 10;
			this.finishParticleSize = 40;
			this.finishParticleSizeVariance = 0;
			this.angle = -146;
			this.angleVariance = 50;
			this.rotationStart = 720;
			this.rotationStartVariance = 0;
			this.rotationEnd = 0;
			this.rotationEndVariance = 0;
			this.speed = 244;
			this.speedVariance = 5;
			this.radialAcceleration = 0;
			this.radialAccelVariance = 0;
			this.tangentialAcceleration = 0;
			this.tangentialAccelVariance = 0;
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
			this.blendFuncSource = 1;
			this.blendFuncDestination = 1;
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

		public function get sourcePositionVariancex():Number
		{
			return this.getProperty("sourcePositionVariancex");
		}

		public function set sourcePositionVariancex(value:Number):void
		{
			this.setProperty("sourcePositionVariancex", value);
		}

		public function get sourcePositionVariancey():Number
		{
			return this.getProperty("sourcePositionVariancey");
		}

		public function set sourcePositionVariancey(value:Number):void
		{
			this.setProperty("sourcePositionVariancey", value);
		}

		// particle configuration
		public function get particleLifespan():Number
		{
			return this.getProperty("particleLifespan");
		}

		public function set particleLifespan(value:Number):void
		{
			this.setProperty("particleLifespan", value);
		}


		public function get particleLifespanVariance():Number
		{
			return this.getProperty("particleLifespanVariance");
		}

		public function set particleLifespanVariance(value:Number):void
		{
			this.setProperty("particleLifespanVariance", value);
		}

		public function get startParticleSize():Number
		{
			return this.getProperty("startParticleSize");
		}

		public function set startParticleSize(value:Number):void
		{
			this.setProperty("startParticleSize", value);
		}

		public function get startParticleSizeVariance():Number
		{
			return this.getProperty("startParticleSizeVariance");
		}

		public function set startParticleSizeVariance(value:Number):void
		{
			this.setProperty("startParticleSizeVariance", value);
		}

		public function get finishParticleSize():Number
		{
			return this.getProperty("finishParticleSize");
		}

		public function set finishParticleSize(value:Number):void
		{
			this.setProperty("finishParticleSize", value);
		}

		public function get finishParticleSizeVariance():Number
		{
			return this.getProperty("finishParticleSizeVariance");
		}

		public function set finishParticleSizeVariance(value:Number):void
		{
			this.setProperty("finishParticleSizeVariance", value);
		}

		public function get angle():Number
		{
			return deg2rad(this.getProperty("angle"));
		}

		public function set angle(value:Number):void
		{
			this.setProperty("angle", rad2deg(value));
		}

		public function get angleVariance():Number
		{
			return deg2rad(this.getProperty("angleVariance"));
		}

		public function set angleVariance(value:Number):void
		{
			this.setProperty("angleVariance", rad2deg(value));
		}

		public function get rotationStart():Number
		{
			return this.getProperty("rotationStart");
		}

		public function set rotationStart(value:Number):void
		{
			this.setProperty("rotationStart", value);
		}

		public function get rotationStartVariance():Number
		{
			return this.getProperty("rotationStartVariance");
		}

		public function set rotationStartVariance(value:Number):void
		{
			this.setProperty("rotationStartVariance", value);
		}

		public function get rotationEnd():Number
		{
			return this.getProperty("rotationEnd");
		}

		public function set rotationEnd(value:Number):void
		{
			this.setProperty("rotationEnd", value);
		}

		public function get rotationEndVariance():Number
		{
			return this.getProperty("rotationEndVariance");
		}

		public function set rotationEndVariance(value:Number):void
		{
			this.setProperty("rotationEndVariance", value);
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

		public function get gravityx():Number
		{
			return this.getProperty("gravityx");
		}

		public function set gravityx(value:Number):void
		{
			this.setProperty("gravityx", value);
		}

		public function get gravityy():Number
		{
			return this.getProperty("gravityy");
		}

		public function set gravityy(value:Number):void
		{
			this.setProperty("gravityy", value);
		}

		public function get radialAcceleration():Number
		{
			return this.getProperty("radialAcceleration");
		}

		public function set radialAcceleration(value:Number):void
		{
			this.setProperty("radialAcceleration", value);
		}

		public function get radialAccelVariance():Number
		{
			return this.getProperty("radialAccelVariance");
		}

		public function set radialAccelVariance(value:Number):void
		{
			this.setProperty("radialAccelVariance", value);
		}

		public function get tangentialAcceleration():Number
		{
			return this.getProperty("tangentialAcceleration");
		}

		public function set tangentialAcceleration(value:Number):void
		{
			this.setProperty("tangentialAcceleration", value);
		}

		public function get tangentialAccelVariance():Number
		{
			return this.getProperty("tangentialAccelVariance");
		}

		public function set tangentialAccelVariance(value:Number):void
		{
			this.setProperty("tangentialAccelVariance", value);
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

		public function get blendFuncSource():int
		{
			return this.getProperty("blendFuncSource");
		}

		public function set blendFuncSource(value:int):void
		{	
			this.setProperty("blendFuncSource", value);
		}

		public function get blendFuncDestination():int
		{
			return this.getProperty("blendFuncDestination");
		}

		public function set blendFuncDestination(value:int):void
		{
			this.setProperty("blendFuncDestination", value);
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
			return this._texture;
		}

		public function set texture(value:String):void
		{
			this._texture = value;
		}

		public function parseDataFromFile(value:File):void
		{
			// var extension:String = value.extension;
			parseJsonConfig(value.data.readUTFBytes(value.data.length));
		}

		private function parseJsonConfig(xconfig:String):void 
		{
			var config:Object = JSON.parse(xconfig)
			this.sourcePositionVariancex = config.sourcePositionVariancex;
			this.sourcePositionVariancey = config.sourcePositionVariancey;
			this.gravityx = config.gravityx;
			this.gravityy = config.gravityy;
			this.emitterType = config.emitterType;
			this.particleLifespan =Math.max(0.01, config.particleLifespan);
			this.particleLifespanVariance =config.particleLifespanVariance;
			this.startParticleSize = config.startParticleSize;
			this.startParticleSizeVariance = config.startParticleSizeVariance;
			this.finishParticleSize = config.finishParticleSize;
			this.finishParticleSizeVariance =config.finishParticleSizeVariance;
			this.angle =deg2rad(config.angle);
			this.angleVariance =deg2rad(config.angleVariance);
			this.rotationStart =deg2rad(config.rotationStart);
			this.rotationStartVariance =deg2rad(config.rotationStartVariance);
			this.rotationEnd = deg2rad(config.rotationEnd);
			this.rotationEndVariance = deg2rad(config.rotationEndVariance);
			this.speed = config.speed;
			this.speedVariance =config.speedVariance;
			this.radialAcceleration =config.radialAcceleration;
			this.radialAccelVariance = config.radialAccelVariance;
			this.tangentialAcceleration =config.tangentialAcceleration;
			this.tangentialAccelVariance =config.tangentialAccelVariance;
			this.maxRadius = config.maxRadius;
			this.maxRadiusVariance =config.maxRadiusVariance;
			this.minRadius =config.minRadius;
			this.minRadiusVariance =config.minRadiusVariance;
			this.rotatePerSecond =deg2rad(config.rotatePerSecond);
			this.rotatePerSecondVariance =deg2rad(config.rotatePerSecondVariance);
			this.startColor =new ColorArgb(config.startColorRed, config.startColorGreen, config.startColorBlue, config.startColorAlpha);
			this.startColorVariance =new ColorArgb(config.startColorVarianceRed, config.startColorVarianceGreen, config.startColorVarianceBlue, config.startColorVarianceAlpha);
			this.finishColor =new ColorArgb(config.finishColorRed, config.finishColorGreen, config.finishColorBlue, config.finishColorAlpha);
			this.finishColorVariance =new ColorArgb(config.finishColorVarianceRed, config.finishColorVarianceGreen, config.finishColorVarianceBlue, config.finishColorVarianceAlpha);
			this.blendFuncSource = config.blendFuncSource;
			this.blendFuncDestination = config.blendFuncDestination;
			this.duration = config.duration;
			this.maxParticles = config.maxParticles;
			this.particleLifespan =  Math.max(0.01, config.particleLifespan);
			this.finishParticleSizeVariance = config.finishParticleSizeVariance;
			this.minRadiusVariance = 0.0;
		}

		public static function getBlendFunc(value:int):String
		{
			switch (value)
			{
				case 0:     return Context3DBlendFactor.ZERO;
				case 1:     return Context3DBlendFactor.ONE;
				case 0x300: return Context3DBlendFactor.SOURCE_COLOR;
				case 0x301: return Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR;
				case 0x302: return Context3DBlendFactor.SOURCE_ALPHA;
				case 0x303: return Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
				case 0x304: return Context3DBlendFactor.DESTINATION_ALPHA;
				case 0x305: return Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA;
				case 0x306: return Context3DBlendFactor.DESTINATION_COLOR;
				case 0x307: return Context3DBlendFactor.ONE_MINUS_DESTINATION_COLOR;
				default:    throw new ArgumentError("unsupported blending function: " + value);
			}
		}
		// private function convertBlendFunc(value:String):int
		// {
		// 	switch (value)
		// 	{
		// 		case Context3DBlendFactor.ZERO: return 0;
		// 		case Context3DBlendFactor.ONE: return 1;
		// 		case Context3DBlendFactor.SOURCE_COLOR: return 0x300;
		// 		case Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR: return 0x301;
		// 		case Context3DBlendFactor.SOURCE_ALPHA: return 0x302;
		// 		case Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA: return 0x303;
		// 		case Context3DBlendFactor.DESTINATION_ALPHA: return 0x304;
		// 		case Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA: return 0x305;
		// 		case Context3DBlendFactor.DESTINATION_COLOR: return 0x306;
		// 		case Context3DBlendFactor.ONE_MINUS_DESTINATION_COLOR: return 0x307;
		// 		default:    throw new ArgumentError("unsupported blending function: " + value);
		// 	}
		// }
	}
}