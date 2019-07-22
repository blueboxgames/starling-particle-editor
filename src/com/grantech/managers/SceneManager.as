package com.grantech.managers
{
	import feathers.core.IFeathersEventDispatcher;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import starling.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import starling.display.Sprite;
	import starling.events.EventDispatcher;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.display.Image;
	import com.grantech.models.ParticleDataModel;

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
			if(key == "id")
				return;

			if(key == "texture")
			{
				var texture:Texture = AssetManager.instance.getTexture(value);
				if(texture == null)
				{
					AssetManager.instance.load(value);
					AssetManager.instance.addEventListener(Event.COMPLETE, function():void
					{
						texture = AssetManager.instance.getTexture(value);
						this._particleSystems[id].texture = texture;
					});
				}
				else
				{
					this._particleSystems[id].texture = texture;
				}
			}
			else if(key == "blendFuncSource" || key == "blendFuncDestination")
			{
				this._particleSystems[id][key] =  ParticleDataModel.getBlendFunc(value);
			}
			else
			{
				this._particleSystems[id][key] = value;
			}
			this.dispatchEventWith(Event.CHANGE, false, {id: id, type: TYPE_PARTCILE, key: key, value: value});
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

		protected function dataManager_changeHandler(event:Event):void
		{
			if(DataManager.instance.layerAt(DataManager.instance.currentLayerIndex) == null)
				return;
			
			var id:int;
			var key:String;
			var value:*;
			if(DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).type == DataManager.PARTICLE_LAYER)
			{
				id = DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).id;
				key = event.data.key as String;
				value = event.data.value;
				changeParticleSystem(id, key, value);
			}
			if(DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).type == DataManager.IMAGE_LAYER)
			{
				id = DataManager.instance.layerAt(DataManager.instance.currentLayerIndex).id;
				key = event.data.key as String;
				value = event.data.value;
				// changeImage(id, key, value);
			}
		}

		public function SceneManager()
		{
			super();
			this._images = new Dictionary();
			this._particleSystems = new Dictionary();
			DataManager.instance.addEventListener(Event.CHANGE, dataManager_changeHandler);
		}

		public function dispose():void{
			DataManager.instance.removeEventListener(Event.CHANGE, dataManager_changeHandler);
			_instance = null;
		}
	}
}