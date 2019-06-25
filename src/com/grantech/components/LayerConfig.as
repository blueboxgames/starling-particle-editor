package com.grantech.components
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;

	import starling.events.Event;

	public class LayerConfig extends LayoutGroup
	{
		private var _label:String;
		private var nameLabel:Label;
		private var removeButton:Button;

		public function get label():String
		{
			return this._label;
		}

		public function set label(value:String):void
		{
			if(value == this._label)
			{
				return;
			}

			this._label = value;
		}

		public function LayerConfig()
		{
			
		}

		override protected function initialize():void
		{
			var containerLayout:HorizontalLayout = new HorizontalLayout();
			containerLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			containerLayout.verticalAlign = VerticalAlign.MIDDLE;
			this.layout = containerLayout;
			this.name = this.label;
			this.nameLabel = new Label();
			this.nameLabel.text = this.label;
			
			this.removeButton = new Button();
			this.removeButton.label = "x";
			this.removeButton.addEventListener(Event.TRIGGERED, disptach_removeParticle);
			this.addChild(nameLabel);
			this.addChild(removeButton);
		}

		private function disptach_removeParticle(e:Event):void
		{
			this.stage.starling.dispatchEventWith("removeParticle", false, { "name": this.nameLabel.text });
		}
	}
}