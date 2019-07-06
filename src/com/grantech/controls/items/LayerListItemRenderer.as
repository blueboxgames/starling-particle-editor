package com.grantech.controls.items
{
	import feathers.controls.Label;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Quad;

	public class LayerListItemRenderer extends AbstractTouchableListItemRenderer
	{
		public function LayerListItemRenderer()
		{
			super();
		}
		
		private var layerName:Label;

		override protected function initialize():void
		{
			super.initialize();

			_backgroundDisabledSkin = new Quad(1,1, 0x333333);
			_backgroundSelectedSkin = new Quad(1,1, 0x444444);

			this.layout = new AnchorLayout();;

			this.layerName = new Label();
			this.layerName.layoutData = new AnchorLayoutData(NaN, NaN, 4, 4);
			this.addChild(layerName);
		}

		override protected function commitData():void
		{
			super.commitData();
			
			if (this.data != null )
			{
				var id:String = this.data.id.toString();
				var order:String = this.data.order.toString();
			}
			this.layerName.text = "Layer: " + id + "  Order: " + order;
			this.layerName.invalidate(INVALIDATION_FLAG_DATA);
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			backgroundSkin = value ? _backgroundSelectedSkin : _backgroundDisabledSkin;
		}
	}
}