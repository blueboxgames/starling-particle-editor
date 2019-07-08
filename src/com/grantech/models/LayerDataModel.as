package com.grantech.models
{
	public class LayerDataModel extends SerializableDataModel
	{
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
			return this.setProperty("id", value);
		}

		public function get name():String
		{
			return this.getProperty("name");
		}

		public function set name(value:String):void
		{
			this.setProperty("name", value);
		}

		public function get x():Number
		{
			return this.getProperty("x");
		}

		public function set x(value:Number):void
		{
			return this.setProperty("x", value);
		}

		public function get y():Number
		{
			return this.getProperty("y");
		}

		public function set y(value:Number):void
		{
			return this.setProperty("y", value);
		}

		public function get order():Number
		{
			return this.getProperty("order");
		}

		public function set order(value:Number):void
		{
			this.setProperty("order", value);
		}
	}
}