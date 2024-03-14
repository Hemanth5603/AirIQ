import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackoverflow_mobile/firebase_options.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: 'AIzaSyDXAIAvZwb-stalz1YtF6TdxDeRgh2PYSw');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
