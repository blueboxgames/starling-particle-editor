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
							{key: "emitterXVariance", text: "X Variance", value: particleData.emitterXVariance},
							{key: "emitterYVariance", text: "Y Variance", value: particleData.emitterYVariance},
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
							{key: "blendFactorSource", text: "Start", value: particleData.blendFactorSource},
							{key: "blendFactorDestination", text: "End", value: particleData.blendFactorDestination}
						]
					},
					{
						header: "Gravity",
						children: [
							{key: "gravityX", text: "X Gravity", value: particleData.gravityX},
							{key: "gravityY", text: "Y Gravity", value: particleData.gravityY}
						]
					},
					{
						header: "Lifetime",
						children: [
							{key: "lifespan", text: "Lifespan", value: particleData.lifespan},
							{key: "lifespanVariance", text: "Lifespan Variance", value: particleData.lifespanVariance}
						]
					},
					{
						header: "Size",
						children: [
							{key: "startSize", text: "Start", value: particleData.startSize},
							{key: "startSizeVariance", text: "Start Variance", value: particleData.startSizeVariance},
							{key: "endSize", text: "End", value: particleData.endSize},
							{key: "endSizeVariance", text: "End Variance", value: particleData.endSizeVariance},
						]
					},
					{
						header: "Angle",
						children: [
							{key: "emitAngle", text: "Angle", value: particleData.emitAngle},
							{key: "emitAngleVariance", text: "Angle Variance", value: particleData.emitAngleVariance},
						]
					},
					{
						header: "Rotation",
						children: [
							{key: "startRotation", text: "Start", value: particleData.startRotation},
							{key: "startRotationVariance", text: "Start Variance", value: particleData.startRotationVariance},
							{key: "endRotation", text: "End", value: particleData.endRotation},
							{key: "endRotationVariance", text: "End Variance", value: particleData.endRotationVariance},
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
							{key: "radialAccelerationVariance", text: "Radial Variance", value: particleData.radialAccelerationVariance},
							{key: "tangentialAcceleration", text: "Tangential", value: particleData.tangentialAcceleration},
							{key: "tangentialAccelerationVariance", text: "Tangential Variance", value: particleData.tangentialAccelerationVariance},
						]
					},
				]
			)
		}
	}
}