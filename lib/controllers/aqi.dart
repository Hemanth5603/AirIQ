import 'dart:convert';

import 'package:air_quality/air_quality.dart';
import 'package:get/get.dart';
import 'package:hackoverflow_mobile/models/aqi_model.dart';
import 'package:http/http.dart' as http;

class AQIController extends GetxController{
  String data  = '''
                                      Here is some basic respiratory details of a person aged 53{
                                      "Please enter your respiratory health conditions": "all okay",
                                      "Do you use oxygen or peak flow meter?": "no",
                                      "Do you use home respiratory equipment?": "no",
                                      "Current medications, herbs, or supplements?": "none",
  "Breathlessness level": "No",
  "Smoking/Vaping status": "No",
  "Interest in quitting smoking/vaping?": "Doesn't apply"
}
And here is the current aqi index details and other atmospheric gas levels:
{
  "status": "ok",
  "data": {
    "aqi": 151,
    "idx": 1451,
    "attributions": [
      {
        "url": "http://www.bjmemc.com.cn/",
        "name": "Beijing Environmental Protection Monitoring Center (北京市环境保护监测中心)"
      },
      {
        "url": "https://waqi.info/",
        "name": "World Air Quality Index Project"
      }
    ],
    "city": {
      "geo": [
        39.954592,
        116.468117
      ],
      "name": "Beijing (北京)",
      "url": "https://aqicn.org/city/beijing",
      "location": ""
    },
    "dominentpol": "pm25",
    "iaqi": {
      "co": {
        "v": 6.4
      },
      "h": {
        "v": 45
      },
      "no2": {
        "v": 14.2
      },
      "o3": {
        "v": 30.5
      },
      "p": {
        "v": 1016
      },
      "pm10": {
        "v": 83
      },
      "pm25": {
        "v": 151
      },
      "so2": {
        "v": 2.6
      },
      "t": {
        "v": 8
      },
      "w": {
        "v": 1.5
      }
    },
    "time": {
      "s": "2024-03-15 00:00:00",
      "tz": "+08:00",
      "v": 1710460800,
      "iso": "2024-03-15T00:00:00+08:00"
    },
    "forecast": {
      "daily": {
        "o3": [
          {
            "avg": 1,
            "day": "2024-03-13",
            "max": 10,
            "min": 1
          },
          {
            "avg": 2,
            "day": "2024-03-14",
            "max": 12,
            "min": 1
          },
          {
            "avg": 7,
            "day": "2024-03-15",
            "max": 26,
            "min": 1
          },
          {
            "avg": 5,
            "day": "2024-03-16",
            "max": 11,
            "min": 1
          },
          {
            "avg": 10,
            "day": "2024-03-17",
            "max": 19,
            "min": 4
          },
          {
            "avg": 3,
            "day": "2024-03-18",
            "max": 12,
            "min": 1
          },
          {
            "avg": 12,
            "day": "2024-03-19",
            "max": 18,
            "min": 9
          }
        ],
        "pm10": [
          {
            "avg": 58,
            "day": "2024-03-13",
            "max": 73,
            "min": 34
          },
          {
            "avg": 46,
            "day": "2024-03-14",
            "max": 58,
            "min": 28
          },
          {
            "avg": 44,
            "day": "2024-03-15",
            "max": 58,
            "min": 28
          },
          {
            "avg": 44,
            "day": "2024-03-16",
            "max": 58,
            "min": 28
          },
          {
            "avg": 42,
            "day": "2024-03-17",
            "max": 123,
            "min": 18
          },
          {
            "avg": 43,
            "day": "2024-03-18",
            "max": 121,
            "min": 19
          },
          {
            "avg": 49,
            "day": "2024-03-19",
            "max": 60,
            "min": 31
          },
          {
            "avg": 47,
            "day": "2024-03-20",
            "max": 51,
            "min": 44
          }
        ],
        "pm25": [
          {
            "avg": 123,
            "day": "2024-03-13",
            "max": 138,
            "min": 89
          },
          {
            "avg": 129,
            "day": "2024-03-14",
            "max": 155,
            "min": 88
          },
          {
            "avg": 122,
            "day": "2024-03-15",
            "max": 159,
            "min": 68
          },
          {
            "avg": 107,
            "day": "2024-03-16",
            "max": 158,
            "min": 48
          },
          {
            "avg": 79,
            "day": "2024-03-17",
            "max": 138,
            "min": 40
          },
          {
            "avg": 97,
            "day": "2024-03-18",
            "max": 138,
            "min": 42
          },
          {
            "avg": 86,
            "day": "2024-03-19",
            "max": 121,
            "min": 61
          },
          {
            "avg": 117,
            "day": "2024-03-20",
            "max": 138,
            "min": 68
          }
        ],
        "uvi": [
          {
            "avg": 0,
            "day": "2022-10-24",
            "max": 1,
            "min": 0
          }
        ]
      }
    },
    "debug": {
      "sync": "2024-03-15T01:45:56+09:00"
    }
  }
}
Give me the top 3 precautions that this person can take, in order from most important to moderately important in stringified JSON format:
{
  "topic": "precautions",
  "p1": "/* the most important precaution goes here */",
  "p2": "/* the next most important precaution goes here */",
  "p3": "/* the final most important precaution goes here */"
}''';





    AirQualityData? aqiData;
    String topic = "";
    String p1 = "";
    String p2 = "";
    String p3 = "";

    late AirQuality airQuality;
    late List<AirQualityData> dataa;
    String key = "6e4f6e00feba1e08cc548d4cc9fecc51de355508";

  Future<void> getAQIData() async{
    airQuality = AirQuality(key);
    aqiData =  await airQuality.feedFromCity('mumbai');
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