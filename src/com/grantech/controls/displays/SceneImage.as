package com.grantech.controls.displays
{
  import com.grantech.models.ImageDataModel;
  import com.grantech.models.LayerDataModel;

  import starling.display.Image;

  public class SceneImage extends Image implements ISceneObject
  {
    public function SceneImage(layer:LayerDataModel)
    {
      super(ImageDataModel(layer).texture);
			this.layer = layer;
		}
		
		private var _layer:LayerDataModel;
		public function get layer():LayerDataModel { return this._layer; }
		public function set layer(value:LayerDataModel):void { this._layer = value; }
		public function hasOwnProperty(V:*):Boolean { return super.hasOwnProperty(V); }

  }
}