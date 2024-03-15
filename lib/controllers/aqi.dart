import 'dart:convert';

import 'package:air_quality/air_quality.dart';
import 'package:get/get.dart';
import 'package:hackoverflow_mobile/models/aqi_model.dart';
import 'package:http/http.dart' as http;

class AQIController extends GetxController{
  AirQualityData? aqiData;
    late AirQuality airQuality;
    late List<AirQualityData> data;
    String key = "6e4f6e00feba1e08cc548d4cc9fecc51de355508";

  Future<void> getAQIData() async{
    airQuality = AirQuality(key);
    aqiData =  await airQuality.feedFromCity('delhi');
  }
  var isLoading = false.obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    isLoading(true);
    await getAQIData();
    isLoading(false);
  }

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
        aqiModel = AQIModel.fromJson(data);
      }else{
        print("Error fetching data");
      }
    }catch(e){
      print("error: $e");
    }
  }
}