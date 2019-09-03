package com.grantech.controls.displays
{
	import com.grantech.models.LayerDataModel;

	public interface ISceneObject
	{
		function get layer():LayerDataModel;
		function set layer(value:LayerDataModel):void;
		function hasOwnProperty(V:*):Boolean;
	}
}