package
{
  import com.grantech.utils.Localizations;
  import com.grantech.views.MainView;

  import feathers.controls.Drawers;
  import feathers.controls.StackScreenNavigator;
  import feathers.controls.StackScreenNavigatorItem;
  import feathers.core.IFeathersControl;
  import feathers.themes.MetalWorksDesktopTheme;

  import flash.geom.Rectangle;

  import starling.assets.AssetManager;
  import starling.core.Starling;
  import starling.events.Event;
  import starling.events.ResizeEvent;

  public class Main extends Drawers
  {
    static public var theme:MetalWorksDesktopTheme;
    /**
     * Main stage viewport.
     */
    private var viewPort:Rectangle =  Starling.current.viewPort;
    /**
     *Navigator through the screens.
     */
    private var navigator:StackScreenNavigator;

    /**
     * @private Constructor.
     */
    public function Main(content:IFeathersControl=null)
    {
      theme = new MetalWorksDesktopTheme();
      super(content);
    }

    /**
     * Initialize navigator, screens and localizations.
     */
    override protected function initialize():void
    {
      super.initialize();
      
      this.stage.addEventListener(ResizeEvent.RESIZE, stage_onResizeHandler);

      this.navigator = new StackScreenNavigator();
      this.content = this.navigator;

      this.addView(MainView.NAME, MainView);
      
      Localizations.instance.addEventListener(Event.CHANGE, localizations_changeHandler);
      Localizations.instance.changeLocale("en_US", new AssetManager());
    }

    /**
     * Adds a new view to main navigator.
     */
    private function addView(screenType:String, screenClass:Object, pushTranstion:Function = null, popTranstion:Function = null) : void
    {
      var item:StackScreenNavigatorItem = new StackScreenNavigatorItem(screenClass);
      if( pushTranstion != null )
        item.pushTransition = pushTranstion;
      if( popTranstion != null )
        item.popTransition = popTranstion;
      item.addPopEvent(Event.COMPLETE);
      item.setScreenIDForPushEvent(MainView.NAME, MainView.NAME);
      this.navigator.addScreen(screenType, item);
    }

    /**
     * Changes viewport accordingly.
     */
    private function stage_onResizeHandler(e:ResizeEvent):void
    {
      this.viewPort.width = e.width , this.viewPort.height = e.height;
      Starling.current.viewPort = this.viewPort;

      this.stage.stageWidth = e.width, this.stage.stageHeight = e.height;
    }

    /**
     * Reconstruct navigator when localization is changed.
     */
    private function localizations_changeHandler(e:Event):void
    {
      this.navigator.rootScreenID = MainView.NAME;
    }
  }
}