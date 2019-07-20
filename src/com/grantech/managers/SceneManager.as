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

	public class SceneManager extends EventDispatcher implements IFeathersEventDispatcher
	{
		/**
		 * @private Variable which contains SceneManager singleton.
		 */
		private static var _instance:SceneManager;
		private var _currentID:int;

		public static function get instance():SceneManager
		{
			if( _instance == null )
				_instance = new SceneManager();
				return _instance;
		}

		// TODO: Write a better data structure than dictionary with remove ability.
		private var _sprites:Dictionary;
		private var _particleSystems:Dictionary;

		public function addSprite(id:int, sprite:Sprite):void
		{
			this._sprites[id] = sprite;
		}

		public function getSprite(id:int):Sprite
		{
			return this._sprites[id];
		}

		public function removeSprite(id:int):void
		{
			this._sprites[id] = null;
		}

		public function addParticleSystem(id:int, particleSystem:PDParticleSystem):void
		{
			this._particleSystems[id] = particleSystem;
		}

		public function getParticleSystem(id:int):PDParticleSystem
		{
			return this._particleSystems[id];
		}

		public function changeParticleSystem(id:int, key:String, value:*):void
		{
			this._currentID = id;
			if(key == "x")
			{
				this._particleSystems[id].x = value;
				return;
			}
			if(key == "y")
			{
				this._particleSystems[id].y = value;
				return;
			}
			if(key == "texture")
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, textureLoader_completeHandler);
				try {
					loader.load(new URLRequest(value));
				}
				catch(e:Error)
				{
					this._particleSystems[this._currentID].texture = null;
				}
				return;
			}
			this._particleSystems[id][key] = value;
		}

		public function removeParticleSystem(id:int):void
		{
			this._particleSystems[id] = null;
		}

		public function reloadParticleSystem(id:int):void
		{
			this.changeParticleSystem(id, "texture", this._particleSystems[id].texture);
			this._particleSystems[id] = new PDParticleSystem(this._particleSystems[id],null);
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
			this._sprites = new Dictionary();
			this._particleSystems = new Dictionary();
		}
	}
}