package com.grantech.models
{
	import feathers.controls.ImageLoader;

	public class ImageDataModel extends LayerDataModel
	{
		public function ImageDataModel()
		{
			super();
			this.initialize();
		}

		protected function initialize():void
		{
			
		}

		public function get source():String
		{
			if(this.getProperty("source")==null)
				return null;
			return this.getProperty("source");
		}

		public function set source(value:String):void
		{
			if(this.getProperty("source") == value)
				return;

			var imageLoader:ImageLoader = new ImageLoader();

			this.setProperty("source", value);
			
			imageLoader.source = value;
			this.setProperty("imageLoader", imageLoader);
		}
	}
}