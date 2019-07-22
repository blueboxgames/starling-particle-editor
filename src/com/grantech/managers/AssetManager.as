package com.grantech.managers
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;
	import starling.textures.Texture;
	import flash.utils.Dictionary;
	import starling.events.EventDispatcher;

	public class AssetManager extends EventDispatcher
	{
		private static var _instance:AssetManager;
		
		private var _textures:Dictionary;

		public static function get instance():AssetManager
		{
			if( _instance == null )
				_instance = new AssetManager();
				return _instance;
		}

		public function AssetManager()
		{
			super();
			this._textures = new Dictionary();
		}

		public function load(url:String):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, assetLoader_completeHandler);
			try {
				loader.load(new URLRequest(url));
			}
			catch(e:Error)
			{}
			return;
		}

		protected function assetLoader_completeHandler(e:Event):void
		{
			try
			{
				var loader:Loader = e.currentTarget.loader as Loader;
				var url:String = loader.contentLoaderInfo.url;
				var bitmap:Bitmap = loader.content as Bitmap;
				this._textures[url] = Texture.fromBitmap(bitmap);
				this.dispatchEventWith(Event.COMPLETE);
			}
			catch(e:Error)
			{}
		}

		public function getTexture(url:String):Texture
		{
			return this._textures[url];
		}
	}
}