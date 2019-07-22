package com.grantech.managers
{
	import feathers.core.IFeathersEventDispatcher;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import starling.display.Sprite;
	import starling.events.EventDispatcher;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.display.Image;

	/**
	 * Dispatched when a new `DisplayObject` is added to `SceneManager`.
	 * @eventType starling.events.Event.ADDED
	 */
	[Event(name="added",type="starling.events.Event")]

	/**
	 * Dispatched when a `DisplayObject` is changed.
	 * @eventType starling.events.Event.CHANGE
	 */
	[Event(name="change",type="starling.events.Event")]
	public class SceneManager extends EventDispatcher implements IFeathersEventDispatcher
	{
		/**
		 * @private Variable which contains SceneManager singleton.
		 */
		public static const TYPE_PARTCILE:String = "particle";
		public static const TYPE_IMAGE:String = "image";

		private static var _instance:SceneManager;
		private var _currentID:int;

		public static function get instance():SceneManager
		{
			if( _instance == null )
				_instance = new SceneManager();
				return _instance;
		}

		// TODO: Write a better data structure than dictionary with remove ability.
		private var _images:Dictionary;
		private var _particleSystems:Dictionary;

		public function addImage(id:int, image:Image):void
		{
			if(this._images[id] != null)
				return;
			
			this._images[id] = image;
			this.dispatchEventWith(Event.ADDED, false, {id: id, type: TYPE_IMAGE});
		}

		public function getImage(id:int):Image
		{
			return this._images[id];
		}

		public function removeImage(id:int):void
		{
			this._images[id] = null;
		}

		// [Event(name="added",type="starling.events.Event")]
		public function addParticleSystem(id:int, particleSystem:PDParticleSystem):void
		{
			if(this._particleSystems[id] != null)
				return;
			
			this._particleSystems[id] = particleSystem;
			this.dispatchEventWith(Event.ADDED, false, {id: id, type: TYPE_PARTCILE});
		}

		public function getParticleSystem(id:int):PDParticleSystem
		{
			return this._particleSystems[id];
		}

		public function changeParticleSystem(id:int, key:String, value:*):void
		{
			this._currentID = id;
			if(key == "texture")
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, textureLoader_completeHandler);
				try {
					loader.load(new URLRequest(value));
				}
				catch(e:Error)
				{
					this._particleSystems[id].texture = null;
				}
				return;
			}
			this._particleSystems[id][key] = value;
		}

		public function removeParticleSystem(id:int):void
		{
			this._particleSystems[id] = null;
		}

		protected function textureLoader_completeHandler(e:*):void
		{
			try{
				var bitmap:Bitmap = LoaderInfo(e.target).content as Bitmap;
			}
			catch(e:Error)
			{
					this._particleSystems[this._currentID].texture = null;
			}
			this._particleSystems[this._currentID].texture = Texture.fromBitmap(bitmap) ;
		}

		public function SceneManager()
		{
			super();
			this._images = new Dictionary();
			this._particleSystems = new Dictionary();
		}
	}
}