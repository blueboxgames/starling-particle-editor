package com.grantech.models
{
	import starling.textures.Texture;

	public class ImageDataModel extends LayerDataModel
	{
		public function ImageDataModel()
		{
			super();
			this.texture = Texture.fromBitmap(new ParticleDataModel.defaultBitmap()) as Texture;
		}
	}
}