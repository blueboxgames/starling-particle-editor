package com.grantech.models
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class ControlsHelper
	{
		static public const TYPE_SLIDER:int = 0;
		static public const TYPE_COLOR_PICKER:int = 1;
		static public const TYPE_DROPDOWN:int = 2;
		static public const TYPE_BROWSE:int = 3;
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
			var propFile:File = File.applicationDirectory.resolvePath("config/particle_info.json");
			var propFileStream:FileStream = new FileStream();
			propFileStream.open(propFile, FileMode.READ);
			propertyList = JSON.parse(propFileStream.readUTFBytes(propFileStream.bytesAvailable));
		}

		public function getType(property:String):int
		{
			switch( property )
			{
				case "startColor":
				case "startColorVariance":
				case "finishColor":
				case "finishColorVariance":
					return TYPE_COLOR_PICKER;
					break;
				case "blendFuncSource":
				case "blendFuncDestination":
					return TYPE_DROPDOWN;
					break;
				case "texture":
					return TYPE_BROWSE;
					break;
				default:
					return TYPE_SLIDER;
					break;
			}
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