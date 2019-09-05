package com.grantech.models
{
	import starling.extensions.ColorArgb;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;

	public class ParticleDataModel extends LayerDataModel
	{
		[Embed(source="/media/default.png")]
		public static var defaultBitmap:Class;
		public var load:String = "";
		public var save:String = "";
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
			this.maxRadius = 0;
			this.maxRadiusVariance = 0;
			this.minRadius = 0;
			this.minRadiusVariance = 0;
			this.rotatePerSecond = 0;
			this.rotatePerSecondVariance = 0;
			this.startColor = new ColorArgb(0.4,0,0,1);
			this.startColorVariance = new ColorArgb(0,0,0,1);
			this.finishColor = new ColorArgb(0,0,0,1);
			this.finishColorVariance = new ColorArgb(0,0,0,1);
			this.blendFuncSource = 1;
			this.blendFuncDestination = 1;
			this.maxParticles = 300;
			this.texture = Texture.fromBitmap(new defaultBitmap()) as Texture; //  File.applicationDirectory.resolvePath(File.applicationDirectory.nativePath + "/media/default.png");
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
		public function get startColorGreen():Number
		{
			return this.startColor.green;
		}
		public function get startColorBlue():Number
		{
			return this.startColor.blue;
		}
		public function get startColorAlpha():Number
		{
			return this.startColor.alpha;
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
		public function get startColorVarianceGreen():Number
		{
			return this.startColorVariance.green;
		}
		public function get startColorVarianceBlue():Number
		{
			return this.startColorVariance.blue;
		}
		public function get startColorVarianceAlpha():Number
		{
			return this.startColorVariance.alpha;
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
		public function get finishColorGreen():Number
		{
			return this.finishColor.green;
		}
		public function get finishColorBlue():Number
		{
			return this.finishColor.blue;
		}
		public function get finishColorAlpha():Number
		{
			return this.finishColor.alpha;
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
		public function get finishColorVarianceGreen():Number
		{
			return this.finishColorVariance.green;
		}
		public function get finishColorVarianceBlue():Number
		{
			return this.finishColorVariance.blue;
		}
		public function get finishColorVarianceAlpha():Number
		{
			return this.finishColorVariance.alpha;
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

		public function get texture():Texture
		{
			return this.getProperty("texture");
		}
		public function set texture(value:Texture):void
		{
			this.setProperty("texture", value);
		}

		public function get jsonOutput():Object
		{
			return {
				emitterType: this.emitterType,
				duration: this.duration,
				sourcePositionVariancex: this.sourcePositionVariancex,
				sourcePositionVariancey: this.sourcePositionVariancey,
				gravityx: this.gravityx,
				gravityy: this.gravityy,
				particleLifespan: this.particleLifespan,
				particleLifespanVariance: this.particleLifespanVariance,
				startParticleSize: this.startParticleSize,
				startParticleSizeVariance: this.startParticleSizeVariance,
				finishParticleSize: this.finishParticleSize,
				finishParticleSizeVariance: this.finishParticleSizeVariance,
				angle: this.angle,
				angleVariance: this.angleVariance,
				rotationStart: this.rotationStart,
				rotationStartVariance: this.rotationStartVariance,
				rotationEnd: this.rotationEnd,
				rotationEndVariance: this.rotationEndVariance,
				speed: this.speed,
				speedVariance: this.speedVariance,
				radialAcceleration: this.radialAcceleration,
				radialAccelVariance: this.radialAccelVariance,
				tangentialAcceleration: this.tangentialAcceleration,
				tangentialAccelVariance: this.tangentialAccelVariance,
				maxRadius: this.maxRadius,
				maxRadiusVariance: this.maxRadiusVariance,
				minRadius: this.minRadius,
				minRadiusVariance: this.minRadiusVariance,
				rotatePerSecond: this.rotatePerSecond,
				rotatePerSecondVariance: this.rotatePerSecondVariance,
				startColorRed: this.startColor.red,
				startColorBlue: this.startColor.blue,
				startColorGreen: this.startColor.green,
				startColorAlpha: this.startColor.alpha,
				startColorVarianceRed: this.startColorVariance.red,
				startColorVarianceBlue: this.startColorVariance.blue,
				startColorVarianceGreen: this.startColorVariance.green,
				startColorVarianceAlpha: this.startColorVariance.alpha,
				finishColorRed: this.finishColor.red,
				finishColorBlue: this.finishColor.blue,
				finishColorGreen: this.finishColor.green,
				finishColorAlpha: this.finishColor.alpha,
				finishColorVarianceRed: this.finishColorVariance.red,
				finishColorVarianceBlue: this.finishColorVariance.blue,
				finishColorVarianceGreen: this.finishColorVariance.green,
				finishColorVarianceAlpha: this.finishColorVariance.alpha,
				blendFuncSource:this.blendFuncSource,
				blendFuncDestination: this.blendFuncDestination,
				maxParticles: this.maxParticles
			}
		}

		public function parseJsonConfig(json:String):void 
		{
			var config:Object = JSON.parse(json)
			this.sourcePositionVariancex = config.sourcePositionVariancex;
			this.sourcePositionVariancey = config.sourcePositionVariancey;
			this.gravityx = config.gravityx;
			this.gravityy = config.gravityy;
			this.emitterType = config.emitterType;
			this.particleLifespan = Math.max(0.01, config.particleLifespan);
			this.particleLifespanVariance = config.particleLifespanVariance;
			this.startParticleSize = config.startParticleSize;
			this.startParticleSizeVariance = config.startParticleSizeVariance;
			this.finishParticleSize = config.finishParticleSize;
			this.finishParticleSizeVariance = config.finishParticleSizeVariance;
			this.angle = deg2rad(config.angle);
			this.angleVariance = deg2rad(config.angleVariance);
			this.rotationStart = deg2rad(config.rotationStart);
			this.rotationStartVariance = deg2rad(config.rotationStartVariance);
			this.rotationEnd = deg2rad(config.rotationEnd);
			this.rotationEndVariance = deg2rad(config.rotationEndVariance);
			this.speed = config.speed;
			this.speedVariance = config.speedVariance;
			this.radialAcceleration = config.radialAcceleration;
			this.radialAccelVariance = config.radialAccelVariance;
			this.tangentialAcceleration = config.tangentialAcceleration;
			this.tangentialAccelVariance = config.tangentialAccelVariance;
			this.maxRadius = config.maxRadius;
			this.maxRadiusVariance = config.maxRadiusVariance;
			this.minRadius = config.minRadius;
			this.minRadiusVariance = config.minRadiusVariance;
			this.rotatePerSecond = deg2rad(config.rotatePerSecond);
			this.rotatePerSecondVariance = deg2rad(config.rotatePerSecondVariance);
			this.startColor = new ColorArgb(config.startColorRed, config.startColorGreen, config.startColorBlue, config.startColorAlpha);
			this.startColorVariance = new ColorArgb(config.startColorVarianceRed, config.startColorVarianceGreen, config.startColorVarianceBlue, config.startColorVarianceAlpha);
			this.finishColor = new ColorArgb(config.finishColorRed, config.finishColorGreen, config.finishColorBlue, config.finishColorAlpha);
			this.finishColorVariance = new ColorArgb(config.finishColorVarianceRed, config.finishColorVarianceGreen, config.finishColorVarianceBlue, config.finishColorVarianceAlpha);
			this.blendFuncSource = config.blendFuncSource;
			this.blendFuncDestination = config.blendFuncDestination;
			this.duration = config.duration;
			this.maxParticles = config.maxParticles;
		}

		public function parseXMLConfig(xml:String):void
		{
			var config:XML = new XML(xml);
			this.sourcePositionVariancex = parseFloat(config.sourcePositionVariance.attribute("x"));
			this.sourcePositionVariancey = parseFloat(config.sourcePositionVariance.attribute("y"));
			this.gravityx = parseFloat(config.gravity.attribute("x"));
			this.gravityy = parseFloat(config.gravity.attribute("y"));
			this.emitterType = getIntValue(config.emitterType);
			this.particleLifespan = Math.max(0.01, getFloatValue(config.particleLifeSpan));
			this.particleLifespanVariance = getFloatValue(config.particleLifespanVariance);
			this.startParticleSize = getFloatValue(config.startParticleSize);
			this.startParticleSizeVariance = getFloatValue(config.startParticleSizeVariance);
			this.finishParticleSize = getFloatValue(config.finishParticleSize);
			this.finishParticleSizeVariance = getFloatValue(config.FinishParticleSizeVariance);
			this.angle = deg2rad(getFloatValue(config.angle));
			this.angleVariance = deg2rad(getFloatValue(config.angleVariance));
			this.rotationStart = deg2rad(getFloatValue(config.rotationStart));
			this.rotationStartVariance = deg2rad(getFloatValue(config.rotationStartVariance));
			this.rotationEnd = deg2rad(getFloatValue(config.rotationEnd));
			this.rotationEndVariance = deg2rad(getFloatValue(config.rotationEndVariance));
			this.speed = getFloatValue(config.speed);
			this.speedVariance = getFloatValue(config.speedVariance);
			this.radialAcceleration = getFloatValue(config.radialAcceleration);
			this.radialAccelVariance = getFloatValue(config.radialAccelVariance);
			this.tangentialAcceleration = getFloatValue(config.tangentialAcceleration);
			this.tangentialAccelVariance = getFloatValue(config.tangentialAccelVariance);
			this.maxRadius = getFloatValue(config.maxRadius);
			this.minRadiusVariance = getFloatValue(config.maxRadiusVariance);
			this.minRadius = getFloatValue(config.minRadius);
			this.minRadiusVariance = getFloatValue(config.minRadiusVariance);
			this.rotatePerSecond = deg2rad(getFloatValue(config.rotatePerSecond));
			this.rotatePerSecondVariance = deg2rad(getFloatValue(config.rotatePerSecondVariance));
			this.startColor = getColor(config.startColor);
			this.startColorVariance = getColor(config.startColorVariance);
			this.finishColor = getColor(config.finishColor);
			this.finishColorVariance = getColor(config.finishColorVariance);
			this.blendFuncSource = getIntValue(config.blendFuncSource);
			this.blendFuncDestination = getIntValue(config.blendFuncDestination);
			this.duration = getFloatValue(config.duration);
			this.maxParticles = getIntValue(config.maxParticles);

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
	}
}