package com.grantech.models
{
	import feathers.data.ArrayHierarchicalCollection;

	import flash.utils.Dictionary;

	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * Base Data serializeable class.
	 */
	public class SerializableDataModel extends EventDispatcher
	{
		protected var _properties:Dictionary;
		public function getProperty(key:String):*
		{
			if( !this._properties.hasOwnProperty(key) )
				return null;
			return this._properties[key];
		}
		public function setProperty(key:String, value:*):void
		{
			if(this.getProperty(key) == value)
			{
				return;
			}
			this._properties[key] = value;
			this.dispatchEventWith(Event.CHANGE, false, key);
		}

		protected function inspectorStructureFactory():ArrayHierarchicalCollection
		{
			return new ArrayHierarchicalCollection();
		}

		protected var _propertiesCollectionFactory:Function;

		public function get propertiesCollectionFactory():Function
		{
			return this._propertiesCollectionFactory
		}

		public function set propertiesCollectionFactory(value:Function):void
		{
			if(this._propertiesCollectionFactory == value)
				return;
			this._propertiesCollectionFactory = value;
		}

		protected var _propertiesCollection:ArrayHierarchicalCollection;
		
		public function get propertiesCollection():ArrayHierarchicalCollection
		{
			return _propertiesCollection;
		}

		/**
		 * Constructor
		 */
		public function SerializableDataModel()
		{
			this._properties = new Dictionary();
			var factory:Function = this._propertiesCollectionFactory != null ? this._propertiesCollectionFactory : inspectorStructureFactory;
			this._propertiesCollection = factory.call();
		}
	}
}