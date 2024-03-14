import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GeminiAPI{

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
        return jsonResponse['candidates'][0]['content']['parts'][0]['text'];
      }else{
        return 'cannot post api some error';
      }

    }catch(e){
      if(kDebugMode) print("error $e");
    }

    return 'null data';
  }
}