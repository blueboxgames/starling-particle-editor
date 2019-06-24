package com.grantech.manager
{
	import starling.extensions.PDParticleSystem;
	import feathers.data.ListCollection;
	import feathers.core.IFeathersEventDispatcher;
	import starling.events.Event;
	import feathers.core.FeathersControl;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.Quad;
	import feathers.controls.List;


	public class ParticleManager extends FeathersControl
	{
		public static var instance:ParticleManager = new ParticleManager();
		public var particleList:List;
		public var particleDataProvider:ListCollection;
		// TODO:
		// private static const emptyConfig:Object = serializer.readConfig(config:File)
		// private static const defaultTexture:Texture = Texture.fromTexture(new Quad(1,1,0xffffff) as Texture);
		public static const defaultConfig:Object = {
			"emitterXVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"emitterYVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"gravityX": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"gravityY": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"emitterType": {
				"type": int,
				"min": 0,
				"max": 1,
				"value": 0
			},
			"lifespan": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"lifespanVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"startSize": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"startSizeVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"endSize": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"endSizeVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"emitAngle": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"emitAngleVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"startRotation": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"startRotationVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"endRotation": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"endRotationVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"speed": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"speedVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"radialAcceleration": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"radialAccelerationVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"tangentialAcceleration": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"tangentialAccelerationVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"maxRadius": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"maxRadiusVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"minRadius": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"minRadiusVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"rotatePerSecond": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"rotatePerSecondVariance": {
				"type": Number,
				"min": -Infinity,
				"max": Infinity,
				"value": 0
			},
			"startColor": {
				"type": Object,
				"data": {
					"red": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					},
					"green": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					},
					"blue": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					}
				}
			},
			"startColorVariance": {
				"type": Object,
				"data": {
					"red": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					},
					"green": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					},
					"blue": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					}
				}
			},
			"endColor": {
				"type": Object,
				"data": {
					"red": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					},
					"green": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					},
					"blue": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					}
				}
			},
			"endColorVariance": {
				"type": Object,
				"data": {
					"red": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					},
					"green": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					},
					"blue": {
						"type": Number,
						"min": 0,
						"max": 255,
						"value": 0
					}
				}
			}
		};

		public function ParticleManager()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			instance = this;
			this.particleDataProvider = new ListCollection();
		}

		private function particleDataProvider_triggeredHandler(e:Event):void
		{
			
		}

		public function createNewParticle(particleConfig:Object=null, particleTexture:Texture=null):void
		{
			var pc:Object = particleConfig;
			//var pi:Texture = particleTexture;
			if(!particleConfig == null)
			{
				pc = defaultConfig;
			}
			if(!particleTexture == null)
			{
			//	pi = defaultTexture;
			}
		}
	}
}