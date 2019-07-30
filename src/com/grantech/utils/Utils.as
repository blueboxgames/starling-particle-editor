package com.grantech.utils
{
  public class Utils
  {
    static public function colorToHEX(red:int, green:int, blue:int, alpha:Number):String
    {
      var redStr:String = int(red*255).toString(16).length == 2 ? int(red*255).toString(16) : "0" + int(red*255).toString(16);  
      var greenStr:String = int(green*255).toString(16).length == 2 ? int(green*255).toString(16) : "0" + int(green*255).toString(16);  
      var blueStr:String = int(blue*255).toString(16).length == 2 ? int(blue*255).toString(16) : "0" + int(blue*255).toString(16);  
      var alphaStr:String = int(alpha*255).toString(16).length == 2 ? int(alpha*255).toString(16) : "0" + int(alpha*255).toString(16);  
      return "#" + redStr + greenStr + blueStr + alphaStr;
    }
  }
}