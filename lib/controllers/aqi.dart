import 'dart:convert';

import 'package:get/get.dart';
import 'package:hackoverflow_mobile/models/aqi_model.dart';
import 'package:http/http.dart' as http;

class AQIController extends GetxController{
  AQIModel? aqiModel;
  Future<void> getAQI(String lat,String lng) async{
    try{
      String url = "https://api.waqi.info/feed/geo:$lat;${lng}/?token=6e4f6e00feba1e08cc548d4cc9fecc51de355508";
      var headers = {
          'Content-Type': 'application/json',
      };
      var response = await http.post(
        Uri.parse(url),
        headers: headers
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        //aqiModel = AQIModel.fromJson(data);
      }else{
        print("Error fetching data");
      }
    }catch(e){
      print("error: $e");
    }
  }
}