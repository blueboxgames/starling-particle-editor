package com.grantech.models
{
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
			if (this.getProperty(key) == value)
			{
				return;
			}
			this._properties[key] = value;
			this.dispatchEventWith(Event.CHANGE, false, key);
		}
		
		/**
		 * Constructor
		 */
		public function SerializableDataModel()
		{
			super();
			this._properties = new Dictionary();
		} 
	}
}