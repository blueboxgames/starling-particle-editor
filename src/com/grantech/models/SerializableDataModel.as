package com.grantech.models
{
	import flash.utils.Dictionary;

	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.extensions.ColorArgb;

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
				return;
			this._properties[key] = value;
			this.dispatchEventWith(Event.CHANGE, false, key);
		}
		
		public function toJson():String
		{
			var ret:String = '{\n"';
			var value:*;
			var quotation:String;
			for(var key:String in _properties)
			{
				if( _properties[key] is String )
					ret += key + '":"' + _properties[key] + '",\n"';
				else if( _properties[key] is ColorArgb )
					ret += key + '":[' + _properties[key].alpha + "," + _properties[key].red + "," + _properties[key].green + "," + _properties[key].blue + '],\n"';
				else
					ret += key + '":' + _properties[key] + ',\n"';
			}		
			return ret.substr(0, ret.length- 3) + '\n}';
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