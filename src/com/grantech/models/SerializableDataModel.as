package com.grantech.models
{
	import flash.utils.Dictionary;

	import starling.events.EventDispatcher;

	/**
	 * Base Data serializeable class.
	 */
	public class SerializableDataModel extends EventDispatcher
	{
		/**
		 * @private
		 */
		private var _properties:Dictionary;

		/**
		 * Returns current properties dictionary.
		 */
		public function get properties():Dictionary
		{
			return this._properties;
		}

		/**
		 * Sets a value into properties.
		 */
		protected function set properties(value:Dictionary):void
		{
			this._properties = value;
		}

		/**
		 * Constructor
		 */
		public function SerializableDataModel()
		{
			this._properties = new Dictionary();
		}

		/**
		 * Checks if key exists in this dictionary.
		 * @return Boolean
		 */
		public function hasOwnProperty(key:* = null):Boolean
		{
			return this._properties.hasOwnProperty(key);
		}

		/**
		 * Returns a property from dictionary if exists.
		 * @return Dynamic
		 */
		public function getProperty(key:String):*
		{
			if( !this.hasOwnProperty(key) )
			{
				return null;
			}
			return this._properties[key];
		}

		/**
		 * Sets a property in dictionary.
		 */
		public function setProperty(key:String, value:*) : void
		{
			if(this.getProperty(key) == value)
			{
				return;
			}
			this._properties[key] = value;

			// this.dispatchEventWith(Event.CHANGE, false, key);
		}


		/**
		 * +-----------------------------------------------------+
		 * | The Darkside of the code.                           |
		 * +-----------------------------------------------------+
		 */
		/*
		public function getPropertyAsARGB(key:String) : ColorArgb
		{
				if( !properties.hasOwnProperty(key) )
						return null;
				return properties[key] as ColorArgb;
		}
		public function getPropertyAsInt(key:String) : int
		{
				if( !properties.hasOwnProperty(key) )
						return 0;
				return properties[key];
		}
		public function getPropertyAsUint(key:String) : uint
		{
				if( !properties.hasOwnProperty(key) )
						return 0;
				return properties[key];
		}
		public function getPropertyAsFloat(key:String) : Number
		{
				if( !properties.hasOwnProperty(key) )
						return NaN;
				return properties[key];
		}
		public function getPropertyAsBool(key:String) : Boolean
		{
				if( !properties.hasOwnProperty(key) )
						return false;
				return properties[key];
		}
		*/
	}
}