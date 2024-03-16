import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hackoverflow_mobile/firebase_options.dart';
import 'package:hackoverflow_mobile/views/form.dart';
import 'package:hackoverflow_mobile/views/home.dart';
import 'package:hackoverflow_mobile/views/login.dart';
import 'package:hackoverflow_mobile/views/onBoarding.dart';
import 'package:hackoverflow_mobile/views/signup.dart';
import 'package:hackoverflow_mobile/views/tabs/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    )
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if(auth.currentUser != null){
      return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Home()
      ),
    );
    }else{
      return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: OnBoarding()
      ),
    );
    }
    
    
  }
}
