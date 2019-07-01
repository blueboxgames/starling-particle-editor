package com.grantech.managers
{
	import com.grantech.models.ParticleDataModel;

	import feathers.core.IFeathersEventDispatcher;
	import feathers.data.ListCollection;

	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * Dispatched when a layer is added.
	 * @eventType starling.events.Event.ADDED
	 */
	[Event(name="added",type="starling.events.Event")]

	/**
	 * Dispatched when a layer is selected.
	 * @eventType starling.events.Event.SELECT
	 */
	[Event(name="select",type="starling.events.Event")]

	/**
	 * Dispatched when a layer is removed.
	 * @eventType starling.events.Event.REMOVED
	 */
	[Event(name="removed",type="starling.events.Event")]

	/**
	 * Manager for layers data.
	 */
	public class DataManager extends EventDispatcher implements IFeathersEventDispatcher
	{
		/**
		 * @private Variable which contains DataManager singleton.
		 */
		private static var _instance:DataManager;

		/**
		 * DataManager singleton access method.
		 */
		public static function get instance() : DataManager
		{
			if( _instance == null )
				_instance = new DataManager();
				return _instance;
		}

		/**
		 * @private Variable which contains current layer index.
		 */
		private var _currentLayerIndex:int;

		/**
		 * Method to get current layer index.
		 */
		public function get currentLayerIndex():int
		{
			return this._currentLayerIndex;
		}

		/**
		 * Method to set current layer index.
		 */
		public function set currentLayerIndex(index:int):void
		{
			if( this._currentLayerIndex == index )
				return;
			this.inspector.removeAll();

			if( this._currentLayerIndex >= 0 && this._currentLayerIndex < this.layers.length )
			{
				this._currentLayerIndex = index;
				for(var key:String in layerAt(this._currentLayerIndex))
				{
					this.inspector.addItem({
						label: key,
						value: layerAt(this._currentLayerIndex).getProperty(key)
					});
				}
			}

			DataManager.instance.dispatchEventWith(Event.SELECT, false, {index: index});
		}

		/**
		 * Method to return layer at specified index.
		 */
		public function layerAt(index:int):Object
		{
			return layers.getItemAt(index);
		}

		/**
		 * @private Layers ListCollection data structure.
		 */
		private var _layers:ListCollection;

		/**
		 * Available layers data structure.
		 */
		public function get layers():ListCollection
		{
			return _layers;
		}

		private var _idHolder:int;

		protected function genNewLayerId():int
		{
			return this._idHolder += 1;
		}

		/**
		 * Method to add new layer.
		 */
		public function addLayer(name:String=null, x:Number=0, y:Number=0):void
		{
			var particleModel:ParticleDataModel = new ParticleDataModel();
			particleModel.id = genNewLayerId();
			particleModel.name = name ? name : "";
			particleModel.x = x;
			particleModel.y = y;
			particleModel.order = this.layers.length; // means it's the last item in list.

			var particleID:int = particleModel.id;
			this.layers.addItem(particleModel);
			
			DataManager.instance.dispatchEventWith(Event.ADDED, false, particleModel);
		}

		/**
		 * Method to select layer with index.
		 */
		public function selectLayerAt(index:int):void
		{
			this.currentLayerIndex = index;
			DataManager.instance.dispatchEventWith(Event.SELECT, false, { index: index} );
		}

		// /**
		//  * Returns a layer data by id.
		//  */
		// public function getLayerById(id:int):Object
		// {
		// 	return this.layers.data;
		// }

		/**
		 * Method to remove layer with reference.
		 */
		public function removeLayer(layer:Object):void
		{
			var indexValue:int = this.layers.getItemIndex(layer);
			DataManager.instance.dispatchEventWith(Event.REMOVED, false, { index: indexValue });
			this.layers.removeItem(layer);
		}

		/**
		 * Method to remove layer with index.
		 */
		public function removeLayerAt(index:int):void
		{
			DataManager.instance.dispatchEventWith(Event.REMOVED, false, { index: index });
			this.layers.removeItemAt(index);
		}

		/**
		 * @private Inspector ListCollection data structure. 
		 */
		private var _inspector:ListCollection;

		/**
		 * Avilable inspectors data structure.
		 */
		public function get inspector():ListCollection
		{
			return _inspector;
		}

		/**
		 * Constructor.
		 */
		public function DataManager()
		{
			super();
			this._idHolder = -1;
			this._currentLayerIndex = -1;
			this._layers = new ListCollection(); 
			this._inspector = new ListCollection();
		}
	}
}