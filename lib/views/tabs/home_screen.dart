

import 'package:air_quality/air_quality.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackoverflow_mobile/constants/colors.dart';
import 'package:hackoverflow_mobile/controllers/aqi.dart';
import 'package:hackoverflow_mobile/controllers/gemini.dart';
import 'package:hackoverflow_mobile/controllers/user.dart';
import 'package:hackoverflow_mobile/views/aqi_image_classification.dart';
import 'package:hackoverflow_mobile/views/chatbot.dart';
import 'package:hackoverflow_mobile/views/doctor/doctor_chatting_screen.dart';
import 'package:hackoverflow_mobile/views/tabs/precautions.dart';
import 'package:hackoverflow_mobile/views/tabs/profile.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher_string.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    //required this.onchange
    });
  //final Function onchange;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GeminiAPI geminiAPI = Get.put(GeminiAPI());
  AQIController aqiController = Get.put(AQIController());
  String key = "6e4f6e00feba1e08cc548d4cc9fecc51de355508";
  late AirQuality airQuality;
  late List<AirQualityData> data;
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //aqiController.getAQIData();
    geminiAPI.getGeminiAPIDataShort();
  }
  
  @override
  Widget build(BuildContext context) {

    const apiKey = "AIzaSyA12cj1hCvSAsX4SAQdrqSieirOQYsmQTU"; // Replace with your actual API Key

Future<void> launchMedicMap(LatLng userLocation) async {
  final url = 'https://www.google.com/maps/search/medical+stores+near+@${userLocation.latitude},${userLocation.longitude}';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch Google Maps';
  }
}

Future<void> launchParkMap(LatLng userLocation) async {
  final url = 'https://www.google.com/maps/search/Parks+near+@${userLocation.latitude},${userLocation.longitude}';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch Google Maps';
  }
}
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: (){
            Get.to(ChatBot(),transition: Transition.downToUp, duration: Duration(milliseconds: 300));
          },
        child: Container(
          width: 60,
          height: 60,
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Constants.getColor(77),
          ),
          child: Center(
            child: Icon(Icons.chat,color: Colors.white  ,),
          ),
        ),
      ),
        body:Obx(() =>aqiController.isLoading.value ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: w,
                        height: h * 0.8,
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
                                      //String ans = await geminiAPI.getGeminiData(aqiController.data);
                                      //await aqiController.getAQI(lat, lng)
                                      //print(ans);
                                      //geminiAPI.getGeminiAPIData();
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
                                          image: AssetImage('icons/hamburger.png'),
                                          width: 25,
                                          color: Colors.white,
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
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(ProfilePage());
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
                                        child: Icon(Icons.person_outline,color: Colors.white,)
                                      ),
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
                              child: Text("Hi,There !",style: TextStyle(fontFamily: 'man-b',fontSize: 40,color: Colors.white),),
                            ),
                            SizedBox(height: 0,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage('icons/location.png',),width: 40,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text(/*aqiController.aqiData!.co.toString()*/"Panvel,Mumbai",style: TextStyle(fontFamily: 'man-r',fontSize: 18,color: Colors.white),)
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                                    Text("AQI",style: TextStyle(fontFamily: 'man-l',fontSize: 10,color: Constants.getColor(aqiController.aqiData!.airQualityIndex)),)
                                  ],
                                ),
                              ),
                                ],
                              ),
                              Text(Constants.getTitle(aqiController.aqiData!.airQualityIndex),style: TextStyle(fontSize: 25,color: Constants.getColor(aqiController.aqiData!.airQualityIndex),fontFamily: 'man-sb'),)
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top:  h *0.35,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                          width: w * 0.92,
                          height: h * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(255, 239, 255, 240),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                cData("SO"),
                                cData("SO2"),
                                cData("CO"),
                                cData("C"),


                              ],
                            ),
                          )
                        ),
                      ),
                      Positioned(
                        top: h * 0.5,
                    child: Container(
                      width: w * 0.92,
                      height: h * 0.25,
                      margin: EdgeInsets.all(20),
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:Colors.transparent
                      ),
                      child:geminiAPI.isLoading.value ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10,),
                            Text("Generating Personalized Precautions...",style: TextStyle(fontFamily: 'man-l',fontSize: 13),)
                          ],
                        ),
                      ): Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Precautions",style: TextStyle(fontFamily: 'man-b',fontSize: 20),)
                              ],
                            ),
                            SizedBox(height: 12,),
                            precaution("icons/no-sunlight.png", geminiAPI.precautionShortModel!.p1.toString()),
                            precaution("icons/mask.png",  geminiAPI.precautionShortModel!.p2.toString()),
                            precaution("icons/mask.png",  geminiAPI.precautionShortModel!.p3.toString()),
                            
                            
                          ],
                        ),
                      ),
                    
                    ),
                  ),
                  Positioned(
                    top: h * 0.77,
                    left: 30,
                    child: GestureDetector(
                      child: Container(
                        width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(0, 255, 255, 255),
                          
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Text("Learn More",style: TextStyle(fontFamily: 'man-sb',color: Constants.getColor(22)),),
                              Icon(Icons.arrow_forward_ios_rounded,size: 15,color: Constants.getColor(22)),
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                       // widget.onchange(1);
                       Get.to(PrecautionsPage(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 300));
                      },
                    ),
                  )
                    ],
                  ),
                  
                  Padding(padding: EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(DoctorChatScreen());
                          },
                          child: Container(
                            width: w,
                            height: h * 0.15,
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 209, 234, 255)
                           ),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Breath Free ...", style: TextStyle(fontSize: 22,fontFamily: 'man-sb'),),
                                  SizedBox(height: 4,),
                                  Text("Chat with a Doctor now ", style: TextStyle(fontSize: 14,fontFamily: 'man-r'),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right:-20,
                          child: Transform.rotate(
                            angle: -0.3,
                            child: Image(
                              image: AssetImage("icons/doctor1.png"),
                              width: 150,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right:-10,
                          child: Transform.rotate(
                            angle: -0.3,
                            child: Image(
                              image: AssetImage("icons/medicine1.png"),
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: w * 0.42,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 224, 255, 225)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                            
                                  Text("Find Parks nearest to You .",style: TextStyle(fontFamily: 'man-sb',fontSize: 14),),
                                  SizedBox(height: 35,),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                      Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Constants.getColor(aqiController.aqiData!.airQualityIndex),
                                ),
                                child: Center(
                                  child: Image(image: AssetImage('icons/leaf.png'),width: 14,color: Colors.white,),
                                ),
                              ),
                                       Icon(Icons.arrow_forward_ios,size: 15,color: Constants.getColor(22),),
                                     ],
                                   ),
                                  
                                ],
                              ),
                            ),
                          ),
                          onTap: () async{
                            //LatLng latlng = await userController.getCurrentLocation();
                            //final location = await Geolocator.getCurrentPosition();
                            final userLocation = LatLng(18.8941122,73.1742673);
                            await launchParkMap(userLocation);
                          },
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          child: Container(
                            width: w * 0.42,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 224, 255, 225)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                            
                                  Text("Find Medics Nearest to You .",style: TextStyle(fontFamily: 'man-sb',fontSize: 14),),
                                  
                                   SizedBox(height: 35,),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                      Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Constants.getColor(aqiController.aqiData!.airQualityIndex),
                                ),
                                child: Center(
                                  child: Image(image: AssetImage('icons/leaf.png'),width: 14,color: Colors.white,),
                                ),
                              ),
                                       Icon(Icons.arrow_forward_ios,size: 15,color: Constants.getColor(22),),
                                     ],
                                   ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () async{
                            //LatLng latlng = await userController.getCurrentLocation();
                            //final location = await Geolocator.getCurrentPosition();
                            final userLocation = LatLng(18.8941122,73.1742673);
                            await launchMedicMap(userLocation);
                          },
                        ),
                        
                      ],
                    ),
                  ),
                 
                  SizedBox(height: h * 0.15,)
                    

                ],
              ),
            ),
          ),
        )
        
      
    );
  }

  

  
Widget precaution(icon,title){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    width: MediaQuery.of(context).size.width * 0.8,
    child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration:BoxDecoration(
                                  borderRadius:  BorderRadius.circular(6),
                                  color: Constants.getColor(55)
                                ),child: Center(
                                  child: Image(
                                    image: AssetImage(icon),
                                    width: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width:10 ,),
                              SizedBox(
                                width:  MediaQuery.of(context).size.width * 0.65,
                                child: Text(title,style: const TextStyle(fontFamily: 'man-l',fontSize: 13),maxLines: 2,softWrap: true,))
                            ],
                          ),
  );
}

Widget cData(chemical){
  return Container(
    width: 50,
    height: 100,
    margin: EdgeInsets.only(right: 20,left: 10),
    child: Column(
      children: [
        Text("PM2.5",style: TextStyle(fontFamily: 'man-l',fontSize: 10,color: Constants.getColor(22)),),
        SizedBox(height: 5,),
        Container(
          width: 50,
          height: 50,
          decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: Center(
            child: Text(chemical,style: TextStyle(fontFamily: 'man-l',color: Constants.getColor(28)),),
          ),
        ),
        
        Text("55mg/pm",style: TextStyle(fontFamily: 'man-r',fontSize: 10,color: Constants.getColor(22)),),
      ],
    ),
  );
}


}
