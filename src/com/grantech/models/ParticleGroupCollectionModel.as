package com.grantech.models
{
	import feathers.data.ArrayHierarchicalCollection;
	import com.grantech.managers.DataManager;

	public class ParticleGroupCollectionModel
	{
		private var _groupModel:ArrayHierarchicalCollection;

		public function get groupModel():ArrayHierarchicalCollection
		{
			return new ArrayHierarchicalCollection(
				[
					{
						header: "Image",
						children: [
							{key: "texture", label: "Texture", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).texture}
						]
					},
					{
						header: "Position", 
						children: [
							{key: "x", label: "X", value: DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).x},
							{key: "y", label: "Y", value: DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).y}
						]
					},
					{
						header: "Emitter",
						children: [
							{key: "emitterType", label: "Type", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).emitterType},
							{key: "sourcePositionVariancex", label: "X Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).sourcePositionVariancex},
							{key: "sourcePositionVariancey", label: "Y Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).sourcePositionVariancey},
						]
					},
					{
						header: "Colors",
						children: [
							{key: "startColor", label: "Start Color", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).startColor},
							{key: "startColorVariance", label: "Start Color Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).startColorVariance},
							{key: "finishColor", label: "End Color", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).finishColor},
							{key: "finishColorVariance", label: "End Color Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).finishColorVariance}
						]
					},
					{
						header: "Blending",
						children: [
							{key: "blendFuncSource", label: "Start", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).blendFuncSource},
							{key: "blendFuncDestination", label: "End", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).blendFuncDestination}
						]
					},
					{
						header: "Gravity",
						children: [
							{key: "gravityx", label: "X Gravity", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).gravityx},
							{key: "gravityy", label: "Y Gravity", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).gravityy}
						]
					},
					{
						header: "Lifetime",
						children: [
							{key: "particleLifespan", label: "Lifespan", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).particleLifespan},
							{key: "particleLifespanVariance", label: "Lifespan Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).particleLifespanVariance}
						]
					},
					{
						header: "Size",
						children: [
							{key: "startParticleSize", label: "Start", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).startParticleSize},
							{key: "startParticleSizeVariance", label: "Start Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).startParticleSizeVariance},
							{key: "finishParticleSize", label: "End", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).finishParticleSize},
							{key: "finishParticleSizeVariance", label: "End Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).finishParticleSizeVariance},
						]
					},
					{
						header: "Angle",
						children: [
							{key: "angle", label: "Angle", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).angle},
							{key: "angleVariance", label: "Angle Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).angleVariance},
						]
					},
					{
						header: "Rotation",
						children: [
							{key: "rotationStart", label: "Start", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).rotationStart},
							{key: "rotationStartVariance", label: "Start Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).rotationStartVariance},
							{key: "rotationEnd", label: "End", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).rotationEnd},
							{key: "rotationEndVariance", label: "End Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).rotationEndVariance},
						]
					},
					{
						header: "Speed",
						children: [
							{key: "speed", label: "Speed", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).speed},
							{key: "speedVariance", label: "Speed Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).speedVariance},
						]
					},
					{
						header: "Acceleration",
						children: [
							{key: "radialAcceleration", label: "Radial", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).radialAcceleration},
							{key: "radialAccelVariance", label: "Radial Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).radialAccelVariance},
							{key: "tangentialAcceleration", label: "Tangential", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).tangentialAcceleration},
							{key: "tangentialAccelVariance", label: "Tangential Variance", value:  DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).tangentialAccelVariance},
						]
					},
				]
			)
		}

		public function ParticleGroupCollectionModel();
		{}
	}
}