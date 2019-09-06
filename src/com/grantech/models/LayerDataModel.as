package com.grantech.models
{
	import feathers.data.ArrayHierarchicalCollection;

	import starling.textures.Texture;

	public class LayerDataModel extends SerializableDataModel
	{
		static public const TYPE_IMAGE:int = 0; 
		static public const TYPE_PARTICLE:int = 1;

		private var _id:int;
		private var _type:int;
		private var _name:String;
		private var _order:Number;
		private var _texture:Texture;

		public function LayerDataModel() { super(); }

		/**
		 * Layer Id must be unique and must not be duplicated.
		 * TODO: Handle duplicate id issue.
		 */
		public function get id():int { return this._id; }
		public function set id(value:int):void { this._id = value; }

		public function get type():int { return this._type; }
		public function set type(value:int):void { this._type = value; }

		public function get name():String { return this._name; }
		public function set name(value:String):void { this._name = value; }

		public function get order():int { return this._order; }
		public function set order(value:int):void { this._order = value; }

		public function get texture():Texture { return this._texture; }
		public function set texture(value:Texture):void { this._texture =  value; }

		/**
		 * properties
		 */
		public function get x():Number { return this.getProperty("x"); }
		public function set x(value:Number):void { this.setProperty("x", value); }

		public function get y():Number { return this.getProperty("y"); }
		public function set y(value:Number):void { this.setProperty("y", value); }

		public function get alpha():Number { return this.getProperty("alpha"); }
		public function set alpha(value:Number):void { this.setProperty("alpha", value); }

		public function get scaleX():Number { return this.getProperty("scaleX"); }
		public function set scaleX(value:Number):void { this.setProperty("scaleX", value); }

		public function get scaleY():Number { return this.getProperty("scaleY"); }
		public function set scaleY(value:Number):void { this.setProperty("scaleY", value); }
		
		public function getHierarchicalCollection():ArrayHierarchicalCollection
		{
			var ret:ArrayHierarchicalCollection = new ArrayHierarchicalCollection();
			for each(var key:String in ControlsHelper.instance.keys)
			{
				if( !this.hasOwnProperty(key) )
					continue;
				var type:String = ControlsHelper.instance.getType(key);
				var header:String = ControlsHelper.instance.getGroup(key);
				var index:int = this.getHeader(header, ret);
				if (index > -1)
					ret.getItemAt(index).children.push({label:key, type:type});
				else
					ret.addItemAt({header:header, children:[{label:key, type:type}]}, ret.getLength())
			}
			return ret;
		}
		private function getHeader(header:String, collection:ArrayHierarchicalCollection):int
		{
			var len:int = collection.getLength();
			for( var i:int = 0; i < len; i++ )
				if( collection.getItemAt(i).header == header )
				return i;
			return -1;
		}
	}
}