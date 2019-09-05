package com.grantech.managers
{
	import com.grantech.models.ControlsHelper;
	import com.grantech.models.ImageDataModel;
	import com.grantech.models.LayerDataModel;
	import com.grantech.models.ParticleDataModel;

	import feathers.core.IFeathersEventDispatcher;
	import feathers.data.ArrayHierarchicalCollection;
	import feathers.data.IHierarchicalCollection;
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
	 * Dispatched when a two layers are swaped.
	 * @eventType "swap"
	 */
	[Event(name="swap",type="starling.events.Event")]

	/**
	 * Manager for layers data.
	 */
	public class DataManager extends EventDispatcher implements IFeathersEventDispatcher
	{
		/**
		 * @private Variable which contains DataManager singleton.
		 */
		static private var _instance:DataManager;
		
		/**
		 * @private Unique identifier for new data.
		 */
		
		
		/**
		 * DataManager singleton access method.
		 */
		static public function get instance():DataManager
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

		private var _selectedLayer:LayerDataModel;
		public function get selectedlayer():LayerDataModel { return _selectedLayer; }
		public function set selectedlayer(value:LayerDataModel):void { _selectedLayer = value; }

		private var _selectedLayerIndex:int = -1;
		public function get selectedLayerIndex():int { return _selectedLayerIndex; }
		public function set selectedLayerIndex(value:int):void { _selectedLayerIndex = value; }

		/**
		 * Method to add new layer.
		 */
		public function addLayer(type:int):void
		{
			var layer:LayerDataModel;
			// Create new particle model.
			if (type == LayerDataModel.TYPE_PARTICLE)
			{
				layer = new ParticleDataModel() as LayerDataModel;
			}
			else if (type == LayerDataModel.TYPE_IMAGE)
			{
				layer = new ImageDataModel() as LayerDataModel;
			}

			layer.id = this.uid += 1;
			layer.type = type;
			layer.x = ControlsHelper.instance.getInitValue("x");
			layer.y = ControlsHelper.instance.getInitValue("y");
			layer.alpha = ControlsHelper.instance.getInitValue("alpha");
			layer.scaleX = ControlsHelper.instance.getInitValue("scaleX");
			layer.scaleY = ControlsHelper.instance.getInitValue("scaleY");
			layer.order = this.layerDataProvider.length;
			
			// Add model to list.
			this.layerDataProvider.addItem(layer);
			// Dispatch Event.
			dispatchEventWith(Event.ADDED, false, layer);
		}

		/**
		 * Method to select layer with it's object.
		 */
		private function selectLayer(layer:LayerDataModel):void
		{
			var index:int = this.layerDataProvider.getItemIndex(layer);
			this.selectLayerAt(index);
		}

		/**
		 * Method to select layer with index.
		 */
		public function selectLayerAt(index:int):void
		{
			if( index > -1 )
			{
				this.selectedlayer = this.layerDataProvider.getItemAt(index) as LayerDataModel;
				this.selectedlayer.removeEventListeners(Event.CHANGE);
			}
			else
			{
				this.selectedlayer = null;
			}
			this.selectedLayerIndex = index;
			this.dispatchEventWith(Event.SELECT, false, this.selectedLayerIndex);
		}

		/**
		 * Method to remove layer with it's object.
		 */
		public function removeLayer(layer:LayerDataModel):void
		{
			var index:int = this.layerDataProvider.getItemIndex(layer);
			this.removeLayerAt(index);
		}

		/**
		 * Method to remove layer with it's index.
		 */
		public function removeLayerAt(index:int):void
		{
			var layer:LayerDataModel = this.layerDataProvider.getItemAt(index) as LayerDataModel;
			if( layer == null )
			{
				trace("layer not found.");
				return;
			}
			
			this.layerDataProvider.removeItemAt(index);
			this.dispatchEventWith(Event.REMOVED, false, layer);
			selectLayerAt(-1);
		}

		public function shiftTop(index:int):void
		{
			if(index == 0)
				return;
			changeOrder(index, -1);
		}
		
		public function shiftDown(index:int):void
		{
			if(index == this.layerDataProvider.length - 1)
				return;
			changeOrder(index, 1);
		}

		private function changeOrder(index:int, direction:int):void
		{
			var oldLayer:LayerDataModel = this.layerDataProvider.getItemAt(index) as LayerDataModel;
			var newLayer:LayerDataModel = this.layerDataProvider.getItemAt(index + direction) as LayerDataModel;

			var tmp:int = oldLayer.order;
			oldLayer.order = newLayer.order;
			newLayer.order = tmp;

			this.layerDataProvider.refresh();
			selectLayerAt(index + direction);
		}

		private function orderFunction(left:LayerDataModel, right:LayerDataModel):int
		{
			return left.order - right.order;
 		}
	}
}