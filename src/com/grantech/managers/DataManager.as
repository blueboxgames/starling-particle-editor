package com.grantech.managers
{
	import com.grantech.models.ParticleDataModel;

	import feathers.data.ListCollection;


	public class DataManager
	{
		private static var _instance:DataManager;
		public static function get instance() : DataManager
		{
			if( _instance == null )
				_instance = new DataManager();
				return _instance;
		}
		
		private var _layers:ListCollection;
		public function get layers():ListCollection
		{
			return _layers;
		}
		private var _layerProps:ListCollection;
		public function get layerProps():ListCollection
		{
			return _layerProps;
		}

		public function addNewLayer():void
		{
			var newParticleModel:ParticleDataModel = new ParticleDataModel();
			this.layers.addItem(newParticleModel.defaultParticleModel);
		}

		// TODO:
		// private static const emptyConfig:Object = serializer.readConfig(config:File)
		// private static const defaultTexture:Texture = Texture.fromTexture(new Quad(1,1,0xffffff) as Texture);

		public function DataManager()
		{
			super();
			this._layers = new ListCollection(); 
			this._layerProps = new ListCollection();
		}
	}
}