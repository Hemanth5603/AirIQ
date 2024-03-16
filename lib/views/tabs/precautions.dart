import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hackoverflow_mobile/constants/colors.dart';
import 'package:hackoverflow_mobile/controllers/aqi.dart';
import 'package:hackoverflow_mobile/controllers/gemini.dart';

class PrecautionsPage extends StatefulWidget {
  const PrecautionsPage({super.key});

  @override
  State<PrecautionsPage> createState() => _PrecautionsPageState();
}

class _PrecautionsPageState extends State<PrecautionsPage> {

  GeminiAPI geminiAPI = Get.put(GeminiAPI());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geminiAPI.getGeminiAPIData();

  }
  @override
  Widget build(BuildContext context) {
    AQIController aqiController = Get.put(AQIController());
  
    
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){

          },
        ),
        title: Text("Precautions for You",style: TextStyle(fontFamily: 'man-sb',fontSize: 18),),
      ),
      body: SafeArea(
        child:Obx(() => geminiAPI.isLoading.value ? Center(child: CircularProgressIndicator()) : Container(
          width: w,
          height: h,
          margin: EdgeInsets.all(15),
          
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color.fromARGB(255, 234, 255, 235),),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    ),SizedBox(width: 7,),
                       Container(
                        width: w * 0.78,
                        height: h * 0.16,
                        child: 
                        Text(geminiAPI.precautionLongModel?.paragraphs[0].toString() ?? '''Air Quality: Moderate Risk for Sensitive Groups, paragraphs: [Air quality in Taipei is currently moderate, with an AQI of 120. ''',style: TextStyle(fontFamily: 'man-r',fontSize: 16,height: 1.5),), 
                        ),
                     ],
                   ),
                   precaution(w, h, aqiController,geminiAPI.precautionLongModel?.paragraphs[1].toString()),
                   precaution(w, h, aqiController,geminiAPI.precautionLongModel?.paragraphs[2].toString()),
                   precaution(w, h, aqiController,geminiAPI.precautionLongModel?.paragraphs[3].toString()),
                   SizedBox(height: h * 0.3,)
                ],
              ),
            ),
          ),
        ),

      )
    )
    );
  }
  
}


Widget precaution(w,h,aqiController,geminiAPIData){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    ),SizedBox(width: 7,),
                       Container(
                        width: w * 0.78,
                        height: h * 0.16,
                        child: 
                        Text(geminiAPIData ?? '''This means that the air quality is acceptable for most people, but sensitive groups such as the elderly, children, and those with respiratory conditions may experience some discomfort. The dominant pollutant is PM2.5, which is particulate matter with a diameter of 2.5 micrometers or less., PM2.5 can be harmful to health, as it can penetrate deep into the lungs and cause respiratory problems such as asthma, bronchitis, and lung cancer.  ''',style: TextStyle(fontFamily: 'man-r',fontSize: 16,height: 1.5),), 
                        ),
                     ],
                   ),
  );
}