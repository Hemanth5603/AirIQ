import 'package:air_quality/air_quality.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hackoverflow_mobile/controllers/aqi.dart';
import 'package:hackoverflow_mobile/controllers/gemini.dart';




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
    airQuality = AirQuality(key);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        child: Container(
          width: w,
          height: h * 0.06,
          color: const Color.fromARGB(255, 4, 56, 99),
        ),
        onTap: ()async {
          //String result = await geminiAPI.getGeminiData("What is an apple, and its health belifits");
          //print(result);
          //AirQualityData aqi = await airQuality.feedFromCity('delhi');
          //print("AQI data: $aqi");
          await aqiController.getAQI("19.0272734","73.1138537");
          print(aqiController.aqiModel?.data.aqi.toString());
        },
      ),
      body:  SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: w,
                    height: h * 0.4,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color.fromARGB(163, 0, 139, 245),
                          Color.fromARGB(255, 255, 255, 255),
                        
                      ],
                      stops: [0.0,.9]
                      )
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      
    );
  }
}