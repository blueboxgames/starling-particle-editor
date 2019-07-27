package com.grantech.models
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class ControlsHelper
	{
		static public const TYPE_BUTTON:String = "button";
		static public const TYPE_SLIDER:String = "slider";
		static public const TYPE_COMBO_BOX:String = "combo";
		static public const TYPE_COLOR_PICKER:String = "color";
		public function ControlsHelper()
		{
			super();
		}
		private static var _instance:ControlsHelper;

		/**
		 * ControlsHelper singleton access method.
		 */
		public static function get instance() : ControlsHelper
		{
			if( _instance == null )
			{
				_instance = new ControlsHelper();
				_propertyList = new Object();
				init();
			}
			
			return _instance;
		}

		private static var _propertyList:Object;

		public static function get propertyList() : Object
		{
			return _propertyList;
		}

		public static function set propertyList(value:Object):void
		{
			_propertyList = value;
		}

		private static function init():void
		{
			var propFile:File = File.applicationDirectory.resolvePath("config/ui-design-helper.json");
			var propFileStream:FileStream = new FileStream();
			propFileStream.open(propFile, FileMode.READ);
			propertyList = JSON.parse(propFileStream.readUTFBytes(propFileStream.bytesAvailable));
		}

		public function getGroup(property:String):String
		{
			if( propertyList.hasOwnProperty(property) )
				return propertyList[property].group;
			return "basic";
		}

		public function getType(property:String):String
		{
			if( propertyList.hasOwnProperty(property) )
				return propertyList[property].control;
			return TYPE_SLIDER;
		}

		public function getData(property:String):Object
		{
			if( propertyList.hasOwnProperty(property) )
				return propertyList[property].data;
			return null;
		}
	
		public function getMin(property:String):Number
		{
			var value:Number = -10000;			
			value = propertyList[property] ? propertyList[property].min : NaN;
			return value;
		}

		public function getMax(property:String):Number
		{
			var value:Number = -10000;			
			value = propertyList[property] ? propertyList[property].max : NaN;
			return value;
		}

		public function getStep(property:String):Number
		{
			var value:Number = -10000;			
			value = propertyList[property] ? propertyList[property].step : NaN;
			return value;
		}
	}
}