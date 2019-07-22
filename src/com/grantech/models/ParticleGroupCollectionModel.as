package com.grantech.models
{
	import feathers.data.ArrayHierarchicalCollection;

	public class ParticleGroupCollectionModel
	{
		private var _groupModel:ArrayHierarchicalCollection;

		public function get groupModel():ArrayHierarchicalCollection
		{
			return this._groupModel;
		}

		public function ParticleGroupCollectionModel(particleData:ParticleDataModel)
		{
			this._groupModel = new ArrayHierarchicalCollection(
				[
					{
						header: "Image",
						children: [
							{key: "texture", label: "Texture", value: particleData.texture}
						]
					},
					{
						header: "Position", 
						children: [
							{key: "x", label: "X", value:particleData.x},
							{key: "y", label: "Y", value:particleData.y}
						]
					},
					{
						header: "Emitter",
						children: [
							{key: "emitterType", label: "Type", value: particleData.emitterType},
							{key: "sourcePositionVariancex", label: "X Variance", value: particleData.sourcePositionVariancex},
							{key: "sourcePositionVariancey", label: "Y Variance", value: particleData.sourcePositionVariancey},
						]
					},
					{
						header: "Colors",
						children: [
							{key: "startColor", label: "Start Color", value: particleData.startColor},
							{key: "startColorVariance", label: "Start Color Variance", value: particleData.startColorVariance},
							{key: "finishColor", label: "End Color", value: particleData.finishColor},
							{key: "finishColorVariance", label: "End Color Variance", value: particleData.finishColorVariance}
						]
					},
					{
						header: "Blending",
						children: [
							{key: "blendFuncSource", label: "Start", value: particleData.blendFuncSource},
							{key: "blendFuncDestination", label: "End", value: particleData.blendFuncDestination}
						]
					},
					{
						header: "Gravity",
						children: [
							{key: "gravityx", label: "X Gravity", value: particleData.gravityx},
							{key: "gravityy", label: "Y Gravity", value: particleData.gravityy}
						]
					},
					{
						header: "Lifetime",
						children: [
							{key: "particleLifespan", label: "Lifespan", value: particleData.particleLifespan},
							{key: "particleLifespanVariance", label: "Lifespan Variance", value: particleData.particleLifespanVariance}
						]
					},
					{
						header: "Size",
						children: [
							{key: "startParticleSize", label: "Start", value: particleData.startParticleSize},
							{key: "startParticleSizeVariance", label: "Start Variance", value: particleData.startParticleSizeVariance},
							{key: "finishParticleSize", label: "End", value: particleData.finishParticleSize},
							{key: "finishParticleSizeVariance", label: "End Variance", value: particleData.finishParticleSizeVariance},
						]
					},
					{
						header: "Angle",
						children: [
							{key: "angle", label: "Angle", value: particleData.angle},
							{key: "angleVariance", label: "Angle Variance", value: particleData.angleVariance},
						]
					},
					{
						header: "Rotation",
						children: [
							{key: "rotationStart", label: "Start", value: particleData.rotationStart},
							{key: "rotationStartVariance", label: "Start Variance", value: particleData.rotationStartVariance},
							{key: "rotationEnd", label: "End", value: particleData.rotationEnd},
							{key: "rotationEndVariance", label: "End Variance", value: particleData.rotationEndVariance},
						]
					},
					{
						header: "Speed",
						children: [
							{key: "speed", label: "Speed", value: particleData.speed},
							{key: "speedVariance", label: "Speed Variance", value: particleData.speedVariance},
						]
					},
					{
						header: "Acceleration",
						children: [
							{key: "radialAcceleration", label: "Radial", value: particleData.radialAcceleration},
							{key: "radialAccelVariance", label: "Radial Variance", value: particleData.radialAccelVariance},
							{key: "tangentialAcceleration", label: "Tangential", value: particleData.tangentialAcceleration},
							{key: "tangentialAccelVariance", label: "Tangential Variance", value: particleData.tangentialAccelVariance},
						]
					},
				]
			)
		}
	}
}