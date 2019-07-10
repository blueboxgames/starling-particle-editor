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
	 * Dispatched when a data is changed.
	 * @eventType starling.events.Event.CHANGE
	 */
	[Event(name="change",type="starling.events.Event")]

	/**
	 * Manager for layers data.
	 */
	public class DataManager extends EventDispatcher implements IFeathersEventDispatcher
	{
		/**
		 * For sanity check only
		 */
		public const MAXIMUM_LAYER_COUNT:int = 100;
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

			// New selected layer causes removing all inspector items.
			this.inspector.removeAll();

			// Index range is out of range. _currentLayerIndex range: [-1, int.MAX_VALUE]
			if(index < -1)
				return;

			this._currentLayerIndex = index;
			if(this._currentLayerIndex > -1)
			{
				var layerProps:ParticleDataModel = layers.getItemAt(index) as ParticleDataModel;
				for(var key:String in layerProps.properties)
				{
					// TODO: do something about this
					if(key != 'id' && key != 'name' && key != 'order' && key != 'x' && key != 'y' && key != 'maxParticles')
					{
						this.inspector.addItem({key:key , value:layerProps.properties[key]});
					}
				}
			}
		}

		private var _layerCount:int;

		public function get layerCount():int
		{
			return this._layerCount;
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
		public function addLayer(name:String=null, x:Number=0, y:Number=0, order:Number=0):void
		{
			/**
			 * Algorithm addLayer:
			 * if layersCount > maximumLayerCount then
			 * 	throw range error
			 * 
			 * -> create new `model`.
			 * -> add model to a ListCollection.
			 * -> incerement layercount.
			 * Event -> ADDED, `model`
			 * 
			 * Call -> selectLayer(model)
			 */

			if(this._layerCount > MAXIMUM_LAYER_COUNT)
				throw new RangeError("New layer exceedes maximum layer count.");

			// Create new particle model.
			var particleModel:ParticleDataModel = new ParticleDataModel();
			particleModel.id = genNewLayerId();
			particleModel.name = name ? name : "";
			particleModel.x = x;
			particleModel.y = y;
			particleModel.order = order;

			// Add model to list.
			this.layers.addItemAt(particleModel, this.currentLayerIndex+1);
			// Increment layer count.
			this._layerCount += 1;
			// Dispatch Event.
			DataManager.instance.dispatchEventWith(Event.ADDED, false, particleModel);

			// Call to select layer.
			this.selectLayer(particleModel);
		}

		/**
		 * Method to select layer with it's object.
		 */
		public function selectLayer(model:Object):void
		{
			/**
			 * Algorithm selectLayer:
			 * -> get index of model.
			 * Call -> selectLayerAt(index)
			 */
			var index:int = this.layers.getItemIndex(model);
			this.selectLayerAt(index);
		}

		/**
		 * Method to select layer with index.
		 */
		public function selectLayerAt(index:int):void
		{
			/**
			 * Algorithm selectLayerAt:
			 * if (new index == current index) or (new index < 0) then
			 * 	halt;
			 * 
			 * Set -> currentLayerIndex to new index
			 * Event -> SELECT, currentLayerIndex
			 */
			if (this.currentLayerIndex == index || index < 0 )
				return;
			this.currentLayerIndex = index;
			DataManager.instance.dispatchEventWith(Event.SELECT, false, { index: index } );
		}

		/**
		 * Method to remove layer with it's object.
		 */
		public function removeLayer(layer:Object):void
		{
			var index:int = this.layers.getItemIndex(layer);
			this.removeLayerAt(index);
		}

		/**
		 * Method to remove layer with it's index.
		 */
		public function removeLayerAt(index:int):void
		{
			if (this.layerCount == 0)
				return;

			DataManager.instance.dispatchEventWith(Event.REMOVED, false, { index: index });
			this.layers.removeItemAt(index);
			this._layerCount -= 1;
			// Must handle this at both list and it's collection.
			if(index >= 0)
			{
				this.currentLayerIndex = index - 1;
			}
		}

		public function editCurrentLayerData(key:String, value:*):void
		{
			layerAt(currentLayerIndex).setProperty(key, value);
			DataManager.instance.dispatchEventWith(Event.CHANGE, false, { key: key, value: value });
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

		private function orderFunction(a:Object, b:Object):int
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

		private var _zIndex:Number;

		/**
		 * Constructor.
		 */
		public function DataManager()
		{
			super();
			this._idHolder = -1;
			this._layerCount = 0;
			this._zIndex = 0;
			this._currentLayerIndex = -1;
			this._layers = new ListCollection(); 
			this._inspector = new ListCollection();

			this._layers.sortCompareFunction = orderFunction;
		}
	}
}