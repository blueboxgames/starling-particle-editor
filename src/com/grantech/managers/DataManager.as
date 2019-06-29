package com.grantech.managers
{
	import com.grantech.models.ParticleDataModel;

	import feathers.core.IFeathersEventDispatcher;
	import feathers.data.ListCollection;

	import starling.events.EventDispatcher;
	import starling.events.Event;


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
			this.addEventListener("particleLayerChange", dataManager_particleLayerChangeHandler);
			this.addEventListener("particleDataChanged", dataManager_particleDataChangeHandler);

			this._selectedLayer = -1;
			this._layers = new ListCollection(); 
			this._inspector = new ListCollection();
		}

		protected function dataManager_particleLayerChangeHandler(event:Event):void
		{
			this._selectedLayer = event.data.selectedLayer;
			this.inspector.removeAll();
			if(selectedLayer == -1)
				return;
			for(var key:String in layers.getItemAt(selectedLayer).properties)
			{
				this.inspector.addItem({label: key, value: layers.getItemAt(selectedLayer).getProperty(key)});
			}
		}

		protected function dataManager_particleDataChangeHandler(event:Event):void
		{
			layers.getItemAt(selectedLayer).setProperty(event.data.label, event.data.value);
		}
	}
}