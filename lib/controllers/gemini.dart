import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hackoverflow_mobile/models/precaution_long_model.dart';
import 'package:http/http.dart' as http;

class GeminiAPI{

    PrecautionLongModel? precautionLongModel;
    var isLoading = false.obs;

  static Future<Map<String, String>> getHeader()async{
    return {
      'Content-Type': 'application/json',
    };
  }

  Future<String> getGeminiData(message) async{
    try{
      final header = await getHeader();
      final Map<String, dynamic> requestBody = {
        'contents':[
          {
            'parts':[
              {
                'text':'user message request here $message'
              }
            ]
          }
        ],
        'generationConfig':{
          'temperature': 0.8,
           'maxOutputTokens': 2048,
        }
      };

      String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=AIzaSyDiWaCOr-hqvR95YL7NalbjUtaR1pElrKU";
      var response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(requestBody),
      );

      if(response.statusCode == 200){
        var jsonResponse = jsonDecode(response.body) as Map<String,dynamic>;
        print(response.body.toString());
        return jsonResponse['candidates'][0]['content']['parts'][0]['text'];

      }else{
        return 'cannot post api some error ${response.statusCode.toString()}';
      }

    }catch(e){
      if(kDebugMode) print("error $e");
    }

    return 'null data';
  }


  Future<void> getGeminiAPIData()async{
    isLoading(true);
    var body = {
      "lat":18.89,
      "lon":73.17,
      "pData":{
        "breathness":"severe",
        "interest_smooking":"Yes"
      }
    };
  
    String url = "https://air-iq-bc.onrender.com/precautions/long";
    print("called");
    try{
      var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body)
    );

    if(response.statusCode== 200){
      var data = jsonDecode(response.body.toString());
      print(data.toString());
      precautionLongModel = PrecautionLongModel.fromJson(data);
    }else{
      print("Error fetching api");
    }
    isLoading(false);

    }catch(e){
      print("error: $e");

    }
    

    

  }






}