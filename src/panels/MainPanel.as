package panels
{
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;

	import starling.events.Event;
	import feathers.controls.Button;
	import starling.display.DisplayObject;
	import flash.display.NativeWindowSystemChrome;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import flash.desktop.NativeApplication;
	import starling.events.TouchPhase;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.geom.Rectangle;
	import starling.events.ResizeEvent;
	import flash.display.NativeWindowResize;
	import starling.core.Starling;
	import flash.events.NativeWindowBoundsEvent;
	import feathers.controls.List;
	import feathers.data.ArrayCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.controls.Toolbar;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	public class MainPanel extends PanelScreen
	{
		static public const NAME:String = "mainView";

		private var _window:NativeWindow = NativeApplication.nativeApplication.activeWindow;
		private var _viewPort:Rectangle = _window.bounds.clone();

		public function MainPanel()
		{
			super();
		}

		private function toolbarFactory():List
		{
			var toolbar:List = new List();
			var fileButton:Button = new Button();
			fileButton.label = "File";

			var editButton:Button = new Button();
			editButton.label = "Edit";
			editButton.addEventListener(Event.TRIGGERED, function(e:Event):void
			{
				var editCollection:List = new List();
				editCollection.dataProvider = ArrayCollection(["Undo", "Redo"]);
				this.addChild( editCollection );
			});
			
			var toolbarCollection:ArrayCollection = new ArrayCollection([fileButton, editButton]);
			toolbar.layout = new HorizontalLayout();
			toolbar.dataProvider = toolbarCollection;
			toolbar.addEventListener(Event.CHANGE, function(e:Event):void
			{
				var list:List = List( e.currentTarget );
    		if ( list.selectedIndex == 0 )
				{
					// File Selected
					var fileCollection:List = new List();
					fileCollection.dataProvider = new ArrayCollection(["New", "Save"]);
					this.addChild( fileCollection );
				}
			});
			return toolbar;
		}

		private function fileFactory():Button
		{
			var fileButton:Button = new Button();
			fileButton.label = "File";
			fileButton.addEventListener(Event.TRIGGERED, function(e:Event):void
			{
				var fileCollection:List = new List();
				fileCollection.dataProvider = new ArrayCollection(["New", "Save"]);
				this.addChild( fileCollection );
			});
			return fileButton;
		}

		override protected function initialize():void
    {
			super.initialize();
			this.title = "Integer";

			this.headerFactory = function():Header
			{
				var header:Toolbar = new Toolbar();
				header.addEventListener(TouchEvent.TOUCH, header_touchHandler);

				return header;
			}
			this.layout = new HorizontalLayout();
			this.layoutData = new AnchorLayoutData(0,0,0,0,NaN,NaN);

			var scene:SceneView = new SceneView();
			var toolbar:ToolsPanel = new ToolsPanel();
			toolbar.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				scene.dispatchEventWith("particleDataRecieved", false, e.data);
			});
			
			toolbar.addEventListener("particleChange", function(e:Event):void
			{
				scene.dispatchEventWith("particleChange", false, e.data);
			});
			scene.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				toolbar.dispatchEventWith("particleData", false, e.data);
			});

			this.addChild(scene);
			this.addChild(toolbar);
		}

		private function header_touchHandler(e:TouchEvent):void
		{
			var window:NativeWindow = NativeApplication.nativeApplication.activeWindow;
			var touch:Touch = e.getTouch(this, null, 0);
			if( touch != null )
			{
				if( touch.phase == TouchPhase.MOVED )
				{
					if ( window.displayState == NativeWindowDisplayState.MAXIMIZED )
					{
						window.restore();
						window.y = 10;
						window.x = _viewPort.x;
						window.width = stage.width;
						window.height = stage.height;
						
					}
					window.startMove();
				}
				else if( touch.phase == TouchPhase.ENDED && touch.tapCount > 1 )
				{	
					if( window.displayState == NativeWindowDisplayState.NORMAL )
					{
						window.maximize();
						return;
					}
					window.restore();
				}
			}
		}
	}
}