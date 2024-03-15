import 'dart:convert';
import 'dart:ui';

class Constants{
  //static Color green1 = "#8ADAB2";
  static Color getColor(value){
  if(value >0 && value <50){
    return Color.fromARGB(255, 0, 127, 115);
  }else if(value > 50 && value< 100){
    return Color.fromARGB(255, 76, 205, 153);
  }else if(value > 100 && value < 150){
    return Color.fromARGB(255, 255, 199, 0);
  }
  return Color.fromARGB(255, 255, 137, 17);

}

 static String getTitle(value){
  if(value >0 && value <50){
    return "Good";
  }else if(value > 50 && value< 100){
    return "Unhealthy";
  }else if(value > 100 && value < 150){
    return "Worst";
  }
  return 'Terible';
 }

}

