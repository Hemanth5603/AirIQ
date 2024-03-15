import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';


import 'package:get/get_core/src/get_main.dart';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:hackoverflow_mobile/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController{

 TextEditingController healthConditions  = TextEditingController();

 TextEditingController nameController  = TextEditingController();
 TextEditingController emailController  = TextEditingController();
 TextEditingController passwordController  = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;





  /*Future<void> getCurrentPosition() async {
    bool serviceEnabled = false;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please keep your location enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location Permission denied!');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location Permission denied Forever!');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      //List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      //Placemark place = placemarks[0];

      //userModel.value.latitude = position.latitude;
      //userModel.value.longitude = position.longitude;
      //userModel.value.location ="${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}".obs();
      //location =  "${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}".obs();
      //prefs.setString('loaction', location);
    } catch (e) {
      print(e);
    }
    //print("Address : ${userModel.value.location}");
    //print(userModel.value.latitude);
    //print(userModel.value.longitude);
  }*/


  void signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential response =await FirebaseAuth.instance.signInWithCredential(credential);
      try {
        final user = response.user;
        print("user uid: ${user!.uid.toString()}");
        //await getUserId();
        print("username: ${response.additionalUserInfo?.username.toString()}");
        //userController.userModel.value.profile =response.additionalUserInfo?.profile.toString();

      }catch (e) {
        print("Cannot get user information");
        print(e);
      }
      
    if(response.credential!= null){
      Get.offAll(const Home(),duration:const Duration(milliseconds: 400),transition: Transition.downToUp);
    }else{
      Get.snackbar('Error', 'Google sign in error');
    }
  }


  Future<void> createUser(uid) async{
    try{
      final ref = FirebaseFirestore.instance
        .collection("users").doc(uid);
      
      await ref.set({
        "name": nameController.text,
        "email":emailController.text,
        "password":passwordController.text
      });

    }catch(e){
      print("error $e");
    }
  }

   Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          print("Sign up successfully"
          );
          await createUser(credential.user!.uid.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The email address is already in Use.');
      } else {
        print('An error occured: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
          print("User loggedin ////////////----------");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print('Invalid email or password');
      } else {
        print('An error occurred:${e.code}');
      }
    }
    return null;
  }


  void _signIn() async {
    
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully signedIn");
      
          Get.to(const Home());
    } else {
      print("User is un - successfully signedIn");
    }
  }





 
}