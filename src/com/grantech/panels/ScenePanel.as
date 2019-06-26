package com.grantech.panels
{
	import feathers.controls.Screen;

	public class ScenePanel extends Screen
	{
		public function ScenePanel()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			this.name = "ScenePanel";
		}
	}
}