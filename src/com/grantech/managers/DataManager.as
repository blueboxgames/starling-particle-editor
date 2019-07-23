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
		public static const PARTICLE_LAYER:String = "particle";
		public static const IMAGE_LAYER:String = "image";
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
			// New selected layer causes removing all inspector items.

			// Index range is out of range. _currentLayerIndex range: [-1, int.MAX_VALUE]
			if(index < -1)
				return;

			this._currentLayerIndex = index;
			var itemAtCurrent:Object = layerComponentCollection.getItemAt(index);

			if(this._currentLayerIndex > -1)
			{
				this._inspectorComponentCollection.arrayData = itemAtCurrent.propertiesCollection.arrayData;
			}
			this.inspectorComponentCollection.updateAll();
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
			return layerComponentCollection.getItemAt(index);
		}

		private var _idHolder:int;

		protected function genNewLayerId():int
		{
			return this._idHolder += 1;
		}

		/**
		 * Method to add new layer.
		 */
		public function addLayer(type:String, name:String=null, x:Number=0, y:Number=0, order:Number=0):void
		{
			/**
			 * Algorithm addLayer:
			 * switch case (particle? image?)
			 * -> create new `model`.
			 * -> add model to a ListCollection.
			 * -> incerement layercount.
			 * Event -> ADDED, `model`
			 * 
			 * Call -> selectLayer(model)
			 */
			
			var model:LayerDataModel = new LayerDataModel();
			model.id = genNewLayerId();
			model.name = name ? name : "";
			model.x = x;
			model.y = y;
			model.type = type;
			model.order = _layerComponentCollection.length == 0 ? 0 : this._layerComponentCollection.getItemAt(0).order+1;

			if (type == PARTICLE_LAYER)
			{
				// Create new particle model.
				var pModel:ParticleDataModel = new ParticleDataModel();
				pModel.id = model.id;
				pModel.name = model.name;
				pModel.x = model.x;
				pModel.y = model.y;
				pModel.order = model.order;
				pModel.type = model.type;
				// Add model to list.
				this.layerComponentCollection.addItemAt(pModel, 0);
				// Increment layer count.
				this._currentLayerIndex += 1;
				this._layerCount += 1;
				this._layerComponentCollection.updateAll();
				this._inspectorComponentCollection.updateAll();
				// Dispatch Event.
				DataManager.instance.dispatchEventWith(Event.ADDED, false, { particle: pModel });
			}
			else if (type == IMAGE_LAYER)
			{
				var iModel:ImageDataModel = new ImageDataModel();
				iModel.id = model.id;
				iModel.name = model.name;
				iModel.x = model.x;
				iModel.y = model.y;
				iModel.order = model.order;
				iModel.type = model.type;
				// Add model to list.	
				this.layerComponentCollection.addItemAt(iModel, this.currentLayerIndex+1);
				// Increment layer count.
				this._layerCount += 1;
				this._currentLayerIndex += 1;
				this._layerComponentCollection.updateAll();
				this._inspectorComponentCollection.updateAll();
				// Dispatch Event.
				
				DataManager.instance.dispatchEventWith(Event.ADDED, false, { image: iModel });
			}
			// Call to select layer.
			this.currentLayerIndex = 0;
			this.selectLayerAt(this.currentLayerIndex);
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
			var index:int = this.layerComponentCollection.getItemIndex(model);
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
			this.currentLayerIndex = index;
			DataManager.instance.dispatchEventWith(Event.SELECT, false, { index: index } );
		}

		/**
		 * Method to remove layer with it's object.
		 */
		public function removeLayer(layer:Object):void
		{
			var index:int = this.layerComponentCollection.getItemIndex(layer);
			this.removeLayerAt(index);
		}

		/**
		 * Method to remove layer with it's index.
		 */
		public function removeLayerAt(index:int):void
		{
			if (this.layerCount == 0)
				return;
			
			DataManager.instance.dispatchEventWith(Event.REMOVED, true, { index: index });
			this.inspectorComponentCollection.removeAll();
			this.layerComponentCollection.removeItemAt(index);
			this._layerCount -= 1;
			// Must handle this at both list and it's collection.
			if(index >= 0)
			{
				this.currentLayerIndex = index - 1;
			}
		}

		public function editCurrentLayerData(key:String, value:*):void
		{
			layerAt(this.currentLayerIndex).setProperty(key, value);
		}

		// -----------------------------------------------------------------------------------------------------------
		private var _layerComponentCollection:ListCollection;
		public function get layerComponentCollection():ListCollection
		{
			return _layerComponentCollection;
		}
		private var _inspectorComponentCollection:ArrayHierarchicalCollection;
		public function get inspectorComponentCollection():IHierarchicalCollection
		{
			return _inspectorComponentCollection;
		}
		// -----------------------------------------------------------------------------------------------------------

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

		public function raiseLayerAt(index:int):void
		{
			var layer:LayerDataModel = this.layerComponentCollection.getItemAt(index) as LayerDataModel;
			if(index == 0)
				return;
			var higherLayer:LayerDataModel = this.layerComponentCollection.getItemAt(index-1) as LayerDataModel;
			var tmp:int = layer.order;
			layer.order = higherLayer.order;
			higherLayer.order = tmp;
			this._layerComponentCollection.refresh();
			this._layerComponentCollection.updateAll();
			DataManager.instance.dispatchEventWith("swap", false, {a: this.layerComponentCollection.getItemAt(index).id, b:this.layerComponentCollection.getItemAt(index-1).id});
		}
		
		public function lowerLayerAt(index:int):void
		{
			var layer:LayerDataModel = this.layerComponentCollection.getItemAt(index) as LayerDataModel;
			if(index == this.layerComponentCollection.length-1)
			{
				return;
			}
			var lowerLayer:LayerDataModel = this.layerComponentCollection.getItemAt(index+1) as LayerDataModel;
			var tmp:int = layer.order;
			layer.order = lowerLayer.order;
			lowerLayer.order = tmp
			layer.order = lowerLayer.order-1;
			this._layerComponentCollection.refresh();
			this._layerComponentCollection.updateAll();
			DataManager.instance.dispatchEventWith("swap", false, {a: this.layerComponentCollection.getItemAt(index).id, b:this.layerComponentCollection.getItemAt(index+1).id});
		}

		// public function editLayerDataFile(file:File):void
		// {
		// 	var dataModel:ParticleDataModel = layerComponentCollection.getItemAt(currentLayerIndex) as ParticleDataModel;
		// 	dataModel.parseDataFromFile(file);
		// }

		/**
		 * Constructor.
		 */
		public function DataManager()
		{
			super();
			this._idHolder = -1;
			this._layerCount = 0;
			this._currentLayerIndex = -1;
			
			this._layerComponentCollection = new ListCollection();
			this._layerComponentCollection.sortCompareFunction = orderFunction;

			this._inspectorComponentCollection = new ArrayHierarchicalCollection();
		}
	}
}