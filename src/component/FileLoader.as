package component
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	import feathers.core.IFeathersControl;
	import feathers.layout.HorizontalLayoutData;
	import starling.events.Event;
	import flash.net.FileReference;
	import flash.events.Event;

	public class FileLoader extends FeathersControl implements IFeathersControl
	{
		protected static const INVALIDATION_FLAG_LABEL_FACTORY:String = "labelFactory";
		protected static const INVALIDATION_FLAG_NAME_TEXT_FACTORY:String = "nameTextFactory";
		protected static const INVALIDATION_FLAG_BROWSE_FACTORY:String = "browseFactory";

		public function FileLoader()
		{
			super();
		}

		private var _label:String = null;
		private var _file:FileReference = new FileReference();

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			if(_label == value)
			{
				return;
			}
			_label = value;
		}

		protected var labelC:Label;
		protected var nameHolderC:TextInput;
		protected var browseButtonC:Button;

		protected function createLabelComponent():void
		{
			if(this.labelC)
			{
				this.labelC.removeFromParent(true);
				this.labelC = null;
			}

			this.labelC = new Label();
			this.labelC.text = this.label;
			this.addChild(this.labelC);
			
			this.labelC.initializeNow();
		}

		protected function createNameHolderComponent():void
		{
			if(this.nameHolderC)
			{
				this.nameHolderC.removeFromParent(true);
				this.nameHolderC = null;
			}

			this.nameHolderC = new TextInput();
			this.nameHolderC.isFocusEnabled = !this._focusManager;
			this.addChild(this.nameHolderC);
			
			this.nameHolderC.initializeNow();
		}

		protected function createBrowseButtonComponent():void
		{
			if(this.browseButtonC)
			{
				this.browseButtonC.removeFromParent(true);
				this.browseButtonC = null;
			}

			this.browseButtonC = new Button();
			this.browseButtonC.label = "Browse";
			this.browseButtonC.isFocusEnabled = !this._focusManager;
			this.browseButtonC.addEventListener(starling.events.Event.TRIGGERED, browseComponent_triggeredHandler);
			this.addChild(this.browseButtonC);
			
			this.browseButtonC.initializeNow();
		}

		protected function layoutChildren():void
		{
			this.layoutData = new HorizontalLayoutData();
			this.labelC.x = 0;
			this.labelC.validate();
			this.labelC.y = (this.labelC.height)/4;
			this.labelC.validate();

			this.nameHolderC.x = this.labelC.x + this.labelC.width + 5;
			this.nameHolderC.y = 0;
			this.nameHolderC.validate();

			this.browseButtonC.x = this.nameHolderC.x + this.nameHolderC.width + 5;
			this.browseButtonC.y = 0;
			this.browseButtonC.validate();

		}

		override protected function draw():void
		{
			super.draw();
			var labelFactoryInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_LABEL_FACTORY);
			var nameTextFactoryInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_NAME_TEXT_FACTORY);
			var browseFactoryInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_BROWSE_FACTORY);
			
			if(labelFactoryInvalid)
			{
				this.createLabelComponent();
			}

			if(nameTextFactoryInvalid)
			{
				this.createNameHolderComponent();
			}

			if(browseFactoryInvalid)
			{
				this.createBrowseButtonComponent();
			}
			this.validate();

			this.layoutChildren();
		}

		private function browseComponent_triggeredHandler(e:starling.events.Event):void
		{
			_file.browse();
			_file.addEventListener(flash.events.Event.SELECT, file_selectHandler);
			
		}

		private function file_selectHandler(e:flash.events.Event):void
		{
			_file.addEventListener(flash.events.Event.COMPLETE, file_completeHandler);
			this.nameHolderC.text = _file.name;
			this.nameHolderC.invalidate(INVALIDATION_FLAG_DATA);
			_file.load();
		}

		private function file_completeHandler(e:flash.events.Event):void
		{
			this.dispatchEventWith(starling.events.Event.COMPLETE, false, _file);
		}
	}
}