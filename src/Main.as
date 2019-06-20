package
{
  import feathers.controls.Drawers;
  import feathers.controls.StackScreenNavigator;
  import feathers.controls.StackScreenNavigatorItem;
  import feathers.core.IFeathersControl;
  import feathers.themes.MetalWorksDesktopTheme;

  import flash.geom.Rectangle;

  import panels.MainPanel;

  import starling.core.Starling;
  import starling.events.Event;
  import starling.events.ResizeEvent;

  public class Main extends Drawers
  {
    /**
     * @private
     */
    private var _viewPort:Rectangle =  Starling.current.viewPort;
    private var navigator:StackScreenNavigator;

    public function Main(content:IFeathersControl=null)
    {
      new MetalWorksDesktopTheme();
      super(content);
    }

    override protected function initialize():void
    {
      super.initialize();
      this.stage.addEventListener(ResizeEvent.RESIZE, stage_onResizeHandler);

      this.navigator = new StackScreenNavigator();
      this.content = this.navigator;

      this.addView(MainPanel.NAME, MainPanel);
      this.navigator.rootScreenID = MainPanel.NAME;
    }

    private function addView(screenType:String, screenClass:Object, pushTranstion:Function = null, popTranstion:Function = null) : void
    {
      var item:StackScreenNavigatorItem = new StackScreenNavigatorItem(screenClass);
      if( pushTranstion != null )
        item.pushTransition = pushTranstion;
      if( popTranstion != null )
        item.popTransition = popTranstion;
      item.addPopEvent(Event.COMPLETE);
      item.setScreenIDForPushEvent(MainPanel.NAME, MainPanel.NAME);
      this.navigator.addScreen(screenType, item);
    }

    private function stage_onResizeHandler(e:ResizeEvent):void
    {
      this._viewPort.width = e.width , this._viewPort.height = e.height;
      Starling.current.viewPort = this._viewPort;

      this.stage.stageWidth = e.width, this.stage.stageHeight = e.height;
    }
  }
}