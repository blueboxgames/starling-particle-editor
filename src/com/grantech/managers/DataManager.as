package com.grantech.managers
{
	import com.grantech.models.ParticleDataModel;

	import feathers.core.IFeathersEventDispatcher;
	import feathers.data.ListCollection;

	import starling.events.EventDispatcher;


	public class DataManager extends EventDispatcher implements IFeathersEventDispatcher
	{
		private static var _instance:DataManager;
		public static function get instance() : DataManager
		{
			if( _instance == null )
				_instance = new DataManager();
				return _instance;
		}
		
		private var _selectedLayer:int;
		public function get selectedLayer():int
		{
			return _selectedLayer;
		}
		
		private var _layers:ListCollection;
		public function get layers():ListCollection
		{
			return _layers;
		}
		private var _inspector:ListCollection;
		public function get inspector():ListCollection
		{
			return _inspector;
		}

		public function addNewLayer():void
		{
			this.layers.addItem(new ParticleDataModel());
		}

		public function DataManager()
		{
			super();
			this._layers = new ListCollection(); 
			this._inspector = new ListCollection();
			this._selectedLayer = -1;
		} 
	}
}