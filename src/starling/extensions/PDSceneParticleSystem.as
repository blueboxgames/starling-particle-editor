package starling.extensions
{
	import starling.textures.Texture;
	import starling.display.ISceneObject;

	public class PDSceneParticleSystem extends PDParticleSystem implements ISceneObject
	{
		public function PDSceneParticleSystem(uid:int, config:Object, texture:Texture)
		{
			super(config, texture);
			this._id = uid;
		}

		private var _id:int;

		public function get id():int
		{
			return this._id;
		}

		public function set id(value:int):void
		{
			this._id = value;
		}
	}
}