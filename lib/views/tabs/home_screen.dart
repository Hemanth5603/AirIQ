
import 'package:air_quality/air_quality.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hackoverflow_mobile/constants/colors.dart';
import 'package:hackoverflow_mobile/controllers/aqi.dart';
import 'package:hackoverflow_mobile/controllers/gemini.dart';
import 'package:skeletonizer/skeletonizer.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GeminiAPI geminiAPI = Get.put(GeminiAPI());
  AQIController aqiController = Get.put(AQIController());
  String key = "6e4f6e00feba1e08cc548d4cc9fecc51de355508";
  late AirQuality airQuality;
  late List<AirQualityData> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //aqiController.getAQIData();
  }
  
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body:Obx(() =>aqiController.isLoading.value ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: w,
                      height: h * 0.5,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 67, 179, 123),
                            Color.fromARGB(255, 255, 255, 255),
                        ],
                        stops: [0.0,0.9]
                        )
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 20,
                      child: Container(
                        width: w * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                GestureDetector(
                                  onTap: () async{
                                    String ans = await geminiAPI.getGeminiData('''
                                      Here is some basic respiratory details of a person aged 53:
{
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
Give me the top 3 precautions that this person can take, in order from most important to moderately important in the following JSON format only:
{
  "topic": "precautions",
  "p1": "/* the most important precaution goes here */",
  "p2": "/* the next most important precaution goes here */",
  "p3": "/* the final most important precaution goes here */"
} inside 'text' key
                                    ''');
                                    print(ans);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: Colors.white,width: 1),
                                      color: Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage('icons/search.png'),
                                      )
                                    ),
                                  ),
                                ),
                              
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.white,width: 1),
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Image(
                                      image: AssetImage('icons/search.png'),
                                      color: Colors.white,
                                    )
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.white,width: 1),
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Image(
                                      image: AssetImage('icons/search.png'),
                                    )
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: h * 0.15,
                      left: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: w,
                            height: 50,
                            child: Text("Hi, Hemanth",style: TextStyle(fontFamily: 'man-b',fontSize: 40,color: Colors.white),),
                          ),
                          SizedBox(height: 0,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('icons/location.png',),width: 40,color: Colors.white,),
                              SizedBox(width: 5,),
                              Text("Visakhapatnam",style: TextStyle(fontFamily: 'man-r',fontSize: 18,color: Colors.white),)
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: h * 0.27,
                      left: 20,
                      child: Container(
                        width: w * 0.9,
                        height: h  * 0.07,
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Row(
                          
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                color: Constants.getColor(aqiController.aqiData!.airQualityIndex),
                              ),
                              child: Center(
                                child: Image(image: AssetImage('icons/leaf.png'),width: 14,color: Colors.white,),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   Text(aqiController.aqiData!.airQualityIndex.toString(),style: TextStyle(fontFamily: 'man-b',fontSize: 32,color: Constants.getColor(aqiController.aqiData!.airQualityIndex)),),
                                  SizedBox(width: 4,),
                                  Text("45",style: TextStyle(fontFamily: 'man-l',fontSize: 10,color: Constants.getColor(aqiController.aqiData!.airQualityIndex)),)
                                ],
                              ),
                            ),
                            SizedBox(width: w * 0.34),
                            Text(Constants.getTitle(aqiController.aqiData!.airQualityIndex),style: TextStyle(fontSize: 25,color: Constants.getColor(aqiController.aqiData!.airQualityIndex),fontFamily: 'man-sb'),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: w,
                  height: 100,
                  margin: EdgeInsets.all(20),
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 239, 239),
                  ),

                )
              ],
            ),
          ),
        )
        
      
    );
  }
}