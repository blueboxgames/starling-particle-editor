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

		public function get texture():Texture { return this.getProperty("texture"); }
		public function set texture(value:Texture):void { this.setProperty("source", value); }
	}
}