package com.grantech.models
{
	public class LayerDataModel extends SerializableDataModel
	{
		// private var _id:int;
		private var _name:String;
		// private var _x:Number;
		// private var _y:Number;
		private var _order:Number;

		public function LayerDataModel()
		{
			super();
		}

		/**
		 * Returns current layer id.
		 */
		public function get id():int
		{
			return this.getProperty("id");
		}

		/**
		 * Sets current layer id.
		 * Layer Id must be unique and must not be duplicated.
		 * 
		 * TODO: Handle duplicate id issue.
		 */
		public function set id(value:int):void
		{
			this.setProperty("id", value);
		}

		public function get name():String
		{
			return this._name;
		}

		public function set name(value:String):void
		{
			this._name = value;
		}

		public function get x():Number
		{
			return this.getProperty("x");
		}

		public function set x(value:Number):void
		{
			this.setProperty("x", value);
		}

		public function get y():Number
		{
			return this.getProperty("y");
		}

		public function set y(value:Number):void
		{
			this.setProperty("y", value);
		}

		public function get order():Number
		{
			return this._order;
		}

		public function set order(value:Number):void
		{
			this._order = value;
		}
	}
}