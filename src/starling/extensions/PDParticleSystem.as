// =================================================================================================
//
//	Starling Framework - Particle System Extension
//	Copyright 2012 Gamua OG. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.extensions
{
    import flash.display3D.Context3DBlendFactor;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.utils.deg2rad;

    public class PDParticleSystem extends ParticleSystem
    {
        public static const EMITTER_TYPE_GRAVITY:int = 0;
        public static const EMITTER_TYPE_RADIAL:int  = 1;
        /* 
        // emitter configuration                            // .pex element name
        private var _emitterType:int;                       // emitterType
        private var _emitterXVariance:Number;               // sourcePositionVariance x
        private var _emitterYVariance:Number;               // sourcePositionVariance y
        private var _defaultDuration:Number;                // duration
        
        // particle configuration
        private var _lifespan:Number;                       // particleLifeSpan
        private var _lifespanVariance:Number;               // particleLifeSpanVariance
        private var _startSize:Number;                      // startParticleSize
        private var _startSizeVariance:Number;              // startParticleSizeVariance
        private var _endSize:Number;                        // finishParticleSize
        private var _endSizeVariance:Number;                // finishParticleSizeVariance
        private var _emitAngle:Number;                      // angle
        private var _emitAngleVariance:Number;              // angleVariance
        private var _startRotation:Number;                  // rotationStart
        private var _startRotationVariance:Number;          // rotationStartVariance
        private var _endRotation:Number;                    // rotationEnd
        private var _endRotationVariance:Number;            // rotationEndVariance
        
        // gravity configuration
        private var _speed:Number;                          // speed
        private var _speedVariance:Number;                  // speedVariance
        private var _gravityX:Number;                       // gravity x
        private var _gravityY:Number;                       // gravity y
        private var _radialAcceleration:Number;             // radialAcceleration
        private var _radialAccelerationVariance:Number;     // radialAccelerationVariance
        private var _tangentialAcceleration:Number;         // tangentialAcceleration
        private var _tangentialAccelerationVariance:Number; // tangentialAccelerationVariance
        
        // radial configuration 
        private var _maxRadius:Number;                      // maxRadius
        private var _maxRadiusVariance:Number;              // maxRadiusVariance
        private var _minRadius:Number;                      // minRadius
        private var _minRadiusVariance:Number;              // minRadiusVariance
        private var _rotatePerSecond:Number;                // rotatePerSecond
        private var _rotatePerSecondVariance:Number;        // rotatePerSecondVariance
        
        // color configuration
        private var _startColor:ColorArgb;                  // startColor
        private var _startColorVariance:ColorArgb;          // startColorVariance
        private var _endColor:ColorArgb;                    // finishColor
        private var _endColorVariance:ColorArgb;            // finishColorVariance
         */
        public function PDParticleSystem(config:Object, texture:Texture)
        {
            super(texture);
			if( config is XML )
				parseConfig(config as XML);
			else
				parseJsonConfig(config);
        }
        
        protected override function createParticle():Particle
        {
            return new PDParticle() as Particle;
        }
        
        protected override function initParticle(aParticle:Particle):void
        {
            var particle:PDParticle = aParticle as PDParticle; 
         
            // for performance reasons, the random variances are calculated inline instead
            // of calling a function
            
            var lifespan:Number = getPropertyAsFloat("lifespan") + getPropertyAsFloat("lifespanVariance") * (Math.random() * 2.0 - 1.0);
            var textureWidth:Number = texture ? texture.width : 16;
            
            particle.currentTime = 0.0;
            particle.totalTime = lifespan > 0.0 ? lifespan : 0.0;
            
            if (lifespan <= 0.0) return;

            var emitterX:Number = this.emitterX;
            var emitterY:Number = this.emitterY;

            particle.x = emitterX + getPropertyAsFloat("emitterXVariance") * (Math.random() * 2.0 - 1.0);
            particle.y = emitterY + getPropertyAsFloat("emitterYVariance") * (Math.random() * 2.0 - 1.0);
            particle.startX = emitterX;
            particle.startY = emitterY;
            
            var angle:Number = getPropertyAsFloat("emitAngle") + getPropertyAsFloat("emitAngleVariance") * (Math.random() * 2.0 - 1.0);
            var speed:Number = getPropertyAsFloat("speed") + getPropertyAsFloat("speedVariance") * (Math.random() * 2.0 - 1.0);
            particle.velocityX = speed * Math.cos(angle);
            particle.velocityY = speed * Math.sin(angle);
            
            var startRadius:Number = getPropertyAsFloat("maxRadius") + getPropertyAsFloat("maxRadiusVariance") * (Math.random() * 2.0 - 1.0);
            var endRadius:Number   = getPropertyAsFloat("minRadius") + getPropertyAsFloat("minRadiusVariance") * (Math.random() * 2.0 - 1.0);
            particle.emitRadius = startRadius;
            particle.emitRadiusDelta = (endRadius - startRadius) / lifespan;
            particle.emitRotation = getPropertyAsFloat("emitAngle") + getPropertyAsFloat("emitAngleVariance") * (Math.random() * 2.0 - 1.0);
            particle.emitRotationDelta = getPropertyAsFloat("rotatePerSecond") + getPropertyAsFloat("rotatePerSecondVariance") * (Math.random() * 2.0 - 1.0);
            particle.radialAcceleration = getPropertyAsFloat("radialAcceleration") + getPropertyAsFloat("radialAccelerationVariance") * (Math.random() * 2.0 - 1.0);
            particle.tangentialAcceleration = getPropertyAsFloat("tangentialAcceleration") + getPropertyAsFloat("tangentialAccelerationVariance") * (Math.random() * 2.0 - 1.0);
            
            var startSize:Number = getPropertyAsFloat("startSize") + getPropertyAsFloat("startSizeVariance") * (Math.random() * 2.0 - 1.0);
            var endSize:Number = getPropertyAsFloat("endSize") + getPropertyAsFloat("endSizeVariance") * (Math.random() * 2.0 - 1.0);
            if (startSize < 0.1) startSize = 0.1;
            if (endSize < 0.1)   endSize = 0.1;
            particle.scale = startSize / textureWidth;
            particle.scaleDelta = ((endSize - startSize) / lifespan) / textureWidth;
            
            // colors
            
            var startColor:ColorArgb = particle.colorArgb;
            var colorDelta:ColorArgb = particle.colorArgbDelta;
            
            startColor.red   = getPropertyAsARGB("startColor").red;
            startColor.green = getPropertyAsARGB("startColor").green;
            startColor.blue  = getPropertyAsARGB("startColor").blue;
            startColor.alpha = getPropertyAsARGB("startColor").alpha;
            
            if (getPropertyAsARGB("startColorVariance").red != 0)   startColor.red   += getPropertyAsARGB("startColorVariance").red   * (Math.random() * 2.0 - 1.0);
            if (getPropertyAsARGB("startColorVariance").green != 0) startColor.green += getPropertyAsARGB("startColorVariance").green * (Math.random() * 2.0 - 1.0);
            if (getPropertyAsARGB("startColorVariance").blue != 0)  startColor.blue  += getPropertyAsARGB("startColorVariance").blue  * (Math.random() * 2.0 - 1.0);
            if (getPropertyAsARGB("startColorVariance").alpha != 0) startColor.alpha += getPropertyAsARGB("startColorVariance").alpha * (Math.random() * 2.0 - 1.0);
            
            var endColorRed:Number   = getPropertyAsARGB("endColor").red;
            var endColorGreen:Number = getPropertyAsARGB("endColor").green;
            var endColorBlue:Number  = getPropertyAsARGB("endColor").blue;
            var endColorAlpha:Number = getPropertyAsARGB("endColor").alpha;

            if (getPropertyAsARGB("endColorVariance").red != 0)   endColorRed   += getPropertyAsARGB("endColorVariance").red   * (Math.random() * 2.0 - 1.0);
            if (getPropertyAsARGB("endColorVariance").green != 0) endColorGreen += getPropertyAsARGB("endColorVariance").green * (Math.random() * 2.0 - 1.0);
            if (getPropertyAsARGB("endColorVariance").blue != 0)  endColorBlue  += getPropertyAsARGB("endColorVariance").blue  * (Math.random() * 2.0 - 1.0);
            if (getPropertyAsARGB("endColorVariance").alpha != 0) endColorAlpha += getPropertyAsARGB("endColorVariance").alpha * (Math.random() * 2.0 - 1.0);
            
            colorDelta.red   = (endColorRed   - startColor.red)   / lifespan;
            colorDelta.green = (endColorGreen - startColor.green) / lifespan;
            colorDelta.blue  = (endColorBlue  - startColor.blue)  / lifespan;
            colorDelta.alpha = (endColorAlpha - startColor.alpha) / lifespan;
            
            // rotation
            
            var startRotation:Number = getPropertyAsFloat("startRotation") + getPropertyAsFloat("startRotationVariance") * (Math.random() * 2.0 - 1.0);
            var endRotation:Number   = getPropertyAsFloat("endRotation")   + getPropertyAsFloat("endRotationVariance")   * (Math.random() * 2.0 - 1.0);
            
            particle.rotation = startRotation;
            particle.rotationDelta = (endRotation - startRotation) / lifespan;
        }
        
        protected override function advanceParticle(aParticle:Particle, passedTime:Number):void
        {
            var particle:PDParticle = aParticle as PDParticle;
            
            var restTime:Number = particle.totalTime - particle.currentTime;
            passedTime = restTime > passedTime ? passedTime : restTime;
            particle.currentTime += passedTime;
            
            if (getPropertyAsInt("_emitterType") == EMITTER_TYPE_RADIAL)
            {
                particle.emitRotation += particle.emitRotationDelta * passedTime;
                particle.emitRadius   += particle.emitRadiusDelta   * passedTime;
                particle.x = emitterX - Math.cos(particle.emitRotation) * particle.emitRadius;
                particle.y = emitterY - Math.sin(particle.emitRotation) * particle.emitRadius;
            }
            else
            {
                var distanceX:Number = particle.x - particle.startX;
                var distanceY:Number = particle.y - particle.startY;
                var distanceScalar:Number = Math.sqrt(distanceX*distanceX + distanceY*distanceY);
                if (distanceScalar < 0.01) distanceScalar = 0.01;
                
                var radialX:Number = distanceX / distanceScalar;
                var radialY:Number = distanceY / distanceScalar;
                var tangentialX:Number = radialX;
                var tangentialY:Number = radialY;
                
                radialX *= particle.radialAcceleration;
                radialY *= particle.radialAcceleration;
                
                var newY:Number = tangentialX;
                tangentialX = -tangentialY * particle.tangentialAcceleration;
                tangentialY = newY * particle.tangentialAcceleration;
                
                particle.velocityX += passedTime * (getPropertyAsFloat("gravityX") + radialX + tangentialX);
                particle.velocityY += passedTime * (getPropertyAsFloat("gravityY") + radialY + tangentialY);
                particle.x += particle.velocityX * passedTime;
                particle.y += particle.velocityY * passedTime;
            }
            
            particle.scale += particle.scaleDelta * passedTime;
            particle.rotation += particle.rotationDelta * passedTime;
            
            particle.colorArgb.red   += particle.colorArgbDelta.red   * passedTime;
            particle.colorArgb.green += particle.colorArgbDelta.green * passedTime;
            particle.colorArgb.blue  += particle.colorArgbDelta.blue  * passedTime;
            particle.colorArgb.alpha += particle.colorArgbDelta.alpha * passedTime;
            
            particle.color = particle.colorArgb.toRgb();
            particle.alpha = particle.colorArgb.alpha;
        }
        
        private function updateEmissionRate():void
        {
            emissionRate = (capacity - 1) / getPropertyAsFloat("lifespan");
        }
        
		private function parseJsonConfig(config:Object):void 
		{
            setProperty("emitterXVariance", config.sourcePositionVariancex);
            setProperty("emitterYVariance", config.sourcePositionVariancey);
            setProperty("gravityX", config.gravityx);
            setProperty("gravityY", config.gravityy);
            setProperty("emitterType", config.emitterType);
            setProperty("lifespan", Math.max(0.01, config.particleLifespan));
            setProperty("lifespanVariance", config.particleLifespanVariance);
            setProperty("startSize", config.startParticleSize);
            setProperty("startSizeVariance", config.startParticleSizeVariance);
            setProperty("endSize", config.finishParticleSize);
            setProperty("endSizeVariance", config.finishParticleSizeVariance);
            setProperty("emitAngle", deg2rad(config.angle));
            setProperty("emitAngleVariance", deg2rad(config.angleVariance));
            setProperty("startRotation", deg2rad(config.rotationStart));
            setProperty("startRotationVariance", deg2rad(config.rotationStartVariance));
            setProperty("endRotation", deg2rad(config.rotationEnd));
            setProperty("endRotationVariance", deg2rad(config.rotationEndVariance));
            setProperty("speed", config.speed);
            setProperty("speedVariance", config.speedVariance);
            setProperty("radialAcceleration", config.radialAcceleration);
            setProperty("radialAccelerationVariance", config.radialAccelVariance);
            setProperty("tangentialAcceleration", config.tangentialAcceleration);
            setProperty("tangentialAccelerationVariance", config.tangentialAccelVariance);
            setProperty("maxRadius", config.maxRadius);
            setProperty("maxRadiusVariance", config.maxRadiusVariance);
            setProperty("minRadius", config.minRadius);
            setProperty("minRadiusVariance", config.minRadiusVariance);
            setProperty("rotatePerSecond", deg2rad(config.rotatePerSecond));
            setProperty("rotatePerSecondVariance", deg2rad(config.rotatePerSecondVariance));
            setProperty("startColor", new ColorArgb(config.startColorRed, config.startColorGreen, config.startColorBlue, config.startColorAlpha));
            setProperty("startColorVariance", new ColorArgb(config.startColorVarianceRed, config.startColorVarianceGreen, config.startColorVarianceBlue, config.startColorVarianceAlpha));
            setProperty("endColor", new ColorArgb(config.finishColorRed, config.finishColorGreen, config.finishColorBlue, config.finishColorAlpha));
            setProperty("endColorVariance", new ColorArgb(config.finishColorVarianceRed, config.finishColorVarianceGreen, config.finishColorVarianceBlue, config.finishColorVarianceAlpha));
            blendFactorSource = getBlendFunc(config.blendFuncSource);
            blendFactorDestination = getBlendFunc(config.blendFuncDestination);
            defaultDuration = config.duration;
            capacity = config.maxParticles;

            // compatibility with future Particle Designer versions
            // (might fix some of the uppercase/lowercase typos)
            
            if (isNaN(getPropertyAsFloat("endSizeVariance")))
                setProperty("endSizeVariance", config.finishParticleSizeVariance);
            if (isNaN(getPropertyAsFloat("lifespan")))
                setProperty("lifespan", Math.max(0.01, config.particleLifeSpan));
            if (isNaN(getPropertyAsFloat("lifespanVariance")))
                setProperty("lifespanVariance", config.particleLifeSpanVariance);
            if (isNaN(getPropertyAsFloat("minRadiusVariance")))
                setProperty("minRadiusVariance", 0.0);

            updateEmissionRate();
		}
		
        private function parseConfig(config:XML):void
        {
            setProperty("emitterXVariance", parseFloat(config.sourcePositionVariance.attribute("x")));
            setProperty("emitterYVariance", parseFloat(config.sourcePositionVariance.attribute("y")));
            setProperty("gravityX", parseFloat(config.gravity.attribute("x")));
            setProperty("gravityY", parseFloat(config.gravity.attribute("y")));
            setProperty("emitterType", getIntValue(config.emitterType));
            setProperty("lifespan", Math.max(0.01, getFloatValue(config.particleLifeSpan)));
            setProperty("lifespanVariance", getFloatValue(config.particleLifespanVariance));
            setProperty("startSize", getFloatValue(config.startParticleSize));
            setProperty("startSizeVariance", getFloatValue(config.startParticleSizeVariance));
            setProperty("endSize", getFloatValue(config.finishParticleSize));
            setProperty("endSizeVariance", getFloatValue(config.FinishParticleSizeVariance));
            setProperty("emitAngle", deg2rad(getFloatValue(config.angle)));
            setProperty("emitAngleVariance", deg2rad(getFloatValue(config.angleVariance)));
            setProperty("startRotation", deg2rad(getFloatValue(config.rotationStart)));
            setProperty("startRotationVariance", deg2rad(getFloatValue(config.rotationStartVariance)));
            setProperty("endRotation", deg2rad(getFloatValue(config.rotationEnd)));
            setProperty("endRotationVariance", deg2rad(getFloatValue(config.rotationEndVariance)));
            setProperty("speed", getFloatValue(config.speed));
            setProperty("speedVariance", getFloatValue(config.speedVariance));
            setProperty("radialAcceleration", getFloatValue(config.radialAcceleration));
            setProperty("radialAccelerationVariance", getFloatValue(config.radialAccelVariance));
            setProperty("tangentialAcceleration", getFloatValue(config.tangentialAcceleration));
            setProperty("tangentialAccelerationVariance", getFloatValue(config.tangentialAccelVariance));
            setProperty("maxRadius", getFloatValue(config.maxRadius));
            setProperty("maxRadiusVariance", getFloatValue(config.maxRadiusVariance));
            setProperty("minRadius", getFloatValue(config.minRadius));
            setProperty("minRadiusVariance", getFloatValue(config.minRadiusVariance));
            setProperty("rotatePerSecond", deg2rad(getFloatValue(config.rotatePerSecond)));
            setProperty("rotatePerSecondVariance", deg2rad(getFloatValue(config.rotatePerSecondVariance)));
            setProperty("startColor", getColor(config.startColor));
            setProperty("startColorVariance", getColor(config.startColorVariance));
            setProperty("endColor", getColor(config.finishColor));
            setProperty("endColorVariance", getColor(config.finishColorVariance));
            blendFactorSource = getBlendFunc(getIntValue(config.blendFuncSource));
            blendFactorDestination = getBlendFunc(getIntValue(config.blendFuncDestination));
            defaultDuration = getFloatValue(config.duration);
            capacity = getIntValue(config.maxParticles);

            // compatibility with future Particle Designer versions
            // (might fix some of the uppercase/lowercase typos)
            
            if (isNaN(getPropertyAsFloat("endSizeVariance")))
                setProperty("endSizeVariance", getFloatValue(config.finishParticleSizeVariance));
            if (isNaN(getPropertyAsFloat("lifespan")))
                setProperty("lifespan", Math.max(0.01, getFloatValue(config.particleLifespan)));
            if (isNaN(getPropertyAsFloat("lifespanVariance")))
                setProperty("lifespanVariance", getFloatValue(config.particleLifeSpanVariance));
            if (isNaN(getPropertyAsFloat("minRadiusVariance")))
                setProperty("minRadiusVariance", 0.0);

            updateEmissionRate();

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
	
		private function getBlendFunc(value:int):String
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
		
        public function get emitterType():int { return getPropertyAsInt("emitterType"); }
        public function set emitterType(value:int):void { setProperty("emitterType", value); }

        public function get emitterXVariance():Number { return getPropertyAsFloat("emitterXVariance"); }
        public function set emitterXVariance(value:Number):void { setProperty("emitterXVariance", value); }

        public function get emitterYVariance():Number { return getPropertyAsFloat("emitterYVariance"); }
        public function set emitterYVariance(value:Number):void { setProperty("emitterYVariance", value); }

        public function get defaultDuration():Number { return getPropertyAsFloat("defaultDuration"); }
        public function set defaultDuration(value:Number):void
        {
            setProperty("defaultDuration", value < 0 ? Number.MAX_VALUE : value);
        }

        override public function set capacity(value:int):void
        {
            super.capacity = value;
            updateEmissionRate();
        }

        public function get lifespan():Number { return getPropertyAsFloat("lifespan"); }
        public function set lifespan(value:Number):void 
        { 
            setProperty("lifespan", Math.max(0.01, value));
            updateEmissionRate();
        }

        public function get lifespanVariance():Number { return getPropertyAsFloat("lifespanVariance"); }
        public function set lifespanVariance(value:Number):void { setProperty("lifespanVariance", value); }

        public function get startSize():Number { return getPropertyAsFloat("startSize"); }
        public function set startSize(value:Number):void { setProperty("startSize", value); }

        public function get startSizeVariance():Number { return getPropertyAsFloat("startSizeVariance"); }
        public function set startSizeVariance(value:Number):void { setProperty("startSizeVariance", value); }

        public function get endSize():Number { return getPropertyAsFloat("endSize"); }
        public function set endSize(value:Number):void { setProperty("endSize", value); }

        public function get endSizeVariance():Number { return getPropertyAsFloat("endSizeVariance"); }
        public function set endSizeVariance(value:Number):void { setProperty("endSizeVariance", value); }

        public function get emitAngle():Number { return getPropertyAsFloat("emitAngle"); }
        public function set emitAngle(value:Number):void { setProperty("emitAngle", value); }

        public function get emitAngleVariance():Number { return getPropertyAsFloat("emitAngleVariance"); }
        public function set emitAngleVariance(value:Number):void { setProperty("emitAngleVariance", value); }

        public function get startRotation():Number { return getPropertyAsFloat("startRotation"); }
        public function set startRotation(value:Number):void { setProperty("startRotation", value); }
        
        public function get startRotationVariance():Number { return getPropertyAsFloat("startRotationVariance"); }
        public function set startRotationVariance(value:Number):void { setProperty("startRotationVariance", value); }
        
        public function get endRotation():Number { return getPropertyAsFloat("endRotation"); }
        public function set endRotation(value:Number):void { setProperty("endRotation", value); }
        
        public function get endRotationVariance():Number { return getPropertyAsFloat("endRotationVariance"); }
        public function set endRotationVariance(value:Number):void { setProperty("endRotationVariance", value); }
        
        public function get speed():Number { return getPropertyAsFloat("speed"); }
        public function set speed(value:Number):void { setProperty("speed", value); }

        public function get speedVariance():Number { return getPropertyAsFloat("speedVariance"); }
        public function set speedVariance(value:Number):void { setProperty("speedVariance", value); }

        public function get gravityX():Number { return getPropertyAsFloat("gravityX"); }
        public function set gravityX(value:Number):void { setProperty("gravityX", value); }

        public function get gravityY():Number { return getPropertyAsFloat("gravityY"); }
        public function set gravityY(value:Number):void { setProperty("gravityY", value); }

        public function get radialAcceleration():Number { return getPropertyAsFloat("radialAcceleration"); }
        public function set radialAcceleration(value:Number):void { setProperty("radialAcceleration", value); }

        public function get radialAccelerationVariance():Number { return getPropertyAsFloat("radialAccelerationVariance"); }
        public function set radialAccelerationVariance(value:Number):void { setProperty("radialAccelerationVariance", value); }

        public function get tangentialAcceleration():Number { return getPropertyAsFloat("tangentialAcceleration"); }
        public function set tangentialAcceleration(value:Number):void { setProperty("tangentialAcceleration", value); }

        public function get tangentialAccelerationVariance():Number { return getPropertyAsFloat("tangentialAccelerationVariance"); }
        public function set tangentialAccelerationVariance(value:Number):void { setProperty("tangentialAccelerationVariance", value); }

        public function get maxRadius():Number { return getPropertyAsFloat("maxRadius"); }
        public function set maxRadius(value:Number):void { setProperty("maxRadius", value); }

        public function get maxRadiusVariance():Number { return getPropertyAsFloat("maxRadiusVariance"); }
        public function set maxRadiusVariance(value:Number):void { setProperty("maxRadiusVariance", value); }

        public function get minRadius():Number { return getPropertyAsFloat("minRadius"); }
        public function set minRadius(value:Number):void { setProperty("minRadius", value); }

        public function get minRadiusVariance():Number { return getPropertyAsFloat("minRadiusVariance"); }
        public function set minRadiusVariance(value:Number):void { setProperty("minRadiusVariance", value); }

        public function get rotatePerSecond():Number { return getPropertyAsFloat("rotatePerSecond"); }
        public function set rotatePerSecond(value:Number):void { setProperty("rotatePerSecond", value); }

        public function get rotatePerSecondVariance():Number { return getPropertyAsFloat("rotatePerSecondVariance"); }
        public function set rotatePerSecondVariance(value:Number):void { setProperty("rotatePerSecondVariance", value); }

        public function get startColor():ColorArgb { return getPropertyAsARGB("startColor"); }
        public function set startColor(value:ColorArgb):void { setProperty("startColor", value); }

        public function get startColorVariance():ColorArgb { return getPropertyAsARGB("startColorVariance"); }
        public function set startColorVariance(value:ColorArgb):void { setProperty("startColorVariance", value); }

        public function get endColor():ColorArgb { return getPropertyAsARGB("endColor"); }
        public function set endColor(value:ColorArgb):void { setProperty("endColor", value); }

        public function get endColorVariance():ColorArgb { return getPropertyAsARGB("endColorVariance"); }
        public function set endColorVariance(value:ColorArgb):void { setProperty("endColorVariance", value); }

        public var properties:Dictionary = new Dictionary(); 
        public function setProperty(key:String, value:*) : void
        {
            properties[key] = value;
        }
        public function getPropertyAsARGB(key:String) : ColorArgb
        {
            if( !properties.hasOwnProperty(key) )
                return null;
            return properties[key] as ColorArgb;
        }
        public function getPropertyAsInt(key:String) : int
        {
            if( !properties.hasOwnProperty(key) )
                return 0;
            return properties[key];
        }
        public function getPropertyAsUint(key:String) : uint
        {
            if( !properties.hasOwnProperty(key) )
                return 0;
            return properties[key];
        }
        public function getPropertyAsFloat(key:String) : Number
        {
            if( !properties.hasOwnProperty(key) )
                return NaN;
            return properties[key];
        }
        public function getPropertyAsBool(key:String) : Boolean
        {
            if( !properties.hasOwnProperty(key) )
                return false;
            return properties[key];
        }
        public function getProperty(key:String) : *
        {
            if( !properties.hasOwnProperty(key) )
                return null;
            return properties[key];
        }
    }
}
