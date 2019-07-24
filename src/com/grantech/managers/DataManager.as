package com.grantech.managers
{
	import com.grantech.models.ImageDataModel;
	import com.grantech.models.LayerDataModel;
	import com.grantech.models.ParticleDataModel;

	import feathers.core.IFeathersEventDispatcher;
	import feathers.data.ArrayHierarchicalCollection;
	import feathers.data.IHierarchicalCollection;
	import feathers.data.ListCollection;

	import flash.filesystem.File;

	import starling.events.Event;
	import starling.events.EventDispatcher;
	import flash.utils.Dictionary;

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
	 * Dispatched when a data is changed.
	 * @eventType starling.events.Event.CHANGE
	 */
	[Event(name="change",type="starling.events.Event")]

	/**
	 * Dispatched when a two layers are swaped.
	 * @eventType "swap"
	 */
	[Event(name="swap",type="starling.events.Event")]

	/**
	 * Manager for layers data.
	 */
	public class DataManager extends EventDispatcher implements IFeathersEventDispatcher
	{
		public static const PARTICLE_DATA:String = "particle";
		public static const IMAGE_DATA:String = "image";
		/**
		 * @private Variable which contains DataManager singleton.
		 */
		private static var _instance:DataManager;
		
		/**
		 * @private Unique identifier for new data.
		 */
		
		
		/**
		 * DataManager singleton access method.
		 */
		public static function get instance():DataManager
		{
			if( _instance == null )
				_instance = new DataManager();
				return _instance;
		}

		/**
		 * Constructor.
		 */
		public function DataManager()
		{
			super();
			this._uid = 0;
			this._layerDataProvider = new ListCollection();
			this._inspectorComponentCollection = new ArrayHierarchicalCollection();
			this._layerDataProvider.sortCompareFunction = orderFunction;
		}

		private var _uid:int;
		public function get uid():int
		{
			return _uid;
		}
		
		public function set uid(value:int):void
		{
			_uid = value;
		}

		private var _layerDataProvider:ListCollection;
		public function get layerDataProvider():ListCollection
		{
			return _layerDataProvider;
		}

		private var _inspectorComponentCollection:ArrayHierarchicalCollection;
		public function get inspectorComponentCollection():IHierarchicalCollection
		{
			return _inspectorComponentCollection;
		}

		private var _currentModel:Object;
		
		public function get currentModel():Object
		{
			return _currentModel;
		}
		
		public function set currentModel(value:Object):void
		{
			_currentModel = value;
		}

		/**
		 * Method to add new layer.
		 */
		public function addLayer(type:String, name:String=null, x:Number=0, y:Number=0, order:Number=0):void
		{
			if (type == PARTICLE_DATA)
			{
				// Create new particle model.
				var model:ParticleDataModel = new ParticleDataModel();
				model.id = this.uid+=1;
				model.type = type;
				model.name = name;
				model.x = x;
				model.y = y;
				model.order = order;
				
				// Add model to list.
				this.layerDataProvider.addItem(model);
				// Dispatch Event.
				DataManager.instance.dispatchEventWith(Event.ADDED, false, { particle: model });
			}
			else if (type == IMAGE_DATA)
			{}
		}

		/**
		 * Method to select layer with it's object.
		 */
		public function selectLayer(model:Object):void
		{
			var index:int = this.layerDataProvider.getItemIndex(model);
			this.selectLayerAt(index);
		}

		/**
		 * Method to select layer with index.
		 */
		public function selectLayerAt(index:int):void
		{
			this.currentModel = this.layerDataProvider.getItemAt(index);
			DataManager.instance.dispatchEventWith(Event.SELECT, false, { index: index });
		}

		/**
		 * Method to remove layer with it's object.
		 */
		public function removeLayer(layer:Object):void
		{
			var index:int = this.layerDataProvider.getItemIndex(layer);
			this.removeLayerAt(index);
		}

		/**
		 * Method to remove layer with it's index.
		 */
		public function removeLayerAt(index:int):void
		{
			DataManager.instance.dispatchEventWith(Event.REMOVED, true, { index: index });
			this.layerDataProvider.removeItemAt(index);
			// Must handle this at both list and it's collection.
		}

		public function raiseLayerAt(index:int):void
		{
			var layer:LayerDataModel = this.layerDataProvider.getItemAt(index) as LayerDataModel;
			if(index == 0)
				return;
			var higherLayer:LayerDataModel = this.layerDataProvider.getItemAt(index-1) as LayerDataModel;
			var tmp:int = layer.order;
			layer.order = higherLayer.order;
			higherLayer.order = tmp;
			this._layerDataProvider.refresh();
			this._layerDataProvider.updateAll();
			DataManager.instance.dispatchEventWith("swap", false, {a: this.layerDataProvider.getItemAt(index).id, b:this.layerDataProvider.getItemAt(index-1).id});
		}
		
		public function lowerLayerAt(index:int):void
		{
			var layer:LayerDataModel = this.layerDataProvider.getItemAt(index) as LayerDataModel;
			if(index == this.layerDataProvider.length-1)
			{
				return;
			}
			var lowerLayer:LayerDataModel = this.layerDataProvider.getItemAt(index+1) as LayerDataModel;
			var tmp:int = layer.order;
			layer.order = lowerLayer.order;
			lowerLayer.order = tmp
			layer.order = lowerLayer.order-1;
			this._layerDataProvider.refresh();
			this._layerDataProvider.updateAll();
			DataManager.instance.dispatchEventWith("swap", false, {a: this.layerDataProvider.getItemAt(index).id, b:this.layerDataProvider.getItemAt(index+1).id});
		}

		public function orderFunction(a:Object, b:Object):int
		{
			if (a.order > b.order)
			{
				return -1;
			}
			else if (a.order < b.order)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
	}
}