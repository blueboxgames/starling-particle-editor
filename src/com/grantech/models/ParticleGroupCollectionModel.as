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
							{key: "texture", text: "Texture", value: particleData.texture}
						]
					},
					{
						header: "Position", 
						children: [
							{key: "x", text: "X", value:particleData.x},
							{key: "y", text: "Y", value:particleData.y}
						]
					},
					{
						header: "Emitter",
						children: [
							{key: "emitterType", text: "Type", value: particleData.emitterType},
							{key: "sourcePositionVariancex", text: "X Variance", value: particleData.sourcePositionVariancex},
							{key: "sourcePositionVariancey", text: "Y Variance", value: particleData.sourcePositionVariancey},
						]
					},
					{
						header: "Colors",
						children: [
							{key: "startColor", text: "Start Color", value: particleData.startColor},
							{key: "startColorVariance", text: "Start Color Variance", value: particleData.startColorVariance},
							{key: "finishColor", text: "End Color", value: particleData.finishColor},
							{key: "finishColorVariance", text: "End Color Variance", value: particleData.finishColorVariance}
						]
					},
					{
						header: "Blending",
						children: [
							{key: "blendFuncSource", text: "Start", value: particleData.blendFuncSource},
							{key: "blendFuncDestination", text: "End", value: particleData.blendFuncDestination}
						]
					},
					{
						header: "Gravity",
						children: [
							{key: "gravityx", text: "X Gravity", value: particleData.gravityx},
							{key: "gravityy", text: "Y Gravity", value: particleData.gravityy}
						]
					},
					{
						header: "Lifetime",
						children: [
							{key: "particleLifespan", text: "Lifespan", value: particleData.particleLifespan},
							{key: "particleLifespanVariance", text: "Lifespan Variance", value: particleData.particleLifespanVariance}
						]
					},
					{
						header: "Size",
						children: [
							{key: "startParticleSize", text: "Start", value: particleData.startParticleSize},
							{key: "startParticleSizeVariance", text: "Start Variance", value: particleData.startParticleSizeVariance},
							{key: "finishParticleSize", text: "End", value: particleData.finishParticleSize},
							{key: "finishParticleSizeVariance", text: "End Variance", value: particleData.finishParticleSizeVariance},
						]
					},
					{
						header: "Angle",
						children: [
							{key: "angle", text: "Angle", value: particleData.angle},
							{key: "angleVariance", text: "Angle Variance", value: particleData.angleVariance},
						]
					},
					{
						header: "Rotation",
						children: [
							{key: "rotationStart", text: "Start", value: particleData.rotationStart},
							{key: "rotationStartVariance", text: "Start Variance", value: particleData.rotationStartVariance},
							{key: "rotationEnd", text: "End", value: particleData.rotationEnd},
							{key: "rotationEndVariance", text: "End Variance", value: particleData.rotationEndVariance},
						]
					},
					{
						header: "Speed",
						children: [
							{key: "speed", text: "Speed", value: particleData.speed},
							{key: "speedVariance", text: "Speed Variance", value: particleData.speedVariance},
						]
					},
					{
						header: "Acceleration",
						children: [
							{key: "radialAcceleration", text: "Radial", value: particleData.radialAcceleration},
							{key: "radialAccelVariance", text: "Radial Variance", value: particleData.radialAccelVariance},
							{key: "tangentialAcceleration", text: "Tangential", value: particleData.tangentialAcceleration},
							{key: "tangentialAccelVariance", text: "Tangential Variance", value: particleData.tangentialAccelVariance},
						]
					},
				]
			)
		}
	}
}