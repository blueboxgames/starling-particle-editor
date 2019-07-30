package
{
  import com.grantech.screens.MainScreen;
  import com.grantech.utils.Localizations;

  import feathers.controls.Drawers;
  import feathers.controls.StackScreenNavigator;
  import feathers.controls.StackScreenNavigatorItem;
  import feathers.core.IFeathersControl;
  import feathers.themes.MetalWorksDesktopTheme;

  import starling.assets.AssetManager;
  import starling.events.Event;

  public class Main extends Drawers
  {
    static public var theme:MetalWorksDesktopTheme;
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

      this.navigator = new StackScreenNavigator();
      this.content = this.navigator;

      this.addView(MainScreen.NAME, MainScreen);
      
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
      item.setScreenIDForPushEvent(MainScreen.NAME, MainScreen.NAME);
      this.navigator.addScreen(screenType, item);
    }

    /**
     * Reconstruct navigator when localization is changed.
     */
    private function localizations_changeHandler(e:Event):void
    {
      this.navigator.rootScreenID = MainScreen.NAME;
    }
  }
}